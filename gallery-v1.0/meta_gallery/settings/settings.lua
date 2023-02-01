language = {
    {"EN",
        {"Test Drive"},
        {"Purchase"},
        {"Search..."}, 
        {"Brand"},
        {"Model"},
        {"Model Year"},
        {"Price"},
        {"Stock"},
        {"Top Speed"},
        {"Accelertion"},
        {"Brake"},
        {"Close"},
        {"Car Database's Edit"},
        {"Add/Remove"},
        {"Change Brand"},
        {"Change Model"},
        {"Change Model-Y"},
        {"Change Price"},
        {"Change Stock"},
        {"Car removed succesfuly",0,255,0},
        {"Car not Removed",255,0,0},
        {"Car added succesfuly",0,255,0},
        {"Car not added",255,0,0},
        {"Change ID"},
        {"ID Changed succesfuly",0,255,0},
        {"ID not changed!",255,0,0},
        {"Brand Changed succesfuly",0,255,0},
        {"Brand not changed!",255,0,0},
        {"Model Changed succesfuly",0,255,0},
        {"Model not changed!",255,0,0},
        {"Model Year Changed succesfuly",0,255,0},
        {"Model Year not changed!",255,0,0},
        {"Price Changed succesfuly",0,255,0},
        {"Price not changed!",255,0,0},
        {"Stock Changed succesfuly",0,255,0},
        {"Stock not changed!",255,0,0},
        {"Type /finishdrive to exit test drive.",0,120,120},
        {"This vehicle's doesn't have a stock!",255,0,0},
        {"Insufficient balance!",255,0,0},--40
        {"Garage is full!",255,0,0},
    },
    {"TR",
        {"Test Sürüşü"},
        {"Satın Al"},
        { "Ara..."},
        {"Marka"},
        {"Model"},
        {"Model Yılı"},
        {"Fiyat"},
        {"Stok"},
        {"Maksimum Hız"},
        {"Hızlanma"},
        {"Fren"},
        {"Kapat"},
        {"Araba Veritabanının Düzenleme"},
        {"Ekle/Sil"},
        {"Marka Değiş"},
        {"Model Değiş"},
        {"Model-Y Değiş"},
        {"Fiyat Değiş"},
        {"Stok Değiş"},
        {"Araba başarıyla kaldırıldı.",0,255,0},
        {"Araba kaldırılamadı!",255,0,0},
        {"Araba Başarıyla Eklendi",0,255,0},
        {"Araba eklenemedi!",255,0,0},
        {"ID Değiştir"},
        {"ID başarıyla değiştirildi.",0,255,0},
        {"ID değiştirilemedi!",255,0,0},
        {"Marka başarıyla değiştirildi.",0,255,0},
        {"Marka değiştirilemedi!",255,0,0},
        {"Model başarıyla değiştirildi.",0,255,0},
        {"Model değiştirilemedi!",255,0,0},
        {"Model yılı başarıyla değiştirildi.",0,255,0},
        {"Model yılı değiştirilemedi!",255,0,0},
        {"Fiyat başarıyla değiştirildi.",0,255,0},
        {"Fiyat değiştirilemedi!",255,0,0},
        {"Stok başarıyla değiştirildi.",0,255,0},
        {"Stok değiştirilemedi!",255,0,0},
        {"Test sürüşünden çıkmak için /finishtest  yazın.",0,120,120},
        {"Bu aracın stoğu yok!",255,0,0},
        {"Yetersiz bakiye!",255,0,0},
        {"Garajda yer yok!",255,0,0}
    },
}
language_section =  2 -- language selection ( - dil seçimi - )

personnel_panel_aclgroup = "Admin" -- Personnel panel acl group ( - personel paneli açma yetkisi - )
personnel_panel_command = "metacars" --Personnel panel opening command ( - personel  paneli açma komutu - )


------------------------------------------
-- cars stat ( - araba değerleri -)
-------------------------------------------
cars_stats = {
    --{vehicle id(araçid),top speed (0-1)(maksimum hız (0-1)),accelertion (0-1)(Hızlanma (0-1)),brake (0-1)(fren (0-1)),vehicle icon filepath(araç simgesi dosya konumu)},
    --{421,0.6,0.8,0.5,"settings/cars_logo/nissan.png"},
    {421,0.6,0.8,0.5,"settings/cars_logo/nissan.png"},
    {411,0.4,0.2,0.6,"settings/cars_logo/nissan.png"},
}

----------------------------------------------------
--gallerys ( - galeriler - )
----------------------------------------------------
gallerys = {
    --{{marker_x,marker_y,marker_z,marker_scale,marker_type,r,g,b,a},{vehicle_spawn_x,vehicle_spawn_y,vehicle_spawn_z,vehicle_spawn_rx},{cars}}
    --{{-1954, 301, 34.5,1,"cylinder",r,g,b,a},{-1975.54626, 303.13275, 35.17188,180},{411,421,520,430,411,450,554,452,521,420},{playerspawnx,y,z}},
    {{-1954, 301, 34.5,1,"cylinder",255,0,0,255},{-1975.5, 303.1, 35.2,180},{411,461,422,542,529},{-1970.25317, 293.90372, 35.17188}}
}

sign_object_id = 2725
maps_object={
    --    {object_id(if false, closed object),x,y,z,rx,ry,rz,interior,dimens,scale,alpha} 
        {5340,1365.31189, -1.94914, 1005.52188,0,0,320,1,0,5,255},--dont touch ("dokunma")
        {5340,1360.80396, -43.10708, 1005.52188,0,0,70,1,0,5,255},--dont touch ("dokunma")
        {5340,1358.05408, -25.07331, 1005.52188,0,0,0,1,0,5,255},--dont touch ("dokunma")
        {6959,1358.05408, -25.07331, 1000.34,0,0,0,1,0,1,0},--dont touch ("dokunma")
        {1827,1366.02991, -25.50282, 998.20063,0,0,0,1,0,5,255},--dont touch ("dokunma")
        {sign_object_id,1368.32991, -25.50282, 1000.12,0,270,0,1,0,6,255},--dont touch ("dokunma")
        {sign_object_id,1358.55408, -25.57331, 1003.42188,0,0,0,1,0,10,255},--dont touch ("dokunma")



        {sign_object_id,-1973.96960, 309.81, 35.17188,0,0,90,0,0,3,255},
        {sign_object_id,-1950, 299.92783, 35.86875,0,0,0,0,0,2,255},
        {2008,-1952.78943, 301.75375, 34.46875,0,0,120,0,0,1.2,255},
}
peds={ 
    --{skin_id,x,y,z,rz,dimension,interior,"block",anim}
    --{163,-1951.94556, 302.54166, 35.46875,150,0,0,"DEALER", "DEALER_IDLE"},
    {219,-1952.05725, 302.56580, 35.46875,120,0,0,"FOOD", "SHP_Tray_Lift_Loop"},
} 


----------------------------------------------------------------------------------------
--test drive time, write time of type only millisecond ( - test sürüşü süresi , milisaniye cinsinden yazınız - )
----------------------------------------------------------------------------------------
test_drive_time = 10000
test_quit_command = "finishdrive"


--------------------------------------------------------
-- music url ( - müzik url -)
-------------------------------------------------------
music_url = {
    {"https://cdn.discordapp.com/attachments/673076413741400086/1038505275268792382/SpiderBait_Black_Betty.mp3"},
    {"https://cdn.discordapp.com/attachments/673076413741400086/1038505275570794579/Terror_Squad_ft_Fat_Joe_Lean_Back.mp3"},
    {"https://cdn.discordapp.com/attachments/673076413741400086/1038505275856003143/The_Bronx_Notice_Of_Eviction.mp3"},
    {"https://cdn.discordapp.com/attachments/673076413741400086/1038505276116041828/Unwritten_Law_The_Celebration_Song.mp3"},
    {"https://cdn.discordapp.com/attachments/673076413741400086/1038505276397072494/scavenger_dave_dob.mp3"},
    {"https://cdn.discordapp.com/attachments/673076413741400086/1038505276741001266/Skindred_Nobody.mp3"},
    {"https://cdn.discordapp.com/attachments/673076413741400086/1038505277030400080/Sly_Boogy_Thatz_My_Name.mp3"},
    {"https://cdn.discordapp.com/attachments/673076413741400086/1038505277437259826/Killing_Joke_The_Death_And_Rescurrection_Show.mp3"},
    {"https://cdn.discordapp.com/attachments/673076413741400086/1038505277739237436/Lil_Jon_The_East_Side_Boyz_Get_Low.mp3"},
    {"https://cdn.discordapp.com/attachments/673076413741400086/1038505278028664993/riders_on_the_storm.mp3"},
    {"https://cdn.discordapp.com/attachments/673076413741400086/1038505278351618088/Capone.mp3"},
    {"https://cdn.discordapp.com/attachments/673076413741400086/1038505278636818503/Chingy_I_Do.mp3"},   
}
volume = 1-- 0 - 1 set music volume


--------------------------------------------
--export notification ( - export bildirim - )
--------------------------------------------
notification = false --Type the export name for the notification. Example exports["meta-declaration] if you don't want it type false
--bildirim için export ismi yazın. Örnek exports["meta-bildirim] eğer istemiyorsanız false yazın
panel_name = "Meta Gallery"
