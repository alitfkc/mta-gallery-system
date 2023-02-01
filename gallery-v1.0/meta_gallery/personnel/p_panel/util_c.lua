local vehicles = false

------------------------------------
--Personnell Panel Open
------------------------------------
local function p_panel_open_c(vehicles_t)
    if guiGetVisible(p_panel) then 
        guiSetVisible(p_panel,false)
        removeEventHandler("onClientGUIDoubleClick",p_p_cars_list,p_p_double_click,false)
        removeEventHandler("onClientGUIChanged",gui.search_vehicle,p_p_changed)
        for k,v in pairs(gui) do 
            removeEventHandler("onClientGUIClick",v,p_p_button_click)
        end
        showCursor(false)
    else
        guiGridListClear(p_p_cars_list)
        vehicles = vehicles_t
        if vehicles_t then 
            p_p_gridlist_set_alphabetic()
        end
        guiSetVisible(p_panel,true)
        addEventHandler("onClientGUIDoubleClick",p_p_cars_list,p_p_double_click,false)
        addEventHandler("onClientGUIChanged",gui.search_vehicle,p_p_changed)
        for k,v in pairs(gui) do 
            addEventHandler("onClientGUIClick",v,p_p_button_click)
        end
        showCursor(true)
    end
end
addEvent("p_panel_open",true)
addEventHandler("p_panel_open",localPlayer,p_panel_open_c)


-------------------------------------------------------------
-- personnel panel gridlist double click ( - araçlar listesine çift tıklama - )
-------------------------------------------------------------
function p_p_double_click()
    local selected_row  = guiGridListGetSelectedItem(p_p_cars_list)
    local id = guiGridListGetItemText(p_p_cars_list,selected_row,1)
    local brand = guiGridListGetItemText(p_p_cars_list,selected_row,2)
    local model = guiGridListGetItemText(p_p_cars_list,selected_row,3)
    local model_year = guiGridListGetItemText(p_p_cars_list,selected_row,4)
    local price = guiGridListGetItemText(p_p_cars_list,selected_row,5)
    local stock = guiGridListGetItemText(p_p_cars_list,selected_row,6)
    guiSetText(gui.id,id)
    guiSetText(gui.brand,brand)
    guiSetText(gui.model,model)
    guiSetText(gui.model_year,model_year)
    guiSetText(gui.price,price)
    guiSetText(gui.stock,stock)
end


------------------------------------------------------------
--personnel panel search car ( - araba arama -)
-----------------------------------------------------------
function p_p_changed()
    local text = guiGetText(gui.search_vehicle)
    if text ~= "" then 
        guiGridListClear(p_p_cars_list)
        if type(tonumber(text)) == "number"  then 
            for k,v in ipairs(vehicles) do 
                local t_id = v.id or v[2]
                if string.find(t_id,text,1,true) then 
                    t_brand = v.brand or v[2]
                    t_model = v.model or v[3]
                    t_model_year = v.model_year or v[4]
                    t_price = v.price or v[5]
                    t_stock = v.stock or  v[6]
                    t_price = tonumber(t_price) 
                    t_stock = tonumber(t_stock)
                    guiGridListAddRow(p_p_cars_list,t_id, t_brand,t_model,t_model_year,t_price,t_stock)
                end
            end
        else
            local result = string.upper(string.sub(text, 1,1))
            text = result..string.sub(text,2,string.len(text))
            for k,v in ipairs(vehicles) do 
                local t_brand = v.brand or v[2]
                if string.find(t_brand,text,1,true) then 
                    t_id = v.id or v[1]
                    t_model = v.model or v[3]
                    t_model_year = v.model_year or v[4]
                    t_price = v.price or v[5]
                    t_stock = v.stock or  v[6]
                    t_price = tonumber(t_price) 
                    t_stock = tonumber(t_stock)
                    guiGridListAddRow(p_p_cars_list,t_id, t_brand,t_model,t_model_year,t_price,t_stock)
                end
            end
        end
    else
        p_p_gridlist_set_alphabetic()
    end
end


------------------------------------------------------
--personnel panel buttons click
------------------------------------------------------
function p_p_button_click()
    if source == gui.add_remove_car then 
        local id = guiGetText(gui.id)
        local brand = guiGetText(gui.brand)
        local model = guiGetText(gui.model)
        local model_year = guiGetText(gui.model_year)
        local price = guiGetText(gui.price)
        local stock = guiGetText(gui.stock)
        if type(tonumber(price)) ~= "number" then return print("price is not a number ( - fiyat bir sayı değil! -)") end
        if type(tonumber(stock)) ~= "number" then return print("stock is not a number ( - stok bir sayı değil! -)") end
        id = tonumber(id)
        price = tonumber(price)
        stock = tonumber(stock)
        local result = string.upper(string.sub(brand, 1,1))
        brand = result..string.sub(brand,2,string.len(brand))
        local result = string.upper(string.sub(model, 1,1))
        model = result..string.sub(model,2,string.len(model))
        triggerServerEvent("add_or_remove_car",localPlayer,id,brand,model,model_year,price,stock)
        p_p_add_or_remove_gridlist(id,brand,model,model_year,price,stock)
        p_p_gridlist_set_alphabetic()
    elseif source == gui.change_id then 
        local id = guiGetText(gui.id)
        local brand = guiGetText(gui.brand)
        local model = guiGetText(gui.model)
        local model_year = guiGetText(gui.model_year)
        local price = guiGetText(gui.price)
        local stock = guiGetText(gui.stock)
        if type(tonumber(price)) ~= "number" then return print("price is not a number ( - fiyat bir sayı değil! -)") end
        if type(tonumber(stock)) ~= "number" then return print("stock is not a number ( - stok bir sayı değil! -)") end
        price = tonumber(price)
        stock = tonumber(stock)
        local result = string.upper(string.sub(brand, 1,1))
        brand = result..string.sub(brand,2,string.len(brand))
        local result = string.upper(string.sub(model, 1,1))
        model = result..string.sub(model,2,string.len(model))
        triggerServerEvent("change_id_db",localPlayer,id,brand,model,model_year,price,stock)
        for k,v in ipairs(vehicles) do 
            t_id = v.id or v[1]
            t_brand = v.brand or v[2]
            t_model = v.model or v[3]
            t_model_year = v.model_year or v[4]
            t_price = v.price or v[5]
            t_stock = v.stock or  v[6]
            t_id = tonumber(t_id)
            t_price = tonumber(t_price) 
            t_stock = tonumber(t_stock)
            if  t_brand == brand and t_model == model and t_model_year == model_year and t_price == price and t_stock == stock then 
                if v.id then 
                    v.id = id
                else
                    v[1]  = id
                end
            end
        end
        p_p_gridlist_set_alphabetic()
    elseif source == gui.change_brand then 
        local id = guiGetText(gui.id)
        local brand = guiGetText(gui.brand)
        local model = guiGetText(gui.model)
        local model_year = guiGetText(gui.model_year)
        local price = guiGetText(gui.price)
        local stock = guiGetText(gui.stock)
        if type(tonumber(price)) ~= "number" then return print("price is not a number ( - fiyat bir sayı değil! -)") end
        if type(tonumber(stock)) ~= "number" then return print("stock is not a number ( - stok bir sayı değil! -)") end
        id = tonumber(id)
        price = tonumber(price)
        stock = tonumber(stock)
        local result = string.upper(string.sub(brand, 1,1))
        brand = result..string.sub(brand,2,string.len(brand))
        local result = string.upper(string.sub(model, 1,1))
        model = result..string.sub(model,2,string.len(model))
        triggerServerEvent("change_brand_db",localPlayer,id,brand,model,model_year,price,stock)
        for k,v in ipairs(vehicles) do 
            t_id = v.id or v[1]
            t_brand = v.brand or v[2]
            t_model = v.model or v[3]
            t_model_year = v.model_year or v[4]
            t_price = v.price or v[5]
            t_stock = v.stock or  v[6]
            t_id = tonumber(t_id)
            t_price = tonumber(t_price) 
            t_stock = tonumber(t_stock)
            if  t_id == id and t_model == model and t_model_year == model_year and t_price == price and t_stock == stock then 
                if v.brand then 
                    v.brand = brand
                else
                    v[2] = brand
                end
            end
        end
        p_p_gridlist_set_alphabetic()
    elseif source == gui.change_model then 
        local id = guiGetText(gui.id)
        local brand = guiGetText(gui.brand)
        local model = guiGetText(gui.model)
        local model_year = guiGetText(gui.model_year)
        local price = guiGetText(gui.price)
        local stock = guiGetText(gui.stock)
        if type(tonumber(price)) ~= "number" then return print("price is not a number ( - fiyat bir sayı değil! -)") end
        if type(tonumber(stock)) ~= "number" then return print("stock is not a number ( - stok bir sayı değil! -)") end
        id = tonumber(id)
        price = tonumber(price)
        stock = tonumber(stock)
        local result = string.upper(string.sub(brand, 1,1))
        brand = result..string.sub(brand,2,string.len(brand))
        local result = string.upper(string.sub(model, 1,1))
        model = result..string.sub(model,2,string.len(model))
        triggerServerEvent("change_model_db",localPlayer,id,brand,model,model_year,price,stock)
        for k,v in ipairs(vehicles) do 
            t_id = v.id or v[1]
            t_brand = v.brand or v[2]
            t_model = v.model or v[3]
            t_model_year = v.model_year or v[4]
            t_price = v.price or v[5]
            t_stock = v.stock or  v[6]
            t_id = tonumber(t_id)
            t_price = tonumber(t_price) 
            t_stock = tonumber(t_stock)
            if t_id == id and t_brand == brand and t_model_year == model_year and t_price == price and t_stock == stock then 
                if v.model then 
                    v.model = model
                else
                    v[3] = model
                end
            end
        end
        p_p_gridlist_set_alphabetic()
    elseif source == gui.change_model_year then 
        local id = guiGetText(gui.id)
        local brand = guiGetText(gui.brand)
        local model = guiGetText(gui.model)
        local model_year = guiGetText(gui.model_year)
        local price = guiGetText(gui.price)
        local stock = guiGetText(gui.stock)
        if type(tonumber(price)) ~= "number" then return print("price is not a number ( - fiyat bir sayı değil! -)") end
        if type(tonumber(stock)) ~= "number" then return print("stock is not a number ( - stok bir sayı değil! -)") end
        id = tonumber(id)
        price = tonumber(price)
        stock = tonumber(stock)
        local result = string.upper(string.sub(brand, 1,1))
        brand = result..string.sub(brand,2,string.len(brand))
        local result = string.upper(string.sub(model, 1,1))
        model = result..string.sub(model,2,string.len(model))
        triggerServerEvent("change_model_year_db",localPlayer,id,brand,model,model_year,price,stock)
        for k,v in ipairs(vehicles) do 
            t_id = v.id or v[1]
            t_brand = v.brand or v[2]
            t_model = v.model or v[3]
            t_model_year = v.model_year or v[4]
            t_price = v.price or v[5]
            t_stock = v.stock or  v[6]
            t_id = tonumber(t_id)
            t_price = tonumber(t_price) 
            t_stock = tonumber(t_stock)
            if  t_id == id and t_brand == brand and t_model == model and t_price == price and t_stock == stock then 
                if v.model_year then 
                    v.model_year = model_year
                else
                    v[4] = model_year
                end
            end
        end
        p_p_gridlist_set_alphabetic()
    elseif source == gui.change_price then 
        local id = guiGetText(gui.id)
        local brand = guiGetText(gui.brand)
        local model = guiGetText(gui.model)
        local model_year = guiGetText(gui.model_year)
        local price = guiGetText(gui.price)
        local stock = guiGetText(gui.stock)
        if type(tonumber(price)) ~= "number" then return print("price is not a number ( - fiyat bir sayı değil! -)") end
        if type(tonumber(stock)) ~= "number" then return print("stock is not a number ( - stok bir sayı değil! -)") end
        id = tonumber(id)
        price = tonumber(price)
        stock = tonumber(stock)
        local result = string.upper(string.sub(brand, 1,1))
        brand = result..string.sub(brand,2,string.len(brand))
        local result = string.upper(string.sub(model, 1,1))
        model = result..string.sub(model,2,string.len(model))
        triggerServerEvent("change_price_db",localPlayer,id,brand,model,model_year,price,stock)
        for k,v in ipairs(vehicles) do 
            t_id = v.id or v[1]
            t_brand = v.brand or v[2]
            t_model = v.model or v[3]
            t_model_year = v.model_year or v[4]
            t_price = v.price or v[5]
            t_stock = v.stock or  v[6]
            t_id = tonumber(t_id)
            t_price = tonumber(t_price) 
            t_stock = tonumber(t_stock)
            if  t_id == id and t_brand == brand and t_model == model and t_model_year== model_year and t_stock == stock then 
                if v.price then 
                    v.price = price
                else
                    v[5] = price
                end
            end
        end
        p_p_gridlist_set_alphabetic()
    elseif source == gui.change_stock then 
        local id = guiGetText(gui.id)
        local brand = guiGetText(gui.brand)
        local model = guiGetText(gui.model)
        local model_year = guiGetText(gui.model_year)
        local price = guiGetText(gui.price)
        local stock = guiGetText(gui.stock)
        if type(tonumber(price)) ~= "number" then return print("price is not a number ( - fiyat bir sayı değil! -)") end
        if type(tonumber(stock)) ~= "number" then return print("stock is not a number ( - stok bir sayı değil! -)") end
        id = tonumber(id)
        price = tonumber(price)
        stock = tonumber(stock)
        local result = string.upper(string.sub(brand, 1,1))
        brand = result..string.sub(brand,2,string.len(brand))
        local result = string.upper(string.sub(model, 1,1))
        model = result..string.sub(model,2,string.len(model))
        triggerServerEvent("change_stock_db",localPlayer,id,brand,model,model_year,price,stock)
        for k,v in ipairs(vehicles) do 
            t_id = v.id or v[1]
            t_brand = v.brand or v[2]
            t_model = v.model or v[3]
            t_model_year = v.model_year or v[4]
            t_price = v.price or v[5]
            t_stock = v.stock or  v[6]
            t_id = tonumber(t_id)
            t_price = tonumber(t_price) 
            t_stock = tonumber(t_stock)
            if  t_id == id and t_brand == brand and t_model == model and t_model_year == model_year and t_price == price then 
                if v.stock then 
                    v.stock = stock
                else
                    v[6] = stock
                end
            end
        end
        p_p_gridlist_set_alphabetic()
    elseif source == gui.search_vehicle then 
        guiSetText(gui.search_vehicle,"")
    end
end

-----------------------------------------------------
-- personnel panel gridlist add or remove row ( - Gridliste araç ekle veya kaldır -)
------------------------------------------------------
function p_p_add_or_remove_gridlist(id,brand,model,model_year,price,stock)
    local state = true
    print("1")
    for k,v in ipairs(vehicles) do 
        t_id = v.id or v[1]
        t_brand = v.brand or v[2]
        t_model = v.model or v[3]
        t_model_year = v.model_year or v[4]
        t_price = v.price or v[5]
        t_stock = v.stock or  v[6]
        t_id = tonumber(t_id)
        t_price = tonumber(t_price) 
        t_stock = tonumber(t_stock)
        if t_id == id  and t_brand == brand and t_model == model and t_model_year == model_year and t_price == price and t_stock == stock then 
            table.remove(vehicles,k)
            print("a")
            state = false
        end
    end
    if state then 
        table.insert(vehicles,{id,brand,model,model_year,price,stock})
    end
end


----------------------------------------------------------
--GridtList set alphabetic ( - Gridlisti alfabetik yap -)
----------------------------------------------------------
local alphabe = {"A","B","C","Ç","D","E","F","G","Ğ","H","İ","I","J","K","L","M","N","O","Ö","P","R","S","Ş","T","U","Ü","V","Y","Z"}
function p_p_gridlist_set_alphabetic()
    guiGridListClear(p_p_cars_list)
    for s,a in pairs(alphabe) do 
        for k,v in ipairs(vehicles) do  
            t_id = v.id or v[1]
            t_brand = v.brand or v[2]
            t_model = v.model or v[3]
            t_model_year = v.model_year or v[4]
            t_price = v.price or v[5]
            t_stock = v.stock or  v[6]
            t_price = tonumber(t_price) 
            t_stock = tonumber(t_stock)
            if string.sub(t_brand,1,1) == a then 
                guiGridListAddRow(p_p_cars_list,t_id, t_brand,t_model,t_model_year,t_price,t_stock)
            end
        end
    end
end
