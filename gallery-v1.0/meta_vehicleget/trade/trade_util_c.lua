local action_status = false
local trade_items = {}
local trade_money = 0
local trade_p = false
--------------------------------
-- Click Trade Buttons
--------------------------------
function dgs_trade_click()
    if source == dgs.trade_btn then 
        if dgsGetVisible(trade_panel) then dgsAlertAnim(trade_panel) return end
        show_players()
    elseif source == dgs.select_player_btn then 

        if dgsGetVisible(player_list_panel) then
            local Selected = dgsGridListGetSelectedItem(player_list)
            if Selected ~=-1 then 
                local selected_player_name = dgsGridListGetItemText(player_list,Selected,pl_col2)
                triggerServerEvent("send_trade_request",localPlayer,selected_player_name)
                show_players()
            end
        end
    elseif source == dgs.add_vehicle_trade then 
        if dgsGetVisible(vehicle_add_rev_panel) then 
            action_status = false
            dgsSetVisible(vehicle_add_rev_panel,false)
        else
            dgsSetVisible(vehicle_add_rev_panel,true)
            dgsBringToFront(vehicle_add_rev_panel)
            dgsSetEnabled(dgs.id_edit,true)
            action_status = "add_remove"
            approval_selection = 3
            dgsSetText(dgs.approval_btn,language[language_section][25][1])
            dgsSetText(dgs.price_edit,"")
            dgsSetEnabled(dgs.price_edit,false)
            dgsSetText(dgs.id_edit,"")
        end
    elseif source == dgs.lock_trade then 
        dgsSetEnabled(dgs.add_vehicle_trade,false)
        dgsSetEnabled(dgs.lock_trade,false)
        dgsSetEnabled(dgs.add_money_trade,false)
        dgsSetEnabled(dgs.show_trade,false)
        dgsSetText(label_p1,"<"..language[language_section][35][1].."\n"..language[language_section][37][1].."\n"..language[language_section][38][1])
        dgsLabelSetColor(label_p1,0,255,0)
        triggerServerEvent("sent_server_trade_items",localPlayer,trade_items,trade_money,true)
    elseif source == dgs.add_money_trade then 
        if dgsGetVisible(vehicle_add_rev_panel) then 
            action_status = false
            dgsSetVisible(vehicle_add_rev_panel,false)
        else
            dgsSetVisible(vehicle_add_rev_panel,true)
            dgsBringToFront(vehicle_add_rev_panel)
            dgsSetEnabled(dgs.id_edit,false)
            action_status = "money_add"
            approval_selection = 3
            dgsSetText(dgs.approval_btn,language[language_section][25][1])
            dgsSetText(dgs.price_edit,"")
            dgsSetEnabled(dgs.price_edit,true)
            dgsSetText(dgs.id_edit,"")
        end
    elseif source == dgs.show_trade then 
        triggerServerEvent("sent_server_trade_items",localPlayer,trade_items,trade_money,false)
    elseif source == dgs.approval_trade then 
        triggerServerEvent("sent_server_trade_items",localPlayer,trade_items,trade_money,true)
        triggerServerEvent("approval_trade",localPlayer,trade_items,trade_money)
    elseif source == dgs.approval_btn then 
        if approval_selection < 0 then 
            local status  = doing_action()
            if status then 
                dgsSetVisible(vehicle_add_rev_panel,false)
                approval_selection = 3
                action_status = false
            end
        else
            dgsSetText(dgs.approval_btn,language[language_section][25][1].."("..approval_selection..")")
            approval_selection = approval_selection - 1
        end
    elseif source == dgs.close_approval_btn then 
        dgsSetVisible(vehicle_add_rev_panel,false)
        approval_selection = 3
        action_status = false
    elseif source == dgs.close_trade then 
        triggerServerEvent("stop_trade_server",localPlayer)
    end
end

--------------------------------------
-- Show Players List
--------------------------------------
function show_players()
    if dgsGetVisible(player_list_panel) then
        dgsSetVisible(player_list_panel,false)
        dgsSetVisible(dgs.select_player_btn,false)
    else
        dgsGridListClear(player_list)
        dgsSetVisible(player_list_panel,true)
        dgsSetVisible(dgs.select_player_btn,true)
        local px,py,pz = getElementPosition(localPlayer)
        for k,v in ipairs(getElementsByType("player")) do 
            if v ~= localPlayer then
                local sx,sy,sz = getElementPosition(v)
                local range = getDistanceBetweenPoints3D(px,py,pz,sx,sy,sz)
                if range < trade_range then
                    local row = dgsGridListAddRow(player_list,"",string.gsub(getPlayerName(v), "#%x%x%x%x%x%x", ""),getPlayerName(v) ) 
                end
            end
        end
    end
end

---------------------------------------------------------------
-- Open Trande (- Takas aç)
---------------------------------------------------------------
function trade_open(p)
    trade_p = p
    dgsSetText(trade_panel,panel_name.." "..string.gsub(getPlayerName(localPlayer), "#%x%x%x%x%x%x", "").." TRADE "..string.gsub(getPlayerName(p), "#%x%x%x%x%x%x", ""))
    dgsSetText(label_p2,string.gsub(getPlayerName(p), "#%x%x%x%x%x%x", "")..">\n"..language[language_section][36][1].."\n"..language[language_section][38][1])
    dgsSetVisible(trade_panel,true)
    dgsSetVisible(dgs.close_trade,true)
    dgsSetVisible(dgs.add_vehicle_trade,true)
    dgsSetVisible(dgs.lock_trade,true)
    dgsSetVisible(dgs.add_money_trade,true)
    dgsSetVisible(dgs.show_trade,true)
    dgsSetVisible(dgs.approval_trade,true)
    dgsSetEnabled(dgs.add_vehicle_trade,true)
    dgsSetEnabled(dgs.lock_trade,true)
    dgsSetEnabled(dgs.add_money_trade,true)
    dgsSetEnabled(dgs.show_trade,true)
    dgsLabelSetColor(label_p1,255,255,255)
    dgsLabelSetColor(label_p2,255,255,255)
end
addEvent("open_trade_request",true)
addEventHandler("open_trade_request",localPlayer,trade_open)

--------------------------------------------------------;
-- ADD vehicle trade list
---------------------------------------------------------
function add_remove_vehicle_trade_list()
    local id = dgsGetText(dgs.id_edit)
    id = tonumber(id)
    if type(id) ~= "number" then 
        action_status = "add"
        approval_selection = 3
        dgsSetText(dgs.id_edit,language[language_section][33][1])
        return false
    end
    local state = false
    for k,v in ipairs(trade_items) do 
        if v.id == id  then
            v = nil    
            dgsGridListClear(trade_player1_list)
            state = true
            break
        end
    end
    if state  then 
        for k,v in ipairs(trade_items) do 
            local stat =  fromJSON(v.stats)
            local price = convert_decimal(stat.price)
            local km = convert_km(stat.km)
            local damage = convert_decimal(stat.damage)
            local row = dgsGridListAddRow(trade_player1_list,"",v.id,v.v_name,price,km,damage)
        end
    end

    local player_vehicles_d = player_vehicles
    status = true
    for k,v in ipairs(player_vehicles_d) do 
        if v[1] == id  and v[6] == 0 then
            table.insert(trade_items,{id=v[1],v_name=v[4],stats=v[5]})
            local stat = fromJSON(v[5])
            local price = convert_decimal(stat.price)
            local km = convert_km(stat.km)
            local damage = convert_decimal(stat.damage)
            local row = dgsGridListAddRow(trade_player1_list,"",v[1],v[4],price,km,damage)
            status = false
            break 
        end
    end
    if status then 
        action_status = "add"
        approval_selection = 3
        dgsSetText(dgs.id_edit,language[language_section][33][1])
        return false
    end
    return true
end

-------------------------------------------------------------
--add money (trade)
--------------------------------------------------------------
function add_money_trade()
    local money = dgsGetText(dgs.price_edit)
    money = tonumber(money)
    if money < 0 then 
        dgsAlertAnim(vehicle_add_rev_panel,true)
        return 
    end

    if type(money) ~= "number" then 
        action_status = "money_add"
        approval_selection = 3
        dgsSetText(dgs.price_edit,language[language_section][32][1])
        return false
    end
    if money <= getPlayerMoney(localPlayer) then 
        trade_money = money
        dgsSetText(dgs.trade_money_p1,money..money_type)
    else
        dgsAlertAnim(vehicle_add_rev_panel,true)
        outputChatBox(language[language_section][34][1],255,0,0)
        return false
    end
    return true
end

--------------------------------------------------------------
-- Add or Remove Vehicle  and add money
--------------------------------------------------------------
function doing_action()
    if action_status == "add_remove" then 
        return add_remove_vehicle_trade_list()
    elseif action_status == "money_add" then 
        return add_money_trade()
    end
end

----------------------------------------------------------------------
-- Show trade items 
----------------------------------------------------------------------
function show_trade_items(items,p2_money,state)
    dgsGridListClear(trade_player2_list)
    for k,v in ipairs(items) do 
        local stat = fromJSON(v.stats)
        local price = convert_decimal(stat.price)
        local km = convert_km(stat.km)
        local damage = convert_decimal(stat.damage)
        local row = dgsGridListAddRow(trade_player2_list,"",v.id,v.v_name,price,km,damage)
    end
    dgsSetText(dgs.trade_money_p2,p2_money..money_type)
    if state then 
        dgsSetText(label_p2,string.gsub(getPlayerName(trade_p), "#%x%x%x%x%x%x", "")..">\n"..language[language_section][37][1].."\n"..language[language_section][38][1])
        dgsLabelSetColor(label_p2,0,255,0)
    end
end
addEvent("show_trade_items",true)
addEventHandler("show_trade_items",localPlayer,show_trade_items)



function confirmed_trade_request()
    dgsSetText(label_p2,string.gsub(getPlayerName(trade_p), "#%x%x%x%x%x%x", "")..">\n"..language[language_section][37][1].."\n"..language[language_section][39][1])
    dgsLabelSetColor(label_p2,0,255,0)
end
addEvent("confirmed_trade_request",true)
addEventHandler("confirmed_trade_request",root,confirmed_trade_request)


--------------------------------------------
--Stop Trade ( - client - )
--------------------------------------------
function stop_trade_client()
    dgsSetVisible(trade_panel,false)
    dgsSetVisible(dgs.close_trade,false)
    dgsSetVisible(dgs.add_vehicle_trade,false)
    dgsSetVisible(dgs.lock_trade,false)
    dgsSetVisible(dgs.add_money_trade,false)
    dgsSetVisible(dgs.show_trade,false)
    dgsSetVisible(dgs.approval_trade,false)
    dgsSetEnabled(dgs.add_vehicle_trade,false)
    dgsSetEnabled(dgs.lock_trade,false)
    dgsSetEnabled(dgs.add_money_trade,false)
    dgsSetEnabled(dgs.show_trade,false)
    dgsSetVisible(vehicle_add_rev_panel,false)
    dgsGridListClear(trade_player1_list)
    dgsGridListClear(trade_player2_list)
    dgsSetText(dgs.trade_money_p1,"0"..money_type)
    dgsSetText(dgs.trade_money_p2,"0"..money_type)
    action_status = false
    trade_items = {}
    trade_money = 0
    trade_p = false
    open_panel()
end

addEvent("stop_trade_client",true)
addEventHandler("stop_trade_client",localPlayer,stop_trade_client)