_outputChatBox = outputChatBox
function outputChatBox(text,player,r,g,b)
    if not notification then 
        _outputChatBox(text,player,r,g,b)
    else
        notification:event(text,player,r,g,b)
    end
end

-----------------------------------------
--ESKİ İSTANBUL F4'DEN DOSYALARI EKLEMEK İÇİN
------------------------------------------
--[[
db2 = dbConnect( "sqlite", "settings/f4db.db")
if  db2 then 
    print("eskif4 db bağlantısı başarılı.",3)
else
    print("eskif4 db bağlantısı başarısız.",1)
end

setTimer(function()
    local result = dbPoll(dbQuery(db2, "SELECT * FROM VehicleList"),-1)
    if type(result) == "table" then
        for sira,veri in ipairs(result) do 
            local id = veri.Model
            for k,v in ipairs(global_vehicle) do 
                if v.id == id  then 
                    exports["meta_vehicleget"]:add_player_vehicle(veri.Account,id,v.brand,v.model,v.model_year,v.price)
                    print(id,veri.Account,v.brand,v.model,v.model_year)
                end
            end
        end
    end
end,1000,1)
]]--

