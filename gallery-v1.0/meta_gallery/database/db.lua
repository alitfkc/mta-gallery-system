global_vehicle = {}
----------------------------------
-- DEBUGS WRİTER function --SERVER
----------------------------------
function debug(msg,type,r,g,b)
    outputDebugString(getResourceName(getThisResource()).." : - "..msg,type,r,g,b)
end
db = dbConnect( "sqlite", "database/vehicles.db")
if  db then 
    debug("vehicle.db connected ( - vehicle.db database bağlantısı başarılı - ).",3)
else
    debug("vehicle.db is not connected ( - vehicles.db database bağlantısı yok! - ).",1)
end
-------------------------------------------------
--Pull the vehicle chart (Araba tablosunu çekme)
-------------------------------------------------
function get_cars_table()
    if db then 
        local vehicle = dbPoll(dbQuery(db, "SELECT * FROM vehicles"),-1)
        return vehicle
    else
        debug("vehicles.db is not connected ( - vehicle.db database bağlantısı yok! - ).",1)
    end
end


---------------------------------------------
--resource  opened and attached  db table to global table ( - script çalışınca db araç tablosunu global tabloya ekler - )
----------------------------------------------
function resource_start_db()
    global_vehicle = get_cars_table()
end
addEventHandler("onResourceStart",resourceRoot,resource_start_db)

-------------------------------------------
-- car remove's database (- arabayı veritabanından sil - )
-------------------------------------------
function vehicle_remove_db(id,brand,model,model_year,price,stock)
    local status = dbExec(db, "DELETE FROM vehicles WHERE id = ? AND brand = ? AND model = ? AND model_year = ? AND price = ? AND stock = ? ",id,brand,model,model_year,price,stock)
    return status
end
-------------------------------------------
-- add car to database ( - veritabanına araba ekle - )
-------------------------------------------
function add_vehicle_db(id,brand,model,model_year,price,stock)
    local status = dbExec(db,"INSERT INTO vehicles (id,brand,model,model_year,price,stock) VALUES(?,?,?,?,?,?)",id,brand,model,model_year,price,stock)
    return status
end
-------------------------------------------
-- Buying car  ( - araç satın alma -)
-------------------------------------------
function buying_vehicle_db(id,brand,model,model_year,price,stock)
    local status dbExec(db,"UPDATE vehicles SET stock = ? WHERE id = ? AND brand = ? AND model = ? AND model_year = ? AND price = ?",stock,id,brand,model,model_year,price)
    return status
end
------------------------------------
--Change id ( - id değiştirme -) 
-------------------------------------
function change_vehicle_id_db(id,brand,model,model_year,price,stock) 
    local status = dbExec(db,"UPDATE vehicles SET id = ? WHERE brand = ? AND model = ? AND model_year = ? AND price = ? AND stock = ?",id,brand,model,model_year,price,stock)
    return status
end

------------------------------------
--Change brand ( - brand değiştirme -) 
-------------------------------------
function change_vehicle_brand_db(id,brand,model,model_year,price,stock) 
    local status = dbExec(db,"UPDATE vehicles SET brand = ? WHERE id = ? AND model = ? AND model_year = ? AND price = ? AND stock = ?",brand,id,model,model_year,price,stock)
    return status
end

------------------------------------
--Change model ( - model değiştirme -) 
-------------------------------------
function change_vehicle_model_db(id,brand,model,model_year,price,stock) 
    local status = dbExec(db,"UPDATE vehicles SET model = ? WHERE id = ? AND brand = ? AND model_year = ? AND price = ? AND stock = ?",model,id,brand,model_year,price,stock)
    return status
end

------------------------------------
--Change model_year ( - model yılı  değiştirme -) 
-------------------------------------
function change_vehicle_model_year_db(id,brand,model,model_year,price,stock) 
    local status = dbExec(db,"UPDATE vehicles SET model_year = ? WHERE id = ? AND brand = ? AND model = ? AND price = ? AND stock = ?",model_year,id,brand,model,price,stock)
    return status
end

------------------------------------
--Change price ( - fiyat  değiştirme -) 
-------------------------------------
function change_vehicle_price_db(id,brand,model,model_year,price,stock) 
    local status = dbExec(db,"UPDATE vehicles SET price = ? WHERE id = ? AND brand = ? AND model = ? AND model_year= ? AND stock = ?",price,id,brand,model,model_year,stock)
    return status
end

------------------------------------
--Change stock ( - stok  değiştirme -) 
-------------------------------------
function change_vehicle_stock_db(id,brand,model,model_year,price,stock) 
    local status = dbExec(db,"UPDATE vehicles SET stock = ? WHERE id = ? AND brand = ? AND model = ? AND model_year= ? AND price = ?",stock,id,brand,model,model_year,price)
    return status
end

