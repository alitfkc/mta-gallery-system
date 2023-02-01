local changed_global_vehicle = {}
info_vehicle_list = {}
----------------------------------------------------------
--send player vehicles ( - oyuncu araçlarını gönder - )
----------------------------------------------------------
function player_login(_,account)
    local account_name = getAccountName(account)
    local player_vehicles_s = {}
    if global_player_vehicle[account_name] then 
        player_vehicles_s = global_player_vehicle[account_name]
    end
    triggerClientEvent(source,"send_player_vehicles",source,player_vehicles_s)
    triggerClientEvent(source,"send_player_infos_vehicles",source,toJSON(info_vehicle_list) or {})
end
local function restart_s()
    for k,v in pairs(getElementsByType("player")) do 
        local account = getPlayerAccount(v)
        if account then 
            local account_name = getAccountName(account)
            local player_vehicles_s = {}
            if global_player_vehicle[account_name] then 
                player_vehicles_s = global_player_vehicle[account_name]
                triggerClientEvent(v,"send_player_vehicles",v,player_vehicles_s)
            end
            --triggerClientEvent("send_player_vehicles",v,player_vehicles_s,toJSON(info_vehicle_list))
        end
    end
end
setTimer(restart_s,800,1)
addEventHandler("onPlayerLogin",root,player_login)


-----------------------------------------------------------------------
-- create player vehicle ( - oyuncu araç oluşturma - )
------------------------------------------------------------------------
created_player_vehicles = {}
damage_vehicle = {}
function create_player_veh(id,model,stats,account_name,veh_name)
    takePlayerMoney(source,vehicle_delivery_fee)
    local ox,oy,oz = getElementPosition(source)
    local _,_,rz = getElementRotation(source)
    local veh = createVehicle(model,ox,oy,oz+0.5,0,0,rz)
    stats = fromJSON(stats)
    setVehicleColor(veh,stats.r,stats.g,stats.b)
    warpPedIntoVehicle(source,veh)
    local player_veh = created_player_vehicles[source] 
    if player_veh then 
        table.insert(player_veh,{id,veh})
    else
        player_veh = {}
        table.insert(player_veh,{id,veh})
    end
    created_player_vehicles[source] = player_veh
    damage_vehicle[veh] = {id,veh,source}
    info_vehicle_list[veh] = {veh,id,account_name,veh_name,source} 
    setElementID(veh,"arac"..id)
    for k,v in ipairs(getElementsByType("player")) do 
        triggerClientEvent(v,"send_info_veh",v,{veh,id,account_name,veh_name})
    end
end
addEvent("create_vehicle",true)
addEventHandler("create_vehicle",root,create_player_veh)
----------------------------------------------------------------------------------
-- delete player vehicle ( - oyuncu araç kaldırma - )
----------------------------------------------------------------------------------
function delete_player_veh(id)
    local player_veh = created_player_vehicles[source]
    for k,v in ipairs(player_veh) do 
        if id == v[1] then 
            takePlayerMoney(source,vehicle_delivery_fee)
            save_vehicle_stats(source,id,v[2])
            local veh_player = getVehicleOccupant(v[2])
            if veh_player then 
                removePedFromVehicle(veh_player)
            end
            damage_vehicle[v[2]] = nil
            info_vehicle_list[v[2]] = nil
            destroyElement(v[2])
            table.remove(player_veh,k)
            created_player_vehicles[source] = player_veh
            break
        end
    end
end
addEvent("delete_vehicle",true)
addEventHandler("delete_vehicle",root,delete_player_veh)
--------------------------------------------------------------------------------------
-- save vehicle stats ( - araç statlarını tabloya kayıt et - ) - server
---------------------------------------------------------------------------------------
function save_vehicle_stats(player,id,veh)
    local account_name = getAccountName(getPlayerAccount(player))
    local r,g,b = getVehicleColor(veh,true)
    local player_vehicles = global_player_vehicle[account_name]
    for k,v in ipairs(player_vehicles) do 
        if v[1] == id then 
            local stats = fromJSON(v[5])
            stats.r = r 
            stats.g = g 
            stats.b = b
            stats = toJSON(stats)
            triggerClientEvent(player,"save_player_vehicle_stats",player,id,stats)
            v[5] = stats
            global_player_vehicle[account_name] = player_vehicles
            save_global_changed_veh(account_name,stats,id)
            break
        end
    end
end

-----------------------------------------------------
-- save global changed veh  ( - değiştirilen araçları global tabloya at - )
----------------------------------------------
function save_global_changed_veh(account_name,stats,id)
    local player_table = changed_global_vehicle[account_name]
    if player_table then 
        for k,v in ipairs(player_table) do 
            if id == v[1] then 
                v[2] = stats
            else
                table.insert(player_table,{id,stats})
            end
        end
    else
        player_table = {}
        table.insert(player_table,{id,stats})
    end
    changed_global_vehicle[account_name] = player_table 
end

--------------------------------------------------------------
-- on player quit or logout  ( -  oyuncu oyundan çıkarsa değişenleri db'kayıt et -)
------------------------------------------------------------------
function player_quit()
    local account_name = getAccountName(getPlayerAccount(source))
    local vehicle_table = created_player_vehicles[source]
    if vehicle_table then 
        for k,v in ipairs(vehicle_table) do 
            takePlayerMoney(source,vehicle_delivery_fee)
            save_vehicle_stats(source,v[1],v[2])
            destroyElement(v[2])
        end
        created_player_vehicles[source] = nil
    end
    local player_table = changed_global_vehicle[account_name]
    if player_table then 
        for k,v in ipairs(player_table) do 
            save_vehicle_stats_db(v[1],v[2])
        end
    end
    changed_global_vehicle[account_name] = nil
end
addEventHandler("onPlayerQuit",root,player_quit)

--------------------------------------------------------------------------------
--lock the vehicle  -server
--------------------------------------------------------------------------------
function lock_vehicle_s(id)
    local player_veh = getElementByID("arac"..id)
    setVehicleLocked(player_veh ,not isVehicleLocked(player_veh ))
end
addEvent("lock_vehicle",true)
addEventHandler("lock_vehicle",root,lock_vehicle_s)


--------------------------------------------------------------------------------
--engine_onoff the vehicle  -server
--------------------------------------------------------------------------------
function engine_onoff_vehicle_s(id)
    local player_veh = getElementByID("arac"..id)
    setVehicleEngineState(player_veh,not getVehicleEngineState(player_veh))

end
addEvent("engine_onoff_vehicle",true)
addEventHandler("engine_onoff_vehicle",root,engine_onoff_vehicle_s)

--------------------------------------------------------------------------------
--spectate the vehicle ( - araç izle - ) -server
--------------------------------------------------------------------------------
function spectate_vehicle_s(id)
    local player_veh = getElementByID("arac"..id)
    setCameraTarget(source,player_veh)

end
addEvent("spectate_vehicle",true)
addEventHandler("spectate_vehicle",root,spectate_vehicle_s)




---------------------------------------------------
-- Vehicle Explode destroy veh
---------------------------------------------------
function vehicle_explode()
   local info = info_vehicle_list[source]
   if info then
        triggerEvent("delete_vehicle",info[5],info[2]) 
   end
end

addEventHandler("onVehicleExplode", resourceRoot, vehicle_explode)



-----------------------------------------------------
-- save vehicle damage ( - araç hasarı kaydet - )
-----------------------------------------------------
function save_damage(loss)
    if damage_vehicle[source] then 
        local id,veh,player = unpack(damage_vehicle[source])
        local result = loss * 0.5
        local account_name = getAccountName(getPlayerAccount(player))
        local player_vehicle = global_player_vehicle[account_name]
        for k,v in ipairs(player_vehicle) do 
            if v[1] == id then 
                local stats = fromJSON(v[5])
                stats.damage = stats.damage + result 
                v[5] = toJSON(stats)
                global_player_vehicle[account_name] = player_vehicle
                triggerClientEvent(player,"save_damage",player,id,v[5])
                break
            end
        end
    end
end
addEventHandler("onVehicleDamage",root,save_damage)


--------------------------------------------
-- save vehicle km ( - araç km kaydet - )
---------------------------------------------
function save_km_s(veh,km)
    if damage_vehicle[veh] then 
        local id,veh,player = unpack(damage_vehicle[veh])
        local account_name = getAccountName(getPlayerAccount(player))
        local player_vehicle = global_player_vehicle[account_name]
        for k,v in ipairs(player_vehicle) do 
            if v[1] == id then 
                local stats = fromJSON(v[5])
                stats.km = stats.km + km
                v[5] = toJSON(stats)
                global_player_vehicle[account_name] = player_vehicle
                triggerClientEvent(player,"save_damage",player,id,v[5])
                break
            end
        end
    end
end
addEvent("save_km",true)
addEventHandler("save_km",root,save_km_s)


------------------------------------------------
-- vehicle name changer ( - araç ismi değiştirme - )
------------------------------------------------
function change_veh_name(player,_,model,name1,name2,name3)
    local account_name = getAccountName ( getPlayerAccount ( player ) ) -- Oyuncunun hesabını çektik,
    if isObjectInACLGroup ("user."..account_name, aclGetGroup (name_changer_acl ) ) then
        if model and name1 and name2 and name3 then 
            print(model)
            model = tonumber(model)
            print(type(model))
            if type(model) == "number" then 
                local name = name1.." "..name2.." "..name3
                local status = change_veh_name_db(model,name)
                if status then 
                    outputChatBox(language[language_section][13][1],player,language[language_section][13][2],language[language_section][13][3],language[language_section][13][4])
                end
            end
        end
    end
end
addCommandHandler(name_changer_command,change_veh_name)




