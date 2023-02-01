language = {
    {"EN",
        {"Test Drive"},
        {"Purchase"},
        {"Search..."}, 
        {"Vehicle Name"},
        {"Owner"},
        {"Price"},
        {"KM"},
        {"ID"},
        {"Top Speed"},
        {"Accelertion"},
        {"Brake"},
        {"Close"},
        {"Type /finishdrive to exit test drive.",0,120,120},
        {"Insufficient balance!",255,0,0},
        {"Garage is full!",255,0,0},
        {"Add Your Vehicle"},
        {"Remove Your Vehicle"},
        {"Sell to Scrap"},
        {"Approval"},
        {"ONLY","NUMBER"},
        {"İnvalid","ID"},
        {"Insufficient vehicle add fee!",255,0,0},
        {"DR"},--24
    },
    {"TR",
        {"Test Sürüşü"},
        {"Satın Al"},
        { "Ara..."},
        {"Araç ismi"},
        {"Sahibi"},
        {"Fiyat"},
        {"KM"},
        {"ID"},
        {"Maksimum Hız"},
        {"Hızlanma"},
        {"Fren"},
        {"Kapat"},
        {"Test sürüşünden çıkmak için /finishtest  yazın.",0,120,120},--13
        {"Yetersiz bakiye!",255,0,0},
        {"Garajda yer yok!",255,0,0},
        {"Aracını Ekle"},
        {"Aracını kaldır"},
        {"Hurdaya Sat"},
        {"Onayla"},
        {"SADECE","SAYI"},
        {"Geçersiz","ID"},
        {"Yetersiz araç ekleme ücreti",255,0,0},
        {"HK"},
    },
}
language_section =  2 -- language selection ( - dil seçimi - )


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
    --{{-1954, 301, 34.5,1,"cylinder",r,g,b,a},{-1975.54626, 303.13275, 35.17188,180},{411,421,520,430,411,450,554,452,521,420}},
    {{-2031.69, 146.89, 28.4,1,"cylinder",255,0,0,255},{-2031.48621, 135.27205, 28.83594,270},{411,461,422,542,529}}
}

sign_object_id = 2725
maps_object = {
    --    {object_id(if false, closed object),x,y,z,rx,ry,rz,interior,dimens,scale,alpha} 

        {sign_object_id,-2020.93760, 125.05751, 28.8123,0,0,0,0,0,3,255},
        {2008,-2032.76294, 148.37306, 27.83594,0,0,240,0,0,1.2,255},
}
peds={ 
    --{skin_id,x,y,z,rz,dimension,interior,"block",anim}
    --{163,-1951.94556, 302.54166, 35.46875,150,0,0,"DEALER", "DEALER_IDLE"},
    {219,-2034.01843, 148.62004, 28.83594,240,0,0,"FOOD", "SHP_Tray_Lift_Loop"},
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


---------------------------------
-- add-on fee 
----------------------------------
add_on_fee=100

-----------------------------------
-- vehicle scrap sales percentage ( - araç hurdaya satış yüzdeliği - )
---------------------------------------
vehicle_scrap_selling_percentage = 50 --%

--------------------------------------------
--export notification ( - export bildirim - )
--------------------------------------------
notification = false --Type the export name for the notification. Example exports["meta-declaration] if you don't want it type false
--bildirim için export ismi yazın. Örnek exports["meta-bildirim] eğer istemiyorsanız false yazın

panel_name = "Meta Car Bazaar"
