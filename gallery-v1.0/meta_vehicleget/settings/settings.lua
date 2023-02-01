language = {
    {"EN",
        {"Close"},
        {"Spectate"},
        {"Bring/Take"},
        {"Vehicle Name"},
        {"Price"},
        {"KM"},
        {"DR"},
        {"Search..."},
        {"Your vehicle creation limit has been reached!",255,0,0}, 
        {"İnsufficient balance for vale!",255,0,0},
        {"Close Spectate"},
        {"Vehicle name changed succesfuly",0,255,0},
        {"Owner"},
        {"Lock/Unlock"},
        {"Engine on/off"},
        {"Trade"},
        {"Players"},
        {"Select Player"},
        {"Show İtems"},
        {"Approval Trade"},
        {"Add Vehicle"},
        {"Add Money"},
        {"Lock"},
        {"Approval"},
        {"Money"},
        {"Hex Code Name"},
        {"Request sent successfully"},
        {"was send  you request"},
        {"Player not in range!"},
        {"The player you sent a trade request sent someone else a trade request."},
        {"ONLY","NUMBER"},
        {"İnvalid","ID"},
        {"Insufficient balance"},
        {"You"},
        {"Trade Not Locked"},
        {"Trade Lock"},
        {"Trade not Confirmed"},
        {"Trade Confirmed"},
        {"named player insufficient garage!"},
        {"Trade Successfuly Finish"},


    },
    {"TR",
        {"Kapat"},
        {"İzle"},
        {"Getir/Kaldır"},
        {"Araç İsmi"},
        {"Fiyat"},
        {"KM"},
        {"HK"},
        {"Ara..."},
        {"Araç oluşturma limitin doldu!",255,0,0},
        {"Vale için yetersiz bakiye!",255,0,0},
        {"İzlemeyi Kapat"},
        {"Araç ismi başarıyla değiştirildi",0,255,0},
        {"Sahip"},
        {"Kitle/Aç"},
        {"Motor Aç/Kapa"},
        {"Takas"},
        {"Oyuncular"},
        {"Oyuncuyu Seç"},
        {"Eşyaları göster"},
        {"Takası Onayla"},
        {"Araç Ekle"},
        {"Para Ekle"},
        {"Takası Kilitle"},
        {"Onayla"},
        {"Para"},
        {"Hex Kodlu İsmi"},
        {"İstek Başarıyla Gönderildi."},
        {" Size takas isteği gönderdi."},
        {"Oyuncu menzilde değil!"},
        {"Takas isteği attığınız oyuncu başka birine takas isteği atmış"},
        {"SADECE SAYI"},
        {"Geçersiz ID"},
        {"Yetersiz Bakiye"},
        {"Sen"},
        {"Takası Kilitlemedi"},
        {"Takas Kilitlendi"},
        {"Takas Onaylanmadı"},
        {"Takas Onaylandı"},
        {"Adlı oyuncunun garajında yer yok!"},
        {"Takas başarılı"},
        
    },
}
language_section =  2 -- language selection ( - dil seçimi - )


created_vehicle_limit = 4

vehicle_delivery_fee = 100

---------------------------------------
--set open panel key
---------------------------------------
panel_key = "f4"


---------------------------------------
-- vehicle buying limit
---------------------------------------
buying_limit = 16
buying_limit_increase_acl = {
    --{"Admin",1}
    {"Admin",1},
}

----------------------------------------
--vehicle name changer acl ( - araç ismi değiştirme yetkisi - )
-----------------------------------------
name_changer_acl = "Admin"
name_changer_command = "chgvehname"

--------------------------------------------
--export notification ( - export bildirim - )
--------------------------------------------
notification = false --Type the export name for the notification. Example exports["meta-declaration] if you don't want it type false
--bildirim için export ismi yazın. Örnek exports["meta-bildirim] eğer istemiyorsanız false yazın

------------------------------------------
-- vehicle top info key ( - araç üst bilgi tuşu - )
--------------------------------------------
info_key = "lalt"

panel_name = "Meta Vehicle Get"


money_type = "$"



-----------------------------------
-- Trande range ( Takas menzili )
-----------------------------------
trade_range = 30
