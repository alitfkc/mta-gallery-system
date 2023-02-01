-----------------------------------------------------
-- exit vehicle shop ( - araç mağazından çıkma - )
------------------------------------------------------
function exit_shop() 
    local x,y,z = unpack(marker_exit_t[source])
    setElementInterior(source,0)
    setElementPosition(source,x,y,z)
    setCameraTarget(source)
    marker_exit_t[source] = nil
end
addEvent("exit_vehicle_shop",true)
addEventHandler("exit_vehicle_shop",root,exit_shop)

---------------------------------------------------
-- test drive ( - test sürüşü - )
---------------------------------------------------
local vehicle_test_t = {}
function test_drive_s(id)
    local x,y,z,rz = unpack(marker_players[source])
    setElementInterior(source,0)
    local vehicle = createVehicle(id,x,y,z,0,0,rz)
    warpPedIntoVehicle(source,vehicle)
    outputChatBox(language[language_section][38][1],source,language[language_section][38][2],language[language_section][38][3],language[language_section][38][4])
    setCameraTarget(source)
    setVehicleLocked(vehicle,true)
    local test_timer = setTimer(remove_vehicle,test_drive_time,1,vehicle,source)
    vehicle_test_t[source] = {test_timer,vehicle}
end
addEvent("test_drive",true)
addEventHandler("test_drive",root,test_drive_s)

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
function purchase_vehicle_s(id,brand,model,model_year,price,stock)
    local x,y,z = unpack(marker_players[source])
    setElementInterior(source,0)
    setElementPosition(source,x,y,z)
    setCameraTarget(source)
    marker_players[source] = nil
    local account = getPlayerAccount(source)
    if not account then return end
    if not exports["meta_vehicleget"]:get_buying_limit(getAccountName(account)) then  outputChatBox(language[language_section][41][1],source,language[language_section][41][2],language[language_section][41][3],language[language_section][41][4]) return end
    for k,v in ipairs(global_vehicle) do 
        if v.id == id and v.brand == brand and v.model == model and v.model_year == model_year and v.price == price and v.stock == stock then 
            if stock > 0 then 
                local player_money = getPlayerMoney(source)
                if player_money >= price then 
                    takePlayerMoney(source,price)
                    stock = stock - 1
                    v.stock = stock
                    buying_vehicle_db(id,brand,model,model_year,price,stock)
                    exports["meta_vehicleget"]:add_player_vehicle(getAccountName(account),id,brand,model,model_year,price,source)
                    for s,p in ipairs(getElementsByType("player")) do 
                        if marker_players[p] and p ~= source then 
                            triggerClientEvent("refresh_vehicles_sell_list",p,global_vehicle)
                        end
                    end
                    outputChatBox("Başarıyla "..brand.." "..model.." aracı aldınız.",source,255,0,0)
                else
                    outputChatBox(language[language_section][40][1],source,language[language_section][40][2],language[language_section][40][3],language[language_section][40][4])
                end
            else
                outputChatBox(language[language_section][39][1],source,language[language_section][39][2],language[language_section][39][3],language[language_section][39][4])
            end
        end
    end
end
addEvent("purchase_vehicle",true)
addEventHandler("purchase_vehicle",root,purchase_vehicle_s)

---------metazon link
addEvent("market_arac_satin_alma",true)
addEventHandler("market_arac_satin_alma",root,function(account_name,id)
    --if not exports["meta_vehicleget"]:get_buying_limit(account_name) then  outputChatBox(language[language_section][41][1],source,language[language_section][41][2],language[language_section][41][3],language[language_section][41][4]) return end
    for k,v in ipairs(global_vehicle) do 
        if v.id == id then 
            exports["meta_vehicleget"]:add_player_vehicle(account_name,id,v.brand,v.model,v.model_year,v.price,source)
            outputChatBox("Başarıyla "..v.brand.." "..v.model.." aracı aldınız.",source,255,0,0)
        end
    end
end)