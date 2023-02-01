global_player_vehicle = {}
----------------------------------
-- DEBUGS WRİTER function --SERVER
----------------------------------
function debug(msg,type,r,g,b)
    outputDebugString(getResourceName(getThisResource()).." : - "..msg,type,r,g,b)
end
db = dbConnect( "sqlite", "database/player_vehicles.db")
if  db then 
    debug("player_vehicles.db connected ( - player_vehicles.db database bağlantısı başarılı - ).",3)
else
    debug("player_vehicles.db is not connected ( - player_vehicles.db database bağlantısı yok! - ).",1)
end
-------------------------------------------------
--Pull the vehicle chart (Araba tablosunu çekme)
-------------------------------------------------
function get_cars_table()
    if db then 
        local vehicle = dbPoll(dbQuery(db, "SELECT * FROM player_vehicles"),-1)
        return vehicle
    else
        debug("player_vehicles.db is not connected ( - player_vehicles.db database bağlantısı yok! - ).",1)
    end
end
---------------------------------------------
--resource  opened and attached  db table to global table ( - script çalışınca db araç tablosunu global tabloya ekler - )
----------------------------------------------
function resource_start_db()
    local list = get_cars_table()
    for k,v in ipairs(list) do
        local p_table = {}
        for g,s in ipairs(list) do 
            if v.account_name == s.account_name then 
                table.insert(p_table,{s.id,s.account_name,s.model,s.vehicle_name,s.stats,s.sell_status,false})
            end
       end
       global_player_vehicle[v.account_name] = p_table
    end
end
addEventHandler("onResourceStart",resourceRoot,resource_start_db)
-------------------------------------------
-- add car to database ( - veritabanına araba ekle - )
-------------------------------------------
function add_vehicle_db(account_name,model,vehicle_name,stats)
    local status = dbExec(db,"INSERT INTO player_vehicles (account_name,model,vehicle_name,stats,sell_status) VALUES(?,?,?,?,?)",account_name,model,vehicle_name,stats,false)
    return status
end
-----------------------------------------
--  ( - silinen aracın yerine yeni araç koyma - )
----------------------------------------------
function free_row_add_vehicle_db(id,account_name,model,vehicle_name,stats,sell_status)
    local status = dbExec(db,"UPDATE player_vehicles SET account_name = ?, model= ?, vehicle_name = ?, stats = ?, sell_status = ? WHERE id = ?",account_name,model,vehicle_name,stats,sell_status,id)
    return status
end
-------------------------------------------------------------------------------
--save stats on db ( - db'ye statları kayıt etme - )
-------------------------------------------------------------------------
function save_vehicle_stats_db(id,stats)
    local status = dbExec(db,"UPDATE player_vehicles SET stats = ? WHERE id = ?",stats,id)
    return status
end

----------------------------------------------------
-- vehicle name change ( - araç ismi değiştirme - )
-----------------------------------------------------
function  change_veh_name_db(model,name)
    local status = dbExec(db,"UPDATE player_vehicles SET vehicle_name = ? WHERE  model= ?",name,model)
    return status
end


----------------------------------------------------------
--vehicle selling ( - araç satma - )
-----------------------------------------------------------
function sell_vehicle_db(id,status)
    local status = dbExec(db,"UPDATE player_vehicles SET sell_status = ? WHERE id = ?",status,id)
    return status
end

----------------------------------------------------------
--sell to scrap vehicle db ( - aracı hurdaya sat db - )
-----------------------------------------------------------
function sell_to_scrap_vehicle_db(id)
    local status = dbExec(db,"UPDATE player_vehicles SET account_name = ? WHERE id = ?","meta_script",id)
    return status
end

--------------------------------------------------------
-- buy vehicle from car bazaar db ( - araç pazarından araç alma - )
-----------------------------------------
function rename_vehicle_account(id,account_name)
    local status = dbExec(db,"UPDATE player_vehicles SET account_name = ?, sell_status = ? WHERE id = ?",account_name,false,id)
    return status
end