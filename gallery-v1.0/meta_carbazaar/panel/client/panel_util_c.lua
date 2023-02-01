local vehicle_id_list = {}
local vehicle_list = {}
local vehicle = false
local cinematic_mode = false
local sound_state = true
local action_status = false
--------------------------------------------
--Shop panel opened ( - alışveriş paneli açılma - )
----------------------------------------------
function on_panel_open(vehicle_id_list_t,vehicle_list_t)
    if dgsGetVisible(vehicle_shop_panel) then
        dgsMoveTo(vehicle_shop_panel,-0.5,0.2,true,"OutElastic",3000)
        dgsAlphaTo(dgs.search_edit,0,"Linear",2500)
        dgsAlphaTo(dgs.exit_btn,0,"Linear",2500)
        dgsAlphaTo(dgs.try_btn,0,"Linear",2500)
        dgsAlphaTo(dgs.buy_btn,0,"Linear",2500)
        dgsGridListClear(cars_list)
        if dgsGetVisible(vehicle_add_rev_panel) then 
            if action_status == "scrap" then 
                removeEventHandler("onDgsTextChange",dgs.id_edit,vehicle_scrap_price_write)
            end
            action_status = false
            dgsSetVisible(vehicle_add_rev_panel,false)
        end
        setTimer(function ()
            dgsSetVisible(vehicle_shop_panel,false)
        end,2500,1)
        for k,v in pairs(dgs) do 
            dgsSetVisible(v,false)
            removeEventHandler("onDgsMouseClick",v,dgs_click)
        end 
        showCursor(false)
        removeEventHandler("onDgsTextChange",dgs.search_edit,search_vehicles)
        removeEventHandler("onDgsMouseClick",cars_list,create_vehicle)
        removeEventHandler("onDgsGridListSelect",cars_list,create_vehicle)
        removeEventHandler("onClientPlayerWasted",localPlayer,player_death)
        showChat(true)
        if vehicle then 
            removeEventHandler ( "onClientClick", root, vehicle_clicked)
            removeEventHandler("onClientCursorMove",root,rotate_vehicle)
            destroyElement(vehicle) 
            vehicle = false
        end
        sound_remove()
    else
        dgsSetPosition(vehicle_shop_panel,-0.5,0.2,true)
        dgsSetPosition(dgs.cinematic_btn,0.965,0.84,true)
        dgsSetPosition(dgs.sound_btn,0.965,0.94,true)

        dgsSetAlpha(dgs.search_edit,0)
        dgsSetAlpha(dgs.exit_btn,0)
        dgsSetAlpha(dgs.try_btn,0)
        dgsSetAlpha(dgs.buy_btn,0)
        dgsSetAlpha(dgs.cinematic_btn,0)
        dgsSetAlpha(dgs.sound_btn,0)

        dgsSetVisible(vehicle_shop_panel,true)
        dgsMoveTo(vehicle_shop_panel,0.01,0.2,true,"OutElastic",2000)
        dgsAlphaTo(dgs.search_edit,1,"Linear",2000)
        dgsAlphaTo(dgs.exit_btn,1,"Linear",2000)
        dgsAlphaTo(dgs.try_btn,1,"Linear",2000)
        dgsAlphaTo(dgs.buy_btn,1,"Linear",2000)
        dgsAlphaTo(dgs.cinematic_btn,1,"Linear",2000)
        dgsAlphaTo(dgs.sound_btn,1,"Linear",2000)

        for k,v in pairs(dgs) do 
            dgsSetVisible(v,true)
            addEventHandler("onDgsMouseClick",v,dgs_click)
        end
        showCursor(true)
        if vehicle_id_list_t and vehicle_list_t then 
            vehicle_id_list = vehicle_id_list_t
            vehicle_list = vehicle_list_t
            add_list_vehicle_set_alphabetic()
        end
        addEventHandler("onDgsTextChange",dgs.search_edit,search_vehicles)
        addEventHandler("onDgsMouseClick",cars_list,create_vehicle)
        addEventHandler("onDgsGridListSelect",cars_list,create_vehicle)
        addEventHandler("onClientPlayerWasted",localPlayer,player_death)
        showChat(false)
        dgsSetVisible(cars_stat_car_logo,false)
        dgsSetVisible(dgs.cars_stat_main,false)
        sound_effect()
    end
end
addEvent("open_bazaar_panel",true)
addEventHandler("open_bazaar_panel",localPlayer,on_panel_open)

----------------------------------------------
-- clicked dgs elements ( - dgs öğelerine tıklanırsa - )
-------------------------------------------------
local approval_selection = 3
local click_count_btn = 0
function dgs_click()
    if (getTickCount() - click_count_btn) <=500 then return end
    if source == dgs.exit_btn then 
        setTimer(function() triggerServerEvent("exit_vehicle_bazaar",localPlayer) end,500,1)
        on_panel_open()
    elseif source == dgs.search_edit then 
        dgsSetText(dgs.search_edit,"")
    elseif source == dgs.cinematic_btn then 
        if vehicle then
            open_cinematic_mode()
        end
    elseif source == dgs.try_btn then
        if vehicle then 
            local id = getElementModel(vehicle) 
            on_panel_open()
            triggerServerEvent("test_drive_bazaar",localPlayer,id)
        end
    elseif source == dgs.buy_btn then 
        local Selected = dgsGridListGetSelectedItem(cars_list)
        if Selected ~=-1 then 
            local id = dgsGridListGetItemText(cars_list,Selected,column_6)
            id = tonumber(id)
            for k,v in ipairs(vehicle_list) do 
                if id == v[1] then 
                    if v[3] ~= string.gsub(getPlayerName(localPlayer), "#%x%x%x%x%x%x", "") then 
                        triggerServerEvent("purchase_to_bazaar_vehicle",localPlayer,id)
                        on_panel_open()
                    end
                end
            end
        end
    elseif source == dgs.sound_btn then 
        if sound_state then 
            dgsSetProperty(dgs.sound_btn, "image",{sound_off_btn_dx,sound_on_btn_dx,sound_on_btn_dx})
            sound_remove()
            sound_state = false
        else
            dgsSetProperty(dgs.sound_btn, "image",{sound_on_btn_dx,sound_off_btn_dx,sound_off_btn_dx})
            sound_add()
            sound_state = true
        end
    elseif source == dgs.add_btn then 
        if action_status == "scrap" then 
            removeEventHandler("onDgsTextChange",dgs.id_edit,vehicle_scrap_price_write)
        end
        if dgsGetVisible(vehicle_add_rev_panel) then 
            action_status = false
            dgsSetVisible(vehicle_add_rev_panel,false)
        else
            dgsSetVisible(vehicle_add_rev_panel,true)
            dgsSetEnabled(dgs.id_edit,true)
            dgsSetEnabled(dgs.price_edit,true)
            action_status = "add"
            approval_selection = 3
            dgsSetText(dgs.approval_btn,language[language_section][20][1])
            dgsSetText(dgs.price_edit,"")
            dgsSetText(dgs.id_edit,"")
        end
    elseif source == dgs.rev_btn then 
        if action_status == "scrap" then 
            removeEventHandler("onDgsTextChange",dgs.id_edit,vehicle_scrap_price_write)
        end
        if dgsGetVisible(vehicle_add_rev_panel) then 
            action_status = false
            dgsSetVisible(vehicle_add_rev_panel,false)
        else
            dgsSetEnabled(dgs.id_edit,true)
            dgsSetEnabled(dgs.price_edit,false)
            dgsSetVisible(vehicle_add_rev_panel,true)
            action_status = "remove"
            approval_selection = 3
            dgsSetText(dgs.approval_btn,language[language_section][20][1])
            dgsSetText(dgs.price_edit,"")
        end
    elseif source == dgs.sell_btn then 
        if dgsGetVisible(vehicle_add_rev_panel) then 
            if action_status == "scrap" then 
                removeEventHandler("onDgsTextChange",dgs.id_edit,vehicle_scrap_price_write)
            end
            action_status = false
            dgsSetVisible(vehicle_add_rev_panel,false)
        else
            dgsSetEnabled(dgs.id_edit,true)
            dgsSetEnabled(dgs.price_edit,false)
            dgsSetVisible(vehicle_add_rev_panel,true)
            action_status = "scrap"
            approval_selection = 3
            dgsSetText(dgs.approval_btn,language[language_section][20][1])
            dgsSetText(dgs.price_edit,language[language_section][20][1].."-%"..vehicle_scrap_selling_percentage)
            addEventHandler("onDgsTextChange",dgs.id_edit,vehicle_scrap_price_write)
        end
    elseif source == dgs.approval_btn then 
        if approval_selection < 0 then 
            local status  = doing_action()
            if status then 
                dgsSetVisible(vehicle_add_rev_panel,false)
                approval_selection = 3
                if action_status == "scrap" then 
                    removeEventHandler("onDgsTextChange",dgs.id_edit,vehicle_scrap_price_write)
                end
                action_status = false
            end
        else
            dgsSetText(dgs.approval_btn,language[language_section][20][1].."("..approval_selection..")")
            approval_selection = approval_selection - 1
        end
    elseif source == dgs.id_edit then 
        dgsSetText(dgs.id_edit,"")
    elseif source == dgs.price_edit then 
        dgsSetText(dgs.price_edit,"")
    elseif source == dgs.close_btn then 
        if action_status == "scrap" then 
            removeEventHandler("onDgsTextChange",dgs.id_edit,vehicle_scrap_price_write)
        end
        action_status = false
        dgsSetVisible(vehicle_add_rev_panel,false)
        
    end
    click_count_btn  = getTickCount()
end

---------------------------------------------------------
-- vehicles gridlist add  ( - araçlar listeye eklenme - )
----------------------------------------------------------
local alphabe = {"A","B","C","Ç","D","E","F","G","Ğ","H","İ","I","J","K","L","M","N","O","Ö","P","R","S","Ş","T","U","Ü","V","Y","Z"}
function add_list_vehicle_set_alphabetic()
    dgsGridListClear(cars_list)
    local player_money = getPlayerMoney(localPlayer)
    for z,h in pairs(alphabe) do 
        for s,i in pairs(vehicle_id_list) do 
            for k,v in ipairs(vehicle_list) do 
                if string.sub(v[4],1,1) == h then 
                    if v[2] == i then 
                        local stats = fromJSON(v[5])
                        local price = convert_decimal(v[6])
                        local km = convert_km(stats.km)
                        local damage = convert_decimal(stats.damage)
                        local row = dgsGridListAddRow(cars_list,"",v[4],v[3],price,km,damage,v[1])
                        if v[6] <= player_money then
                            dgsGridListSetItemColor(cars_list,row,column_3,tocolor(0,255,0)) 
                        else
                            dgsGridListSetItemColor(cars_list,row,column_3,tocolor(255,0,0)) 
                        end
                        for l,c in ipairs(cars_stats) do
                            if c[1] == i then 
                                local dx = dxCreateTexture(c[5])
                                dgsGridListSetItemImage(cars_list,row,column_4,dx,false,1.6,0.25,0.4,0.5,true)
                            end
                        end
                    end
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

-------------------------------------------------------
-- vehicles search ( - araç arama -)
-------------------------------------------------------
function search_vehicles()
    local text = dgsGetText(dgs.search_edit)
    if text ~= "" then 
        local result = string.upper(string.sub(text, 1,1))
        text = result..string.sub(text,2,string.len(text))
        local player_money = getPlayerMoney(localPlayer)
        dgsGridListClear(cars_list)
        for s,i in pairs(vehicle_id_list) do 
            for k,v in ipairs(vehicle_list) do 
                if string.find(v[4],text,1,true) then 
                    if v[2] == i then 
                        local stats = fromJSON(v[5])
                        local price = convert_decimal(v[6])
                        local km = convert_km(stats.km)
                        local damage = convert_decimal(stats.damage)
                        local row = dgsGridListAddRow(cars_list,"",v[4],v[3],price,km,damage,v[1])
                        if v[6] <= player_money then
                            dgsGridListSetItemColor(cars_list,row,column_3,tocolor(0,255,0)) 
                        else
                            dgsGridListSetItemColor(cars_list,row,column_3,tocolor(255,0,0)) 
                        end
                        for l,c in ipairs(cars_stats) do
                            if c[1] == i then 
                                local dx = dxCreateTexture(c[5])
                                dgsGridListSetItemImage(cars_list,row,column_4,dx,false,1.6,0.25,0.4,0.5,true)
                            end
                        end
                    end
                end 
            end
        end
    else
        add_list_vehicle_set_alphabetic()
    end
end

-------------------------------------------------------------
-- create vehicle ( - araç oluşturma -)
--------------------------------------------------------------
local tick = 0
function create_vehicle()
    if (getTickCount()-tick <= 500) then return end
    local Selected = dgsGridListGetSelectedItem(cars_list)
    if Selected ~=-1 then 
        local id = dgsGridListGetItemText(cars_list,Selected,column_6)
        id = tonumber(id)
        for k,v in ipairs(vehicle_list) do 
            print(v[1])
            if v[1] == id then 
                if vehicle then 
                    if getElementModel(vehicle) == v[2] then return end
                    setElementModel(vehicle,v[2])
                    setElementPosition(vehicle,1365.44385, -25.24594, 1001.35878)
                    set_stat_vehicle(v[2])
                else
                    vehicle = createVehicle(tonumber(v[2]) ,1365.44385, -25.24594, 1001.35878,0,0,220)
                    setVehicleDamageProof(vehicle,true)   
                    setElementFrozen(vehicle,true)                 
                    addEventHandler ( "onClientClick", root, vehicle_clicked)
                    addEventHandler("onClientCursorMove",root,rotate_vehicle)
                    setElementInterior(vehicle,1) 
                    set_stat_vehicle(v[2])
                end
                tick = getTickCount()
            end
        end
    end
end
---------------------------------------------------------------
-- rotate vehicle ( - aracı döndür - )
---------------------------------------------------------------
local selected_vehicle = false
function  vehicle_clicked( button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)

    if ( clickedElement ) then
        if selected_vehicle == vehicle then
            selected_vehicle = false
            return
        end
        if clickedElement == vehicle then 
            selected_vehicle = clickedElement
        end
    else
        selected_vehicle = false
    end
end
local rsw,rsh = guiGetScreenSize()
local lastworldx = 0 
function rotate_vehicle(_,_,mrx,mry)
    if selected_vehicle then 
        local screenx, screeny, worldx, worldy, worldz = getCursorPosition()
        local _,_,rz = getElementRotation(vehicle)
        if worldx >= 1091.5  then
            if lastworldx >= worldx  then 
                rz = rz  - math.floor((mry-(rsw/2))/360)
            else
                rz = rz + math.floor((mry-(rsw/2))/360)
            end
        else
            if lastworldx <= worldx  then 
                rz = rz + math.floor((mry-(rsw/2))/360)
            else
                rz = rz  - math.floor((mry-(rsw/2))/360)
            end
        end
        lastworldx = worldx
        setElementRotation(vehicle,0,0,rz)
    end
end
--------------------------------------------------------------
-- set vehicle stat ( - araç değerlerini ayarla - )
---------------------------------------------------------------
local dx_logo = false
function set_stat_vehicle(id)
    if (dgsGetVisible(dgs.cars_stat_main) == false)  then 
        dgsSetVisible(dgs.cars_stat_main,true)
        dgsAlphaTo(dgs.cinematic_btn,0,"Linear",500)
        dgsAlphaTo(dgs.sound_btn,0,"Linear",500)
        dgsMoveTo(dgs.cars_stat_main,0.745,0.74,true,"OutBack",2000)
        setTimer(function() 
            dgsSetPosition(dgs.cinematic_btn,0.71,0.84,true)
            dgsSetPosition(dgs.sound_btn,0.71,0.94,true)
            dgsAlphaTo(dgs.cinematic_btn,1,"Linear",2000)
            dgsAlphaTo(dgs.sound_btn,1,"Linear",2000)
        end,1000,1)
    end
    local state = false
    for k,v in ipairs(cars_stats) do 
        if v[1] == id then 
            state = true
            dgsSetSize(cars_stat_bar_speed,v[2] ,1.2,true)
            dgsSetSize(cars_stat_bar_accelertion,v[3] ,1.2,true)
            dgsSetSize(cars_stat_bar_brake,v[4]  ,1.2,true)
            dgsSetVisible(cars_stat_car_logo,true)
            if dx_logo then 
                destroyElement(dx_logo)
                dx_logo = false
            end
            dx_logo = dxCreateTexture(v[5])
            dgsImageSetImage(cars_stat_car_logo,dx_logo)
        end
    end
    if not state then 
        dgsSetVisible(cars_stat_car_logo,false)
        dgsSetSize(cars_stat_bar_speed,0,1.2,true)
        dgsSetSize(cars_stat_bar_accelertion,0,1.2,true)
        dgsSetSize(cars_stat_bar_brake,0,1.2,true)
        if dx_logo then 
            destroyElement(dx_logo)
            dx_logo = false
        end
    end
end

--------------------------------
-- Open cinematic mode ( - sinematik mode açma - )
-------------------------------------------
function open_cinematic_mode()
    if cinematic_mode then 
        dgsSetVisible(dgs.cars_stat_main,true)
        dgsAlphaTo(dgs.cinematic_btn,0,"Linear",500)
        dgsAlphaTo(dgs.sound_btn,0,"Linear",500)
        dgsMoveTo(dgs.cars_stat_main,0.745,0.74,true,"OutBack",2000)
        setTimer(function() 
            dgsSetPosition(dgs.cinematic_btn,0.71,0.84,true)
            dgsSetPosition(dgs.sound_btn,0.71,0.94,true)
            dgsAlphaTo(dgs.cinematic_btn,1,"Linear",2000)
            dgsAlphaTo(dgs.sound_btn,1,"Linear",2000)
        end,1000,1)
        dgsSetAlpha(dgs.search_edit,0)
        dgsSetAlpha(dgs.exit_btn,0)
        dgsSetAlpha(dgs.try_btn,0)
        dgsSetAlpha(dgs.buy_btn,0)
        dgsSetAlpha(dgs.cinematic_btn,0)
        dgsSetAlpha(dgs.sound_btn,0)

        dgsSetVisible(vehicle_shop_panel,true)
        dgsMoveTo(vehicle_shop_panel,0.01,0.2,true,"OutElastic",2000)
        dgsAlphaTo(dgs.search_edit,1,"Linear",2000)
        dgsAlphaTo(dgs.exit_btn,1,"Linear",2000)
        dgsAlphaTo(dgs.try_btn,1,"Linear",2000)
        dgsAlphaTo(dgs.buy_btn,1,"Linear",2000)
        for k,v in pairs(dgs) do 
            dgsSetVisible(v,true)
        end
        cinematic_mode = false
        unbindKey("mouse_wheel_up","down",add_cam)
        unbindKey("mouse_wheel_down","down",rev_cam)
    else
        dgsMoveTo(vehicle_shop_panel,-1,0.2,true,"OutElastic",2000)
        dgsAlphaTo(dgs.search_edit,0,"Linear",2500)
        dgsAlphaTo(dgs.exit_btn,0,"Linear",2500)
        dgsAlphaTo(dgs.try_btn,0,"Linear",2500)
        dgsAlphaTo(dgs.buy_btn,0,"Linear",2500)
        
        dgsSetVisible(dgs.cars_stat_main,true)
        dgsAlphaTo(dgs.cinematic_btn,0,"Linear",500)
        dgsAlphaTo(dgs.sound_btn,0,"Linear",500)
        dgsMoveTo(dgs.cars_stat_main,1,0.74,true,"OutBack",2000)
        setTimer(function() 
            dgsSetPosition(dgs.cinematic_btn,0.965,0.84,true)
            dgsSetPosition(dgs.sound_btn,0.965,0.94,true)
            dgsAlphaTo(dgs.cinematic_btn,1,"Linear",2000)
            dgsAlphaTo(dgs.sound_btn,1,"Linear",2000)
            dgsSetVisible(vehicle_shop_panel,false)
        end,1000,1)
        setTimer(function()
            for k,v in pairs(dgs) do 
                dgsSetVisible(v,false)
            end
            dgsSetVisible(dgs.cinematic_btn,true)
            dgsSetVisible(dgs.sound_btn,true)
        end,2000,1)
        cinematic_mode = true
        bindKey("mouse_wheel_up","down",rev_cam)
        bindKey("mouse_wheel_down","down",add_cam)
    end
end

function add_cam()
    move_camera(1)
end
function rev_cam()
    move_camera(-1)
end

function move_camera(value)
    local cx,cy,cz = getCameraMatrix()
    if ((cx + value) >= 1404.29614) or ((cx + value) <= 1363.5369) then return end
    setCameraMatrix(cx+value,cy,cz,1364.99573, -25.36300, 1001.30878)
end


-------------------------------------------------------
-- if player death ( - eğer oyuncu ölürse - )
-------------------------------------------------------
function player_death()
   triggerServerEvent("exit_vehicle_bazaar",localPlayer)
    on_panel_open()
end

----------------------------------------------------------
-- anything player buy vehicle and refresh list opened panel players ( - farklı bir oyuncu alışveriş yaptığında araç listesini açık oyuncular için yenile - )
-------------------------------------------------------------------
function refresh_vehicles_sell_list_c(t)
    vehicle_list = t
    add_list_vehicle_set_alphabetic()
end
addEvent("refresh_vehicles_sell_list_bazaar",true)
addEventHandler("refresh_vehicles_sell_list_bazaar",localPlayer,refresh_vehicles_sell_list_c)


-------------------------------------------------------------------
-- sound enabled or disabled ( - sesi aktif et veya deaktif et - )
-------------------------------------------------------------------

local browser = nil
local theBrowser = nil
--guiSetVisible(browser,false)
function sound_effect()
    if sound_state then 
        sound_add()
    else
        sound_remove()
    end
end
local music = false

function sound_add()
    if not music then
        local url = table.random(music_url)
        music = playSound(url[1],true)
        setSoundVolume(music,volume)
    end
end


function sound_remove()
    if music then 
        destroyElement(music)
        music = false
    end
end

function table.random ( theTable )
    return theTable[math.random ( #theTable )]
end


------------------------------------------------
--add remove or sell server 
------------------------------------------------
function doing_action()
    if action_status == "add" then 
        if getPlayerMoney() < add_on_fee then 
            outputChatBox(language[language_section][23][1],language[language_section][23][2],language[language_section][23][3],language[language_section][23][4])
            setTimer(function() triggerServerEvent("exit_vehicle_bazaar",localPlayer) end,500,1)
            on_panel_open()
            return false
        end
        local id = dgsGetText(dgs.id_edit)
        local price = dgsGetText(dgs.price_edit)
        id = tonumber(id)
        price = tonumber(price)
        if type(id) ~= "number" or type(price) ~= "number" then 
            action_status = "add"
            approval_selection = 3
            dgsSetText(dgs.id_edit,language[language_section][21][1])
            dgsSetText(dgs.price_edit,language[language_section][21][2])
            return false
        end
        local player_vehicles = exports["meta_vehicleget"]:export_player_vehicles()
        local status = true
        for k,v in ipairs(player_vehicles) do 
            if v[1] == id  and v[6] == 0 then
                triggerServerEvent("add_vehicle",localPlayer,id,price,v[2],v[3],v[4],v[5])
                status = false
                break 
            end
        end
        if status then 
            action_status = "add"
            approval_selection = 3
            dgsSetText(dgs.id_edit,language[language_section][22][1])
            dgsSetText(dgs.price_edit,language[language_section][22][2])
            return false
        end
        return true
    elseif action_status == "remove" then 
        local id = dgsGetText(dgs.id_edit)
        id = tonumber(id)
        if type(id) ~= "number" then 
            action_status = "remove"
            approval_selection = 3
            dgsSetText(dgs.id_edit,language[language_section][21][1])
            dgsSetText(dgs.price_edit,language[language_section][21][2])
            return false
        end
        local player_vehicles = exports["meta_vehicleget"]:export_player_vehicles()
        local status = true
        for k,v in ipairs(player_vehicles) do 
            if v[1] == id  and v[6] == 1 then
                triggerServerEvent("remove_vehicle",localPlayer,id,v[2])
                status = false
                break 
            end
        end
        if status then 
            action_status = "remove"
            approval_selection = 3
            dgsSetText(dgs.id_edit,language[language_section][22][1])
            dgsSetText(dgs.price_edit,language[language_section][22][2])
            return false
        end
        return true
    elseif action_status == "scrap" then 
        local id = dgsGetText(dgs.id_edit)
        id = tonumber(id)
        if type(id) ~= "number" then 
            action_status = "scrap"
            approval_selection = 3
            dgsSetText(dgs.id_edit,language[language_section][21][1])
            dgsSetText(dgs.price_edit,language[language_section][21][2])
            return false
        end
        local player_vehicles = exports["meta_vehicleget"]:export_player_vehicles()
        local status = true
        for k,v in ipairs(player_vehicles) do 
            if v[1] == id  and v[6] == 0 then
                local stats = fromJSON(v[5])
                local result = (stats.price * vehicle_scrap_selling_percentage)/100
                triggerServerEvent("sell_to_scrap_vehicle",localPlayer,id,v[2],result)
                status = false
                break 
            end
        end
        if status then 
            action_status = "scrap"
            approval_selection = 3
            dgsSetText(dgs.id_edit,language[language_section][22][1])
            dgsSetText(dgs.price_edit,language[language_section][22][2])
            return false
        end
        return true
    end
end

--------------------------------------------------------
-- write vehicle scrap price ( - araç hurda fiyatını yaz - )
-------------------------------------------------------------
function vehicle_scrap_price_write()
    local id = dgsGetText(dgs.id_edit)
    id = tonumber(id)
    if type(id) ~= "number" then 
        action_status = "scrap"
        approval_selection = 3
        return false
    end
    local player_vehicles = exports["meta_vehicleget"]:export_player_vehicles()
    for k,v in ipairs(player_vehicles) do 
        if v[1] == id  and v[6] == 0 then
            local stats = fromJSON(v[5])
            local result = (stats.price * vehicle_scrap_selling_percentage)/100
            dgsSetText(dgs.price_edit,result.." $")
            break 
        end
    end
end


