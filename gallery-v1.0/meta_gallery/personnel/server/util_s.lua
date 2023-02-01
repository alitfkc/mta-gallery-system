shopping_permit = true --block purchase if personnel panel is open
---------------------------------------------
--Open the personnel panel ( - personel paneli açma -) -server
local personnel_player = {}
function p_panel_open(thePlayer)
    local hesap = getAccountName ( getPlayerAccount ( thePlayer ) )
    if isObjectInACLGroup ("user."..hesap, aclGetGroup ( personnel_panel_aclgroup) ) then 
        local vehicles = false
        if personnel_player[thePlayer] then 
            personnel_player[thePlayer] = nil
        else
            personnel_player[thePlayer] = thePlayer
            vehicles =  get_cars_table()
        end
        local status = false
        for k,v in pairs(personnel_player) do 
            status = true
        end
        if status then 
            shopping_permit = false
        else
            shopping_permit = true
            resource_start_db()
        end
        triggerClientEvent(thePlayer, "p_panel_open" ,thePlayer,vehicles) 
    end
end
addCommandHandler(personnel_panel_command,p_panel_open)

---------------------------------------------
-- function of add or remove car ( - Araç ekleme ve silme işlevi - ) -server
-------------------------------------------------
function add_or_remove_car(id,brand,model,model_year,price,stock)
    local vehicles = get_cars_table()
    local status = true
    for k,v in ipairs(vehicles) do 
        if v.brand == brand and v.model == model and v.model_year == model_year and v.price == price and v.stock == stock then 
            status = false
        end
    end
    if status then 
        local status_return = add_vehicle_db(id,brand,model,model_year,price,stock)
        if status_return then 
            outputChatBox(language[language_section][23][1],source,language[language_section][23][2],language[language_section][23][3],language[language_section][23][4])
        else
            outputChatBox(language[language_section][24][1],source,language[language_section][24][2],language[language_section][24][3],language[language_section][24][4])
        end
    else
        local status_return = vehicle_remove_db(id,brand,model,model_year,price,stock)
        if status_return then 
            outputChatBox(language[language_section][21][1],source,language[language_section][21][2],language[language_section][21][3],language[language_section][21][4])
        else
            outputChatBox(language[language_section][22][1],source,language[language_section][22][2],language[language_section][22][3],language[language_section][22][4])
        end
    end
end
addEvent("add_or_remove_car",true)
addEventHandler("add_or_remove_car",root,add_or_remove_car)



---------------------------------------------------------
-- Change of db car id ( - db araç id değiştirilmesi -)
---------------------------------------------------------
function change_id(id,brand,model,model_year,price,stock)
    local status_return = change_vehicle_id_db(id,brand,model,model_year,price,stock)
    if status_return then 
        outputChatBox(language[language_section][26][1],source,language[language_section][26][2],language[language_section][26][3],language[language_section][26][4])
    else
        outputChatBox(language[language_section][27][1],source,language[language_section][27][2],language[language_section][27][3],language[language_section][27][4])
    end
end
addEvent("change_id_db",true)
addEventHandler("change_id_db",root,change_id)

---------------------------------------------------------
-- Change of db car brand ( - db araç marka ismi değiştirilmesi -)
---------------------------------------------------------
function change_brand(id,brand,model,model_year,price,stock)
    local status_return = change_vehicle_brand_db(id,brand,model,model_year,price,stock)
    if status_return then 
        outputChatBox(language[language_section][28][1],source,language[language_section][28][2],language[language_section][28][3],language[language_section][28][4])
    else
        outputChatBox(language[language_section][29][1],source,language[language_section][29][2],language[language_section][29][3],language[language_section][29][4])
    end
end
addEvent("change_brand_db",true)
addEventHandler("change_brand_db",root,change_brand)


---------------------------------------------------------
-- Change of db car model ( - db araç model ismi değiştirilmesi -)
---------------------------------------------------------
function change_model(id,brand,model,model_year,price,stock)
    local status_return = change_vehicle_model_db(id,brand,model,model_year,price,stock)
    if status_return then 
        outputChatBox(language[language_section][30][1],source,language[language_section][30][2],language[language_section][30][3],language[language_section][30][4])
    else
        outputChatBox(language[language_section][31][1],source,language[language_section][31][2],language[language_section][31][3],language[language_section][31][4])
    end
end
addEvent("change_model_db",true)
addEventHandler("change_model_db",root,change_model)

---------------------------------------------------------
-- Change of db car model_year ( - db araç model yılı değiştirilmesi -)
---------------------------------------------------------
function change_model_year(id,brand,model,model_year,price,stock)
    local status_return = change_vehicle_model_year_db(id,brand,model,model_year,price,stock)
    if status_return then 
        outputChatBox(language[language_section][32][1],source,language[language_section][32][2],language[language_section][32][3],language[language_section][32][4])
    else
        outputChatBox(language[language_section][33][1],source,language[language_section][33][2],language[language_section][33][3],language[language_section][33][4])
    end
end
addEvent("change_model_year_db",true)
addEventHandler("change_model_year_db",root,change_model_year)

---------------------------------------------------------
-- Change of db car price ( - db araç fiyat değiştirilmesi -)
---------------------------------------------------------
function change_price(id,brand,model,model_year,price,stock)
    local status_return = change_vehicle_price_db(id,brand,model,model_year,price,stock)
    if status_return then 
        outputChatBox(language[language_section][34][1],source,language[language_section][34][2],language[language_section][34][3],language[language_section][34][4])
    else
        outputChatBox(language[language_section][35][1],source,language[language_section][35][2],language[language_section][35][3],language[language_section][35][4])
    end
end
addEvent("change_price_db",true)
addEventHandler("change_price_db",root,change_price)

---------------------------------------------------------
-- Change of db car stock ( - db araç stok değiştirilmesi -)
---------------------------------------------------------
function change_stock(id,brand,model,model_year,price,stock)
    local status_return = change_vehicle_stock_db(id,brand,model,model_year,price,stock)
    if status_return then 
        outputChatBox(language[language_section][36][1],source,language[language_section][36][2],language[language_section][36][3],language[language_section][36][4])
    else
        outputChatBox(language[language_section][37][1],source,language[language_section][37][2],language[language_section][37][3],language[language_section][37][4])
    end
end
addEvent("change_stock_db",true)
addEventHandler("change_stock_db",root,change_stock)