player_vehicles = {}
created_vehicles = {}
info_vehicle_table  = {}

created_vehicles_number = 0
function open_panel()
    if dgsGetVisible(vehicle_get_panel) then 
        dgsSetVisible(vehicle_get_panel,false)
        if dgsGetVisible(trade_panel) then triggerServerEvent("stop_trade_server",localPlayer) end
        dgsSetVisible(player_list_panel,false)
        showCursor(false)
        --showChat(true)
        for k,v in pairs(dgs) do 
            dgsSetVisible(v,false)
            removeEventHandler("onDgsMouseClick",v,dgs_button_click)
        end
        removeEventHandler("onDgsTextChange",dgs.search_edit,search_vehicles)
    else
        dgsSetVisible(vehicle_get_panel,true)
        dgsSetPosition(vehicle_get_panel,-0.2,0.16,true)
        dgsMoveTo(vehicle_get_panel,0.01,0.16,true,"Linear",200)
        showCursor(true)
        --showChat(false)
        for k,v in pairs(dgs) do
            if v == dgs.select_player_btn or  v == dgs.close_trade or  v == dgs.add_vehicle_trade or  v == dgs.lock_trade or  v == dgs.add_money_trade or  v == dgs.show_trade or  v == dgs.approval_trade  then
            else
                dgsSetVisible(v,true)
            end
            addEventHandler("onDgsMouseClick",v,dgs_button_click)
        end
        addEventHandler("onDgsTextChange",dgs.search_edit,search_vehicles)
        set_gridlist_alphabetic()
    end
end
bindKey(panel_key,"down",open_panel)


-------------------------------------------------------------
-- on dgs button click ( - dgs butonlarına tıklanma - )
--------------------------------------------------------------
local buton_tick = 0
function dgs_button_click()
    if (getTickCount()-buton_tick <= 300) then return end
    if source == dgs.close_btn then 
        open_panel()
    elseif source == dgs.search_edit then 
        dgsSetText(dgs.search_edit,"")
    elseif source == dgs.get_btn then 
        create_vehicle_c()
    elseif source == dgs.spectate_btn then 
        --print(gradient)
        --dgsGradientSetRotation(gradient,90)
        spectate_vehicle_c()
    elseif source == dgs.lock_btn then 
        lock_veh()
    elseif source ==  dgs.engine_btn then 
        engine_onoff_veh()
    else
        dgs_trade_click()
    end
    buton_tick = getTickCount()
end

------------------------------------------------------
-- engine_onoff Vehicle
-----------------------------------------------------
function engine_onoff_veh()
    local Selected = dgsGridListGetSelectedItem(vehicle_list)
    if Selected ~=-1 then 
        local id = dgsGridListGetItemText(vehicle_list,Selected,column_5)
        id = tonumber(id)
        if created_vehicles[id] then 
            triggerServerEvent("engine_onoff_vehicle",localPlayer,id)
        end
    end
end


------------------------------------------------------
-- Lock Vehicle
-----------------------------------------------------
function lock_veh()
    local Selected = dgsGridListGetSelectedItem(vehicle_list)
    if Selected ~=-1 then 
        local id = dgsGridListGetItemText(vehicle_list,Selected,column_5)
        id = tonumber(id)
        if created_vehicles[id] then 
            triggerServerEvent("lock_vehicle",localPlayer,id)
        end
    end
end

-------------------------------------------------------
-- vehicles search ( - araç arama -)
-------------------------------------------------------
function search_vehicles()
    local text = dgsGetText(dgs.search_edit)
    if text ~= "" then 
        local result = string.upper(string.sub(text, 1,1))
        text = result..string.sub(text,2,string.len(text))
        local player_money = getPlayerMoney(localPlayer)
        dgsGridListClear(vehicle_list)
        for k,v in ipairs(player_vehicles)  do 
            if string.find(v[4],text,1,true) and v[6] == 0 then 
                if v.id == i then 
                    local stats = fromJSON(v[5])
                    local price = convert_decimal(stats.price)
                    local km = convert_km(stats.km)
                    local damage = convert_decimal(stats.damage)
                    local row = dgsGridListAddRow(vehicle_list,"",v[4],price,km,damage,v[1])
                    dgsGridListSetItemData(vehicle_list,row,column_1,v[1])
                    if v[7] then 
                        dgsGridListSetItemColor(vehicle_list,row,column_1,0,255,0)
                    end
                end
            end 
        end
    else
        set_gridlist_alphabetic()
    end
end
------------------------------------------------------------
-- set gridlist alphabetic ( - listeyi alfabetik yap - )
------------------------------------------------------------
local alphabe = {"A","B","C","Ç","D","E","F","G","Ğ","H","İ","I","J","K","L","M","N","O","Ö","P","R","S","Ş","T","U","Ü","V","Y","Z"}
function set_gridlist_alphabetic()
    dgsGridListClear(vehicle_list)
    for s,a in pairs(alphabe) do 
        for k,v in ipairs(player_vehicles) do 
            if string.sub(v[4],1,1) == a and v[6] == 0 then 
                local stats = fromJSON(v[5])
                local price = convert_decimal(stats.price)
                local km = convert_km(stats.km)
                local damage = convert_decimal(stats.damage)
                local row = dgsGridListAddRow(vehicle_list,"",v[4],price,km,damage,v[1])
                if v[7] then 
                    dgsGridListSetItemColor(vehicle_list,row,column_1,0,255,0)
                end
            end
        end
    end
end
function convert_decimal(number)
    if math.floor((number)/1000000000) ~= 0 then 
        return tostring(math.floor((number)/1000000000)).."-t"
    elseif math.floor((number)/1000000) ~= 0 then 
        return tostring(math.floor((number)/1000000)).."-m"
    elseif math.floor((number)/1000) ~= 0 then
        return tostring(math.floor((number)/1000)).."-k"
    else
        return math.floor(number)
    end
end
function convert_km(number)
    if math.floor((number)/10000) ~= 0 then 
        return tostring(math.floor((number)/10000)).."-km"
    elseif math.floor((number)/1000) ~= 0 then
        return tostring(math.floor((number)/1000)).."-km"
    else
        return math.floor(number).."m"
    end
end
-------------------------------------------------------------
-- get player vehicles ( -  oyuncu araçlarını getir - )
--------------------------------------------------------------
function get_player_vehicles_c(t)
    player_vehicles = t
end
addEvent("send_player_vehicles",true)
addEventHandler("send_player_vehicles",localPlayer,get_player_vehicles_c)

function info_list(t)
    info_vehicle_table = fromJSON(t)
    if not info_vehicle_table then return end
    for k,v in ipairs(info_vehicle_table) do 
        addEventHandler("onClientElementDestroy",v[1],remove_info_veh_table)
    end
end
addEvent("send_playe_infos_vehicles",true)
addEventHandler("send_player_infos_vehicles",localPlayer,info_list)

-------------------------------------------------------------
-- add purchase vehicle ( -  satın alınan aracı ekle - )
--------------------------------------------------------------
function set_purchase_vehicle_c(t)   
    local id,account_name,model,vehicle_name,stats,sell_status,created_status = unpack(t)
    table.insert(player_vehicles,{id,account_name,model,vehicle_name,stats,sell_status,created_status})
end
addEvent("send_purchase_vehicle",true)
addEventHandler("send_purchase_vehicle",localPlayer,set_purchase_vehicle_c)


---------------------------------------------------------------------------
-- create vehicle ( -  araç oluştur - ) -client
---------------------------------------------------------------------------
local create_veh_tick = 0
function create_vehicle_c()
    if (getTickCount() - create_veh_tick <= 1000 ) then return  end
    create_veh_tick = getTickCount()
    if getPlayerMoney() < vehicle_delivery_fee then  outputChatBox(language[language_section][11][1],language[language_section][11][2],language[language_section][11][3],language[language_section][11][4]) return end
    local Selected = dgsGridListGetSelectedItem(vehicle_list)
    if Selected ~=-1 then 
        local id = dgsGridListGetItemText(vehicle_list,Selected,column_5)
        id = tonumber(id)
        if created_vehicles[id] then 
            for k,v in ipairs(player_vehicles) do 
                if id == v[1] then 
                    triggerServerEvent("delete_vehicle",localPlayer,id)
                    created_vehicles_number = created_vehicles_number - 1
                    created_vehicles[id] = nil
                    v[7] = false
                    dgsGridListSetItemColor(vehicle_list,Selected,column_1,255,255,255)
                    break
                end
            end
        else
            if created_vehicles_number >= created_vehicle_limit then outputChatBox(language[language_section][10][1],language[language_section][10][2],language[language_section][10][3],language[language_section][10][4]) return end
            for k,v in ipairs(player_vehicles) do 
                if id == v[1] then 
                    created_vehicles[id] = {id,v[3]}
                    triggerServerEvent("create_vehicle",localPlayer,id,v[3],v[5],v[2],v[4])
                    v[7] = true
                    dgsGridListSetItemColor(vehicle_list,Selected,column_1,0,255,0)
                    created_vehicles_number = created_vehicles_number + 1
                    break
                end
            end
        end
    end
end

------------------------------------------------------------------------------
-- save vehicle stats ( - araç değerlerini tabloya kayıt et -)
-------------------------------------------------------------------------------
function save_vehicle_stats(id,stats)
    for k,v in ipairs(player_vehicles) do 
        if v[1] == id then 
            v[5] = stats
        end
    end
end
addEvent("save_player_vehicle_stats",true)
addEventHandler("save_player_vehicle_stats",localPlayer,save_vehicle_stats)


--------------------------------------------------------------------------------
--spectate the vehicle ( - araç izle - ) - client
--------------------------------------------------------------------------------
local spectate_status = false
function spectate_vehicle_c()
    if spectate_status then 
        spectate_status = false
        setCameraTarget(localPlayer)
        dgsSetText(dgs.spectate_btn,language[language_section][3])
    else
        local Selected = dgsGridListGetSelectedItem(vehicle_list)
        if Selected ~=-1 then 
            local id = dgsGridListGetItemText(vehicle_list,Selected,column_5)
            id = tonumber(id)
            if created_vehicles[id] then 
                triggerServerEvent("spectate_vehicle",localPlayer,id)
                dgsSetText(dgs.spectate_btn,language[language_section][12])
                spectate_status = true
            end
        end
    end
end


-------------------------------------------
-- save damage ( - hasar kayıt et - )
-------------------------------------------
function save_damage_c(id,stats)
    for k,v in ipairs(player_vehicles) do 
        if v[1] == id then 
            v[5] = stats
            break
        end
    end
end
addEvent("save_damage",true)
addEventHandler("save_damage",localPlayer,save_damage_c)


-------------------------------------------------------------
-- save km ( - km kaydetme - )
-------------------------------------------------------------
km_timer = false
enter_vec = Vector3(0,0,0)
km_vec = Vector3(0,0,0)
km = 0
vehicle_km = false
function enter_vehicle(player,seat)
    if seat == 0 and player == getLocalPlayer() then 
        for k,v in ipairs(getElementsByType("vehicle", getResourceRootElement(getThisResource()), true)) do 
            if v == source then 
                local x,y = getElementPosition(source)
                enter_vec = Vector3(x,y,z)
                km_vec = Vector3(0,0,0)
                km = 0
                vehicle_km = source
                km_timer = setTimer(km_counter,1000,0,source)
            end
        end
    end
end
addEventHandler("onClientVehicleEnter",getRootElement(),enter_vehicle)
function exit_vehicle(player)
    if isTimer(km_timer) and player == getLocalPlayer() then 
        killTimer(km_timer) 
        triggerServerEvent("save_km",localPlayer,vehicle_km,km)
    end
end
addEventHandler("onClientVehicleExit",getRootElement(),exit_vehicle)
function km_counter(veh)
    local x,y = getElementPosition(veh)
    anlik_vec = Vector3(x,y,z)
    result = enter_vec - anlik_vec
    if result.x < 0 then
        result.x =result.x *-1
    end
    if result.y < 0 then
        result.y =  result.y *-1
    end
    if result.z < 0 then
        result.z =  result.z *-1
    end
    km_vec = km_vec + (result)
    local speed = ( function( x, y, z ) return math.floor( math.sqrt( x*x + y*y + z*z ) * 155 ) end )( getElementVelocity( veh ) )
    if speed > 0 then  
        km =  km + math.floor( math.sqrt( km_vec.x*km_vec.x,km_vec.y*km_vec.y,km_vec.z*km_vec.z) ) 
    end
    enter_vec = Vector3(x,y,z)
end


--------------------------------------------
-- vehicle top info ( - araç üst bilgi - )
---------------------------------------------
function remove_info_veh_table()
	if getElementType(source) == "vehicle" then
        for k,v in ipairs(info_vehicle_table) do 
            if v[1] == source then 
                table.remove(info_vehicle_table,k)
                break
            end
        end
	end
end
function roundedRectangle(x, y, w, h, borderColor, bgColor, postGUI)
    if (x and y and w and h) then
        if (not borderColor) then
            borderColor = tocolor(0, 0, 0, 200);
        end
        
        if (not bgColor) then
            bgColor = borderColor;
        end
            
        --> Background
        dxDrawRectangle(x, y, w, h, bgColor, postGUI);
        
        --> Border
        dxDrawRectangle(x + 2, y - 1, w - 4, 1, borderColor, postGUI); -- top
        dxDrawRectangle(x + 2, y + h, w - 4, 1, borderColor, postGUI); -- bottom
        dxDrawRectangle(x - 1, y + 2, 1, h - 4, borderColor, postGUI); -- left
        dxDrawRectangle(x + w, y + 2, 1, h - 4, borderColor, postGUI); -- right
    end
  end
  
function show_info_veh()
    local cx, cy, cz = getCameraMatrix();
    local screenW,screenH=guiGetScreenSize()
    for  k, v in ipairs(info_vehicle_table) do
        local x, y, z = getElementPosition( v[1] )
        z=z+0.8
        if isLineOfSightClear( cx, cy, cz, x, y, z, false, false, false, false, false, false, false, v[1] ) then
            local dist = getDistanceBetweenPoints3D( cx, cy, cz, x, y, z )
            if dist <= 16 then
                local px, py = getScreenFromWorldPosition( x, y, z + 0.6, 0.06 )
                if px then
                    roundedRectangle(px-100, (py + screenW/38)-90, (string.len(language[language_section][5][1].." : "..v[4])*10)-50,100, tocolor( 12,12,12,120))
                    dxDrawText("ID : "..v[2], px-90, (py + screenW/38)-85, px, py, tocolor( 255, 255, 255, 255 ), 1.25, 'default-bold', 'left', 'center', false, false )
                    dxDrawText(language[language_section][14][1].." : "..v[3], px-90, (py + screenW/38)-30, px, py, tocolor( 255, 255, 255, 255 ), 1.25, 'default-bold', 'left', 'center', false, false )
                    dxDrawText(language[language_section][5][1].." : "..v[4], px-90, (py + screenW/38)+30, px, py, tocolor( 255, 255, 255, 255 ), 1.25, 'default-bold', 'left', 'center', false, false )
                end
            end
        end
    end
end
function open_info_event(key, keyState)
    if keyState == "down" then 
        addEventHandler("onClientRender",root,show_info_veh)
    elseif keyState == "up" then 
        removeEventHandler("onClientRender",root,show_info_veh)
    end
end

bindKey(info_key,"both",open_info_event)




function add_info_table(t)
    table.insert(info_vehicle_table,t)
    addEventHandler("onClientElementDestroy",t[1],remove_info_veh_table)
end
addEvent("send_info_veh",true)
addEventHandler("send_info_veh",localPlayer,add_info_table)


--------------------------------------------------
--dgs Alert Animation ( - dgs uyarı animasyonu - )
---------------------------------------------------
function dgsAlertAnim(element,relative)
    if not element then return end
    local elm_x,elm_y = dgsGetPosition(element,relative)
    local elm_w,elm_h = dgsGetSize(element,relative)
    local move_result = 0
    if relative then 
        move_result =  0.01
    else
        move_result = 10
    end
    local r,g,b = 255,0,0


    dgsMoveTo(element,elm_x-move_result,elm_y,relative,"SineCurve",500)
    dgsMoveTo(element,elm_x+move_result,elm_y,relative,"SineCurve",500,50)
    dgsMoveTo(element,elm_x-move_result,elm_y,relative,"SineCurve",500,100)
    dgsMoveTo(element,elm_x+move_result,elm_y,relative,"SineCurve",500,150)
    dgsMoveTo(element,elm_x-move_result,elm_y,relative,"SineCurve",500,200)
    dgsMoveTo(element,elm_x+move_result,elm_y,relative,"SineCurve",500,250)
    dgsMoveTo(element,elm_x-move_result,elm_y,relative,"SineCurve",500,300)
    dgsMoveTo(element,elm_x+move_result,elm_y,relative,"SineCurve",500,350)
    dgsMoveTo(element,elm_x-move_result,elm_y,relative,"SineCurve",500,400)
    setTimer(function(element,elm_x,elm_y,relative)
        dgsStopAniming(element)
        dgsSetPosition(element,elm_x,elm_y,relative)
    end,500,1,element,elm_x,elm_y,relative)
end


