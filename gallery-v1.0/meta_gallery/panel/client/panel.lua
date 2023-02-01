loadstring(exports.dgs:dgsImportFunction())()
dgs = {}
local function resource_start()
    ------------------------------------------------
    -- Main Car Shop Window
    ------------------------------------------------ Window
    local gradient_title = dgsCreateGradient(tocolor(255,166,38),tocolor(255,59,84),10)
    dgsGradientSetColorOverwritten(gradient_title,false)
    local title_rect = dgsCreateRoundRect({
                                        {15,false},
                                        {15,false},
                                        {-5,false},
                                        {-5,false},
                                    })
                                    
    local canvas_title = dgsCreateCanvas(gradient_title,100,50)
    dgsRoundRectSetTexture(title_rect, canvas_title)

    
    vehicle_shop_panel = dgsCreateWindow(0.01,0.2,0.3,0.6,panel_name,true,tocolor(255,255,255),45,title_rect,false,false,tocolor(12,12,12,200),false,true)
    dgsWindowSetSizable(vehicle_shop_panel,false)
    dgsWindowSetMovable(vehicle_shop_panel,false)
    dgsSetProperty(vehicle_shop_panel, "functions",[[
        dgsCanvasRender(dgsElementData[self].renderCanvas)
    ]])
    dgsSetProperty(vehicle_shop_panel, "renderCanvas", canvas_title)
    dgsSetFont(vehicle_shop_panel, "default-bold")

                                    
    local bottom_img_rect = dgsCreateRoundRect({ --window bottom img
                                                {0,false},
                                                {0,false},
                                                {15,false},
                                                {15,false},
                                                })
    dgsRoundRectSetTexture(bottom_img_rect, canvas_title)
                                            

    local bottom_img = dgsCreateImage(-0.001,0.9,1.004,0.07,bottom_img_rect,true,vehicle_shop_panel,tocolor(255,166,38))
    dgsSetProperty(bottom_img, "functions",[[
        dgsCanvasRender(dgsElementData[self].renderCanvas)
    ]])
    dgsSetProperty(bottom_img, "renderCanvas", canvas_title)
    dgsImageSetImage(bottom_img,bottom_img_rect)
    
        
    ------------------------------------------
    -- Try the car button
    ---------------------------------------------
    dgs.exit_btn = createButton(0.009,0.83,0.09,0.04,language[language_section][13],true)
    ----------------------------------------
    ------------------------------------------
    -- Try the car button
    ---------------------------------------------
    dgs.try_btn = createButton(0.115,0.83,0.09,0.04,language[language_section][2],true)
    ----------------------------------------
    -- Purchase the car button
    ---------------------------------------
    dgs.buy_btn = createButton(0.22,0.83,0.09,0.04,language[language_section][3],true)
    
    -----------------------------------------
    --Search the car edit
    --------------------------------------------
    local edit_round = dgsCreateRoundRect(12,false,tocolor(12,12,12,200))
    dgs.search_edit = dgsCreateEdit(0.168,0.165,0.14,0.03,language[language_section][4][1],true,false,tocolor(255,255,255),false,false,edit_round)
    dgsEditSetHorizontalAlign(dgs.search_edit,"center")
    dgsEditSetCaretStyle(dgs.search_edit,1)
    dgsSetProperty(dgs.search_edit,"caretColor",tocolor(1,1,1,255))


    --------------------------------------------------
    --Cars List
    --------------------------------------------------
    cars_list = dgsCreateGridList(0,0,1,0.9,true,vehicle_shop_panel,20,tocolor(0,0,0,0),false,tocolor(0,0,0,0),tocolor(0,0,0,0),tocolor(255,166,38,120),tocolor(255,59,84,120))
    column_1 =dgsGridListAddColumn( cars_list,language[language_section][5] , 0.2)
    column_2 =dgsGridListAddColumn( cars_list,language[language_section][6] , 0.2 )
    column_3 =dgsGridListAddColumn( cars_list,language[language_section][7] , 0.15 )
    column_4 =dgsGridListAddColumn( cars_list,language[language_section][8] , 0.18 )
    column_5 =dgsGridListAddColumn( cars_list,language[language_section][9] , 0.2 )

    dgsSetProperty(cars_list,"rowHeight",50)       
    dgsSetProperty(cars_list,"scrollBarThick",0) 


    ---------------------------------
    -- cars stat img
    ---------------------------------
    dgs.cars_stat_main = dgsCreateImage(1,0.74,0.25,0.25,edit_round,true)
    cars_stat_car_logo = dgsCreateImage(0.02,0.3,0.3,0.4,false,true,dgs.cars_stat_main)
    local cars_stat_bar_background_round = dgsCreateRoundRect(8,false,tocolor(255,255,255))
    local cars_stat_bar_round = dgsCreateRoundRect(8,false,tocolor(12,12,12))

    local cars_bar_1_label = dgsCreateLabel(0.35,0.07,0.6,0.1,language[language_section][10],true,dgs.cars_stat_main,false,1.8,1.8)
    dgsSetFont(cars_bar_1_label,"default-bold")
    dgsLabelSetHorizontalAlign(cars_bar_1_label,"center")
    local cars_bar_background_1 = dgsCreateImage(0.35,0.17,0.6,0.05,cars_stat_bar_background_round,true,dgs.cars_stat_main)
    cars_stat_bar_speed = dgsCreateImage(-0.01,-0.01,0.8,1.2,cars_stat_bar_round,true,cars_bar_background_1)

    local cars_bar_2_label = dgsCreateLabel(0.35,0.37,0.6,0.1,language[language_section][11],true,dgs.cars_stat_main,false,1.8,1.8)
    dgsSetFont(cars_bar_2_label,"default-bold")
    dgsLabelSetHorizontalAlign(cars_bar_2_label,"center")
    local cars_bar_background_2 = dgsCreateImage(0.35,0.47,0.6,0.05,cars_stat_bar_background_round,true,dgs.cars_stat_main)
    cars_stat_bar_accelertion = dgsCreateImage(-0.01,-0.01,0.6,1.2,cars_stat_bar_round,true,cars_bar_background_2)

    local cars_bar_3_label = dgsCreateLabel(0.35,0.67,0.6,0.1,language[language_section][12],true,dgs.cars_stat_main,false,1.8,1.8)
    dgsSetFont(cars_bar_3_label,"default-bold")
    dgsLabelSetHorizontalAlign(cars_bar_3_label,"center")   
    local cars_bar_background_3 = dgsCreateImage(0.35,0.77,0.6,0.05,cars_stat_bar_background_round,true,dgs.cars_stat_main)
    cars_stat_bar_brake = dgsCreateImage(-0.01,-0.01,0.3,1.2,cars_stat_bar_round,true,cars_bar_background_3)
    
    
    -----------------------------------------
    -- Cinematic Mode Button 
    -----------------------------------------
    local cinematic_btn_dx = dxCreateTexture("panel/panel_img/cinematic_icon.png")
    dgs.cinematic_btn = dgsCreateButton(0.965,0.84,0.03,0.05,"",true,false,false,false,false,cinematic_btn_dx,cinematic_btn_dx,cinematic_btn_dx,tocolor(12,12,12,220),tocolor(12,12,12,180),tocolor(12,12,12,220))


    -----------------------------------------
    -- car select music on - off
    -----------------------------------------
    sound_on_btn_dx = dxCreateTexture("panel/panel_img/sound_on.png")
    sound_off_btn_dx = dxCreateTexture("panel/panel_img/sound_off.png")
    dgs.sound_btn = dgsCreateButton(0.965,0.94,0.03,0.05,"",true,false,false,false,false,sound_on_btn_dx,sound_off_btn_dx,sound_off_btn_dx,tocolor(72,72,72),tocolor(12,12,12,200),tocolor(12,12,12))


    dgsSetVisible(vehicle_shop_panel,false)
    for k,v in pairs(dgs) do 
        dgsSetVisible(v,false)
    end
end

function createButton(x, y, g, u, text, relative, parent)
    local button_round = dgsCreateRoundRect(15,false,tocolor(255,255,255,255))
    local gradient = dgsCreateGradient(tocolor(255,166,38),tocolor(255,59,84),10)
    dgsGradientSetColorOverwritten(gradient,false)

    local canvas = dgsCreateCanvas(gradient,100,50)
    dgsRoundRectSetTexture(button_round, canvas)
    
    local button_1 = dgsCreateButton(x, y, g, u,text, relative, parent)
    dgsSetProperty(button_1, "image",{button_round,button_round,button_round})
    dgsSetProperty(button_1, "functions",[[
        dgsCanvasRender(dgsElementData[self].renderCanvas)
    ]])
    dgsSetProperty(button_1, "renderCanvas", canvas)
    dgsSetFont(button_1, "default-bold")
    dgsSetProperty(button_1, "clickType", 1)

    return button_1
end

addEventHandler("onClientResourceStart",resourceRoot,resource_start)