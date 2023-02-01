global_vehicle = {}
----------------------------------
-- DEBUGS WRİTER function --SERVER
----------------------------------
function debug(msg,type,r,g,b)
    outputDebugString(getResourceName(getThisResource()).." : - "..msg,type,r,g,b)
end
db = dbConnect( "sqlite", "database/bazaar_vehicles.db")
if  db then 
    debug("bazaar_vehicles.db connected ( - bazaar_vehicles.db database bağlantısı başarılı - ).",3)
else
    debug("bazaar_vehicles.db is not connected ( - bazaar_vehicles.db database bağlantısı yok! - ).",1)
end
-------------------------------------------------
--Pull the vehicle chart (Araba tablosunu çekme)
-------------------------------------------------
function get_cars_table()
    if db then 
        local vehicle = dbPoll(dbQuery(db, "SELECT * FROM bazaar_vehicles"),-1)
        return vehicle
    else
        debug("bazaar_vehicles.db is not connected ( - bazaar_vehicles.db database bağlantısı yok! - ).",1)
    end
end


---------------------------------------------
--resource  opened and attached  db table to global table ( - script çalışınca db araç tablosunu global tabloya ekler - )
----------------------------------------------
function resource_start_db()
    local t  = get_cars_table()
    for k,v in ipairs(t) do 
        table.insert(global_vehicle,{v.id,v.model,v.player_name,v.vehicle_name,v.stats,v.price,v.account_name})
    end
end
addEventHandler("onResourceStart",resourceRoot,resource_start_db)

-------------------------------------------
-- car remove's database (- arabayı veritabanından sil - )
-------------------------------------------
function remove_vehicle_db(id)
    local status = dbExec(db, "DELETE FROM bazaar_vehicles WHERE id = ?",id)
    return status
end
-------------------------------------------
-- add car to database ( - veritabanına araba ekle - )
-------------------------------------------
function add_vehicle_db(id,model,player_name,veh_name,stats,price,account_name)
    local status = dbExec(db,"INSERT INTO bazaar_vehicles (id,model,player_name,vehicle_name,stats,price,account_name) VALUES(?,?,?,?,?,?,?)",id,model,player_name,veh_name,stats,price,account_name)
    return status
end


