-----------------------------------------------------
-- exit vehicle shop ( - araç mağazından çıkma - )
------------------------------------------------------
function exit_bazaar() 
    local x,y,z = unpack(marker_players[source])
    setElementInterior(source,0)
    setElementPosition(source,x,y,z)
    setCameraTarget(source)
    if marker_players[source] then 
        marker_players[source] = nil
    end
end
addEventHandler("onPlayerQuit",root,exit_bazaar)
addEvent("exit_vehicle_bazaar",true)
addEventHandler("exit_vehicle_bazaar",root,exit_bazaar)

---------------------------------------------------
-- test drive ( - test sürüşü - )
---------------------------------------------------
local vehicle_test_t = {}
function test_drive_s(id)
    local x,y,z,rz = unpack(marker_players[source])
    setElementInterior(source,0)
    local vehicle = createVehicle(id,x,y,z,0,0,rz)
    warpPedIntoVehicle(source,vehicle)
    outputChatBox(language[language_section][13][1],source,language[language_section][13][2],language[language_section][13][3],language[language_section][13][4])
    setCameraTarget(source)
    setVehicleLocked(vehicle,true)
    local test_timer = setTimer(remove_vehicle,test_drive_time,1,vehicle,source)
    vehicle_test_t[source] = {test_timer,vehicle}
end
addEvent("test_drive_bazaar",true)
addEventHandler("test_drive_bazaar",root,test_drive_s)

function remove_vehicle(vehicle,player)
    if isElement(player) then 
        local x,y,z,rz = unpack(marker_players[player])
        for k,v in ipairs(gallerys) do 
            local tx,ty,tz,trz = unpack(v[2])
            if tx == x and ty == y and trz == rz then 
                if isElement(vehicle) then 
                    removePedFromVehicle(player)
                end
                vehicle_test_t[player] = nil
                marker_players[player]  = nil
                setElementPosition(player,v[1][1],v[1][2],v[1][3])
                break
            end
        end
    end
    if isElement(vehicle) then 
        destroyElement(vehicle)
    end
end
function quit_test_drive_s(player)
    if vehicle_test_t[player] then 
        local timer , vehicle = unpack(vehicle_test_t[player])
        if isTimer(timer) then 
            killTimer(timer)
        end
        remove_vehicle(vehicle,player)
    end
end

addCommandHandler(test_quit_command,quit_test_drive_s)

-------------------------------------------------
--purchase a vehicle ( - araç satın alma )
--------------------------------------------------
function purchase_vehicle_s(id)
    local x,y,z = unpack(marker_players[source])
    setElementInterior(source,0)
    setElementPosition(source,x,y,z)
    setCameraTarget(source)
    marker_players[source] = nil
    local account = getPlayerAccount(source)
    if not account then return end
    if not exports["meta_vehicleget"]:get_buying_limit(getAccountName(account)) then  outputChatBox(language[language_section][16][1],source,language[language_section][16][2],language[language_section][16][3],language[language_section][16][4]) return end
    for k,v in ipairs(global_vehicle) do 
        if v[1] == id then 
            local player_money = getPlayerMoney(source)
            local price = v[6]
            if player_money >= price then 
                local player = getAccountPlayer(getAccount(v[7]))
                if player then 
                    givePlayerMoney(player,price)
                    outputChatBox(string.gsub(getPlayerName(source), "#%x%x%x%x%x%x", "").." isimli oyuncu"..v[4].." isimli aracınızı satın almıştır.",player,0,255,0)
                else
                    setAccountData(getAccount(v[7]),"bazaar_bank",price)
                end
                takePlayerMoney(source,price)
                remove_vehicle_db(id)
                exports["meta_vehicleget"]:add_player_vehicle_to_bazaar(getAccountName(account),id,v[7])
                local new_table = {}
                for k,v in ipairs(global_vehicle) do 
                    if v[1] ~= id then 
                        table.insert(new_table,{v[1],v[2],v[3],v[4],v[5],v[6],v[7]})
                    end
                end
                global_vehicle = new_table
                for s,p in ipairs(getElementsByType("player")) do 
                    if marker_players[p]  then 
                        triggerClientEvent("refresh_vehicles_sell_list_bazaar",p,global_vehicle)
                    end
                end
            else
                outputChatBox(language[language_section][15][1],source,language[language_section][15][2],language[language_section][15][3],language[language_section][15][4])
            end
        end
    end
end
addEvent("purchase_to_bazaar_vehicle",true)
addEventHandler("purchase_to_bazaar_vehicle",root,purchase_vehicle_s)




---------------------------------------------
-- add vehicle  ( - araç ekle - )-- server
---------------------------------------------
function add_vehicle_s(id,price,account_name,model,veh_name,stats)
    local status = exports["meta_vehicleget"]:sell_vehicle_bazaar(id,account_name,source)
    if status then 
        add_vehicle_db(id,model,string.gsub(getPlayerName(source), "#%x%x%x%x%x%x", ""),veh_name,stats,price,account_name)
        takePlayerMoney(source,add_on_fee)
        table.insert(global_vehicle,{id,model,string.gsub(getPlayerName(source), "#%x%x%x%x%x%x", ""),veh_name,stats,price,account_name})
    end
    for s,p in ipairs(getElementsByType("player")) do 
        if marker_players[p] then 
            triggerClientEvent("refresh_vehicles_sell_list_bazaar",p,global_vehicle)
        end
    end
end
addEvent("add_vehicle",true)
addEventHandler("add_vehicle",root,add_vehicle_s)


---------------------------------------------
-- remove vehicle  ( - araç sil - )-- server
---------------------------------------------
function remove_vehicle_s(id,account_name)
    local status = exports["meta_vehicleget"]:remove_vehicle_bazaar(id,account_name,source)
    if status then 
        remove_vehicle_db(id)
    end
    local new_table = {}
    for k,v in ipairs(global_vehicle) do 
        if v[1] ~= id then 
            table.insert(new_table,{v[1],v[2],v[3],v[4],v[5],v[6],v[7]})
        end
    end
    global_vehicle = new_table
    for s,p in ipairs(getElementsByType("player")) do 
        if marker_players[p]  then 
            triggerClientEvent("refresh_vehicles_sell_list_bazaar",p,global_vehicle)
        end
    end
end
addEvent("remove_vehicle",true)
addEventHandler("remove_vehicle",root,remove_vehicle_s)

---------------------------------------------
-- sell to scrap vehicle  ( - aracı hurdaya sat - )-- server
---------------------------------------------
function sell_to_scrap_vehicle_s(id,account_name,fee)
    local status = exports["meta_vehicleget"]:sell_vehicle_scrap(id,account_name,source)
    if status then 
        givePlayerMoney(source,fee)
    end
end
addEvent("sell_to_scrap_vehicle",true)
addEventHandler("sell_to_scrap_vehicle",root,sell_to_scrap_vehicle_s)



---------------------------------------------------------
-- player login ( - hesaba girme - )
------------------------------------------------------------
function player_login(_,account)
    local fee = getAccountData(account,"bazaar_bank")
    if fee then 
        givePlayerMoney(source,fee)
       setAccountData(account,"bazaar_bank",false)
    end
end
addEventHandler("onPlayerLogin",root,player_login)