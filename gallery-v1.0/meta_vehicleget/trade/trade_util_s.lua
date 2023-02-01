--------------------------------------
--- Trade Request
--------------------------------------
request_trade_player = {}
trade_approval = {}
trade_items = {}
function trade_request(selected_player_name)
    local selected_player = getPlayerFromName(selected_player_name)
    local px,py,pz = getElementPosition(source)
    local sx,sy,sz = getElementPosition(selected_player)
    local range = getDistanceBetweenPoints3D(px,py,pz,sx,sy,sz)
    if range < trade_range then
        if request_trade_player[selected_player] == source and request_trade_player[source] == selected_player then 
            triggerClientEvent(source,"open_trade_request",source,selected_player)
            triggerClientEvent(selected_player,"open_trade_request",selected_player,source)
        else
            request_trade_player[source] = selected_player
            trade_approval[source] = "False"
            outputChatBox(string.gsub(getPlayerName(source), "#%x%x%x%x%x%x", "")..language[language_section][29][1],selected_player,255,255,0)
            outputChatBox(language[language_section][28][1],source,0,255,0)
        end
    else
        outputChatBox(language[language_section][31][1],selected_player,255,0,0)
    end
end
addEvent("send_trade_request",true)
addEventHandler("send_trade_request",root,trade_request)


-------------------------------------------------------
-- sent to show trade items from trading player
-------------------------------------------------------
function sent_to_trade_items(t,m,state)
    triggerClientEvent(request_trade_player[source],"show_trade_items",request_trade_player[source],t,m,state)
end
addEvent("sent_server_trade_items",true)
addEventHandler("sent_server_trade_items",root,sent_to_trade_items)


------------------------------------------------------------
-- Approval Trade 
-------------------------------------------------------------
function approval_trade(t,m)
    if trade_approval[source] == "False" then 
        trade_approval[source] = "True"
        trade_items[source] = {items = t,money = m}
        if trade_approval[request_trade_player[source]] == "True" then 
            doing_trade(source,request_trade_player[source])
        else
            triggerClientEvent(request_trade_player[source],"confirmed_trade_request",request_trade_player[source])
        end
    end
end
addEvent("approval_trade",true)
addEventHandler("approval_trade",root,approval_trade)


----------------------------------------------------------
-- Stop Trade ( - - )
----------------------------------------------------------
function stop_trade(p1,p2)

    triggerClientEvent(p1,"stop_trade_client",p1)

    request_trade_player[p1] = nil
    trade_approval[p1] = nil
    trade_items[p1] = nil
    if p2 then
        triggerClientEvent(p2,"stop_trade_client",p2)
        request_trade_player[p2] = nil
        trade_approval[p2] = nil
        trade_items[p2] = nil
    end

end

addEvent("stop_trade_server",true)
addEventHandler("stop_trade_server",root,function()
    if request_trade_player[request_trade_player[source]] == source then 
        stop_trade(source,request_trade_player[source])
    else
        stop_trade(source)
    end
end)
----------------------------------------------------------
-- Start Trade
-----------------------------------------------------------

function doing_trade(p1,p2)
    local p1_account_name = getAccountName(getPlayerAccount(p1))
    local p1_slot = get_player_vehicle_slot(p1_account_name)

    local p2_account_name = getAccountName(getPlayerAccount(p2))
    local p2_slot = get_player_vehicle_slot(p2_account_name)

    local p1_items = trade_items[p1]
    local p2_items = trade_items[p2]

    if #p2_items >= p1_slot then 
        outputChatBox(string.gsub(getPlayerName(p1), "#%x%x%x%x%x%x", "")..language[language_section][40][1],p1,255,0,0)
        outputChatBox(string.gsub(getPlayerName(p1), "#%x%x%x%x%x%x", "")..language[language_section][40][1],p2,255,0,0)
        stop_trade(p1,p2)
        return 
    end

    if #p1_items >= p2_slot then 
        outputChatBox(string.gsub(getPlayerName(p2), "#%x%x%x%x%x%x", "")..language[language_section][40][1],p1,255,0,0)
        outputChatBox(string.gsub(getPlayerName(p2), "#%x%x%x%x%x%x", "")..language[language_section][40][1],p2,255,0,0)
        stop_trade(p1,p2)
        return
    end

    --give vehicles
    for k,v in pairs(p1_items.items) do 
        add_player_vehicle_to_bazaar(p2_account_name,v.id,p1_account_name)
        local player_veh = getElementByID("arac"..v.id)
        if player_veh then
            triggerEvent("delete_vehicle",p1,v.id)  
        end
    end

    for k,v in pairs(p2_items.items) do 
        add_player_vehicle_to_bazaar(p1_account_name,v.id,p2_account_name)
        local player_veh = getElementByID("arac"..v.id)
        if player_veh then
            triggerEvent("delete_vehicle",p1,v.id)  
        end
    end

    --Give Money
    takePlayerMoney(p1,p1_items.money)
    takePlayerMoney(p2,p2_items.money)

    givePlayerMoney(p1,p2_items.money)
    givePlayerMoney(p2,p1_items.money)

    outputChatBox(language[language_section][41][1],p1,255,0,0)
    outputChatBox(language[language_section][41][1],p2,255,0,0)

    
    stop_trade(p1,p2)
end
