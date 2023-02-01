local new_id = 0
function new_idd_aded()
    local result = 0
    for k,v in pairs(global_player_vehicle) do 
        for l,s in ipairs(v) do
            result = result + 1
        end
    end
    new_id = result
    print(new_id)
end
setTimer(new_idd_aded,500,1)
function add_player_vehicle(account_name,model_id,brand,model,model_year,price,player)
    local stats = {}
    stats.price = price
    stats.km = 0
    stats.damage = 0
    stats.r =  math.random( 255 )
    stats.g =  math.random( 255 )
    stats.b =  math.random( 255 )
    stats.upgrade = nil
    vehicle_name = brand.." "..model.." "..model_year
    stats = toJSON(stats)
    local free_rows_table = global_player_vehicle["meta_script"]
    if not free_rows_table then free_rows_table = {} end
    if free_rows_table[1] then 
        free_row_add_vehicle_db(free_rows_table[1][1],account_name,model_id,vehicle_name,stats,false)
        local aded = global_player_vehicle[account_name]
        if aded then 
            table.insert(aded,{free_rows_table[1][1],account_name,model_id,vehicle_name,stats,false})
            global_player_vehicle[account_name] = aded
        else
           aded = {}
            table.insert(aded,{free_rows_table[1][1],account_name,model_id,vehicle_name,stats,false})
            global_player_vehicle[account_name] = aded
        end
        local new_table = {}
        free_rows_table[1] = false
        for k,v in ipairs(free_rows_table) do
            if free_rows_table[k] then
                table.insert(new_table,free_rows_table[k])
            end
        end
        global_player_vehicle["meta_script"] = new_table
    else   
        new_id = new_id + 1
        local aded = global_player_vehicle[account_name] 
        if aded then 
            add_vehicle_db(account_name,model_id,vehicle_name,stats)
            table.insert(aded,{new_id,account_name,model_id,vehicle_name,stats,0})
            global_player_vehicle[account_name]  = aded
            local player_vehicles_s = {new_id,account_name,model_id,vehicle_name,stats,0,false}
            if player then
                triggerClientEvent("send_purchase_vehicle",player,player_vehicles_s)
            end
        else
            aded = {}
            add_vehicle_db(account_name,model_id,vehicle_name,stats)
            table.insert(aded,{new_id,account_name,model_id,vehicle_name,stats,0})
            global_player_vehicle[account_name]  = aded
            local player_vehicles_s = {new_id,account_name,model_id,vehicle_name,stats,0,false}
            if player then 
                triggerClientEvent("send_purchase_vehicle",player,player_vehicles_s)
            end
        end
    end
end

---------------------------------------
-- vehicle buying limit
---------------------------------------
function get_buying_limit(account_name)
    if account_name then 
        local player_vehicles = global_player_vehicle[account_name] 
        if not player_vehicles then player_vehicles = {} end
        local vehicles_number = 0
        for k,v in ipairs(player_vehicles) do
            vehicles_number = vehicles_number + 1
        end 
        local instant_limit = buying_limit 
        for k,v in ipairs(buying_limit_increase_acl) do
            if isObjectInACLGroup ("user."..account_name, aclGetGroup ( v[1] ) ) then 
                instant_limit = instant_limit + v[2]
            end
        end
        local result =  instant_limit - vehicles_number
        if result >= 1 then 
            return true
        else
            return false
        end
    end
end


---------------------------------------
-- player get free slots
---------------------------------------
function get_player_vehicle_slot(account_name)
    if account_name then 
        local player_vehicles = global_player_vehicle[account_name] 
        if not player_vehicles then player_vehicles = {} end
        local vehicles_number = 0
        for k,v in ipairs(player_vehicles) do
            vehicles_number = vehicles_number + 1
        end 
        local instant_limit = buying_limit 
        for k,v in ipairs(buying_limit_increase_acl) do
            if isObjectInACLGroup ("user."..account_name, aclGetGroup ( v[1] ) ) then 
                instant_limit = instant_limit + v[2]
            end
        end
        local result =  instant_limit - vehicles_number
        return result
    end
end
----------------------------------------
-- vehicle selling ( - araç satma - )
----------------------------------------
function sell_vehicle_bazaar(id,account_name,player)
    local status = false
    local player_vehicle = global_player_vehicle[account_name]
    for k,v in ipairs(player_vehicle) do 
        if v[1] == id then 
            v[6] = 1
            status = sell_vehicle_db(id,true)
            if status then 
                triggerClientEvent("send_player_vehicles",player,player_vehicle)
                global_player_vehicle[account_name] = player_vehicle
            end
            break
        end
    end
    return status
end

----------------------------------------
--vehicle remove bazaar ( - aracını pazardan kaldır - )
----------------------------------------
function remove_vehicle_bazaar(id,account_name,player)
    local status = false
    local player_vehicle = global_player_vehicle[account_name]
    for k,v in ipairs(player_vehicle) do 
        if v[1] == id then 
            v[6] = 0
            status = sell_vehicle_db(id,false)
            if status then 
                triggerClientEvent("send_player_vehicles",player,player_vehicle)
                global_player_vehicle[account_name] = player_vehicle
            end
            break
        end
    end
    return status
end

---------------------------------------------------------
-- sell to scrap vehicle ( - aracı hurdaya sat - )
---------------------------------------------------------
function sell_vehicle_scrap(id,account_name,player)
    local status = false
    local player_vehicle = global_player_vehicle[account_name]
    for k,v in ipairs(player_vehicle) do 
        if v[1] == id then 
            status = sell_to_scrap_vehicle_db(id)
            if status then 
                local new_table ={}
                for k,v in ipairs(player_vehicle) do 
                    if v[1] ~= id then 
                        table.insert(new_table,{v[1],v[2],v[3],v[4],v[5],v[6],v[7]})
                    end
                end
                triggerClientEvent("send_player_vehicles",player,new_table)
                global_player_vehicle[account_name] = new_table
                local selling_vehicle = global_player_vehicle["meta_script"]
                if not selling_vehicle then 
                    new_table = {}
                    table.insert(new_table,{id,"meta_script",false,false,false,false,false})
                    global_player_vehicle["meta_script"] = new_table
                else
                    new_table = {}
                    local status_2 = true
                    for k,v in ipairs(selling_vehicle) do 
                        if v[1] > id  and status_2 then 
                            table.insert(new_table,{id,"meta_script",false,false,false,false,false})
                            table.insert(new_table,{v[1],v[2],v[3],v[4],v[5],v[6],v[7]})
                            status_2 = false
                        else
                            table.insert(new_table,{v[1],v[2],v[3],v[4],v[5],v[6],v[7]})
                        end
                    end
                    global_player_vehicle["meta_script"] = new_table
                end
            end
            break
        end
    end
    return status
end

----------------------------------------------
-- buy vehicle from car bazaar ( -araç pazarından araç alma  - )
function add_player_vehicle_to_bazaar(buyer_account_name,id,seller_account_name)
    local status = false
    local buyer_vehicle = global_player_vehicle[buyer_account_name]
    local seller_vehicle = global_player_vehicle[seller_account_name]
    local new_table = {}
    for k,v in ipairs(seller_vehicle) do 
        if v[1] == id then 
            table.insert(buyer_vehicle,{v[1],buyer_account_name,v[3],v[4],v[5],0,false})
            global_player_vehicle[buyer_account_name] = buyer_vehicle
            local player = getAccountPlayer(getAccount(buyer_account_name))
            if player then 
                triggerClientEvent("send_player_vehicles",player,buyer_vehicle)
            end
        else 
            table.insert(new_table,{v[1],v[2],v[3],v[4],v[5],v[6],v[7]})
        end
    end
    global_player_vehicle[seller_account_name] = new_table
    local player = getAccountPlayer(getAccount(seller_account_name))
    if player then 
        triggerClientEvent("send_player_vehicles",player,new_table)
    end
    status = rename_vehicle_account(id,buyer_account_name)
    return status
end