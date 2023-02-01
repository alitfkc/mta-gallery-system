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

    
    vehicle_get_panel = dgsCreateWindow(0.01,0.16,0.2,0.5,panel_name,true,tocolor(255,255,255),40,title_rect,false,false,tocolor(12,12,12,200),false,true)
    dgsWindowSetSizable(vehicle_get_panel,false)
    dgsWindowSetMovable(vehicle_get_panel,false)
    dgsSetProperty(vehicle_get_panel, "functions",[[
        dgsCanvasRender(dgsElementData[self].renderCanvas)
    ]])
    dgsSetProperty(vehicle_get_panel, "renderCanvas", canvas_title)
    dgsSetFont(vehicle_get_panel, "default-bold")

                                    
    local bottom_img_rect = dgsCreateRoundRect({ --window bottom img
                                                {0,false},
                                                {0,false},
                                                {15,false},
                                                {15,false},
                                                })
    dgsRoundRectSetTexture(bottom_img_rect, canvas_title)
                                            

    bottom_img = dgsCreateImage(-0.001,0.9,1.006,0.07,bottom_img_rect,true,vehicle_get_panel,tocolor(255,166,38))
    dgsSetProperty(bottom_img, "functions",[[
        dgsCanvasRender(dgsElementData[self].renderCanvas)
    ]])
    dgsSetProperty(bottom_img, "renderCanvas", canvas_title)
    dgsImageSetImage(bottom_img,bottom_img_rect)
    
    --------------------------------------------------------------
    -- close panel ( - panel kapatma - )
    ---------------------------------------------------------------------
    dgs.close_btn = createButton(0.009,0.69,0.06,0.03,language[language_section][2][1],true)

    -------------------------------------------
    -- speacte vehicle ( - araç izle - )
    -------------------------------------------------
    dgs.spectate_btn = createButton(0.08,0.69,0.06,0.03,language[language_section][3][1],true)

    -------------------------------------------
    -- bring or take vehicle ( - araç getir götür - )
    -------------------------------------------------
    dgs.get_btn= createButton(0.15,0.69,0.06,0.03,language[language_section][4][1].." "..vehicle_delivery_fee.."$",true)
 

    ---------------------------------------------
    -- Vehicle lock 
    ---------------------------------------------
    dgs.lock_btn = createButton(0.009,0.72,0.06,0.03,language[language_section][15][1],true)

    -------------------------------------------
    -- engine on/off 
    -------------------------------------------------
    dgs.engine_btn = createButton(0.08,0.72,0.06,0.03,language[language_section][16][1],true)


    -------------------------------------------
    -- trade vehicle 
    -------------------------------------------------
    dgs.trade_btn= createButton(0.15,0.72,0.06,0.03,language[language_section][17][1],true)
 


    -----------------------------------------
    --Search the car edit
    --------------------------------------------
    local edit_round = dgsCreateRoundRect(12,false,tocolor(12,12,12,200))
    dgs.search_edit = dgsCreateEdit(0.13,0.125,0.08,0.03,language[language_section][9][1],true,false,tocolor(255,255,255),false,false,edit_round)
    dgsEditSetHorizontalAlign(dgs.search_edit,"center")
    dgsEditSetCaretStyle(dgs.search_edit,1)
    dgsSetProperty(dgs.search_edit,"caretColor",tocolor(1,1,1,255))

    --------------------------------------------------
    --vehicle List
    --------------------------------------------------
    vehicle_list = dgsCreateGridList(0,0,1,0.9,true,vehicle_get_panel,20,tocolor(0,0,0,0),false,tocolor(0,0,0,0),tocolor(0,0,0,0),tocolor(255,166,38,120),tocolor(255,59,84,120))
    column_1 =dgsGridListAddColumn( vehicle_list,language[language_section][5] , 0.45)
    column_2 =dgsGridListAddColumn( vehicle_list,language[language_section][6] , 0.12 )
    column_3 =dgsGridListAddColumn( vehicle_list,language[language_section][7] , 0.12 )
    column_4 =dgsGridListAddColumn( vehicle_list,language[language_section][8] , 0.12)
    column_5 =dgsGridListAddColumn( vehicle_list,"ID" , 0.1 )


    dgsSetProperty(vehicle_list,"rowHeight",30)       
    dgsSetProperty(vehicle_list,"scrollBarThick",0) 



    ---------------------------------------
    -- Player List
    ---------------------------------------
    --window
    player_list_panel = dgsCreateWindow(0.4,0.3,0.2,0.4,panel_name,true,tocolor(255,255,255),40,title_rect,false,false,tocolor(12,12,12,200),false,true)
    dgsWindowSetSizable(player_list_panel,false)
    dgsWindowSetMovable(player_list_panel,false)
    dgsSetProperty(player_list_panel, "functions",[[
        dgsCanvasRender(dgsElementData[self].renderCanvas)
    ]])
    dgsSetProperty(player_list_panel, "renderCanvas", canvas_title)
    dgsSetFont(player_list_panel, "default-bold")
    
    bottom_img_player_list = dgsCreateImage(-0.001,0.87,1.006,0.13,bottom_img_rect,true,player_list_panel,tocolor(255,166,38))
    dgsSetProperty(bottom_img_player_list, "functions",[[
        dgsCanvasRender(dgsElementData[self].renderCanvas)
    ]])
    dgsSetProperty(bottom_img_player_list, "renderCanvas", canvas_title)
    dgsImageSetImage(bottom_img_player_list,bottom_img_rect)

    ---GridList
    player_list = dgsCreateGridList(0,0,1,0.85,true,player_list_panel,20,tocolor(0,0,0,0),false,tocolor(0,0,0,0),tocolor(0,0,0,0),tocolor(255,166,38,120),tocolor(255,59,84,120))
    pl_col1 = dgsGridListAddColumn( player_list,language[language_section][18][1] , 0.45)
    pl_col2 = dgsGridListAddColumn( player_list,language[language_section][27][1] , 0.45)

    dgs.select_player_btn = createButton(0.4,0.75,0.2,0.04,language[language_section][19][1],true)
    
    ---------------------------------
    -- Trade Pannel
    ---------------------------------
    trade_panel = dgsCreateWindow(0.25,0.25,0.6,0.5,panel_name,true,tocolor(255,255,255),40,title_rect,false,false,tocolor(12,12,12,200),false,true)
    dgsWindowSetSizable(trade_panel,false)
    dgsWindowSetMovable(trade_panel,false)
    dgsSetProperty(trade_panel, "functions",[[
        dgsCanvasRender(dgsElementData[self].renderCanvas)
    ]])
    dgsSetProperty(trade_panel, "renderCanvas", canvas_title)
    dgsSetFont(trade_panel, "default-bold")
    
    bottom_img_trade = dgsCreateImage(-0.001,0.87,1.006,0.1,bottom_img_rect,true,trade_panel,tocolor(255,166,38))
    dgsSetProperty(bottom_img_trade, "functions",[[
        dgsCanvasRender(dgsElementData[self].renderCanvas)
    ]])
    dgsSetProperty(bottom_img_trade, "renderCanvas", canvas_title)
    dgsImageSetImage(bottom_img_trade,bottom_img_rect)
    --Gridlist P1
    trade_player1_list = dgsCreateGridList(0,0,0.4,0.75,true,trade_panel,20,tocolor(0,0,0,0),false,tocolor(0,0,0,0),tocolor(0,0,0,0),tocolor(255,166,38,120),tocolor(255,59,84,120))
    trade_player1_list_col1 = dgsGridListAddColumn( trade_player1_list,"ID", 0.1)
    trade_player1_list_col2 = dgsGridListAddColumn( trade_player1_list,language[language_section][5][1], 0.3)
    trade_player1_list_col3 = dgsGridListAddColumn( trade_player1_list,language[language_section][6][1], 0.2)
    trade_player1_list_col4 = dgsGridListAddColumn( trade_player1_list,language[language_section][7][1], 0.2)
    trade_player1_list_col5 = dgsGridListAddColumn( trade_player1_list,language[language_section][8][1], 0.2)
    label_p1 = dgsCreateLabel(0.41,0.2,0.2,0.10,"<"..language[language_section][35][1].."\n"..language[language_section][36][1].."\n"..language[language_section][38][1],true,trade_panel,tocolor(255,255,255),1.5,1.5,false,false,false,"left")

    --Gridlist P2
    trade_player2_list = dgsCreateGridList(0.6,0,0.4,0.75,true,trade_panel,20,tocolor(0,0,0,0),false,tocolor(0,0,0,0),tocolor(0,0,0,0),tocolor(255,166,38,120),tocolor(255,59,84,120))
    trade_player2_list_col1 = dgsGridListAddColumn( trade_player2_list,"ID", 0.1)
    trade_player2_list_col2 = dgsGridListAddColumn( trade_player2_list,language[language_section][5][1], 0.3)
    trade_player2_list_col3 = dgsGridListAddColumn( trade_player2_list,language[language_section][6][1], 0.2)
    trade_player2_list_col4 = dgsGridListAddColumn( trade_player2_list,language[language_section][7][1], 0.2)
    trade_player2_list_col5 = dgsGridListAddColumn( trade_player2_list,language[language_section][8][1], 0.2)
    label_p2 = dgsCreateLabel(0.4,0.6,0.2,0.10,">\n"..language[language_section][36][1].."\n"..language[language_section][38][1],true,trade_panel,tocolor(255,255,255),1.5,1.5,false,false,false,"right")


    dgs.trade_money_p1 = dgsCreateLabel(0,0.75,0.4,0.1,"0"..money_type,true,trade_panel,tocolor(133,187,101),2,2,false,false,false,"center")
    dgs.trade_money_p2 = dgsCreateLabel(0.6,0.75,0.4,0.1,"0"..money_type,true,trade_panel,tocolor(133,187,101),2,2,false,false,false,"center")


    -----------------------------
    ---Close trade
    -----------------------------
    dgs.close_trade = createButton(0.25,0.79,0.09,0.04,language[language_section][2][1],true)

    -----------------------------
    ---add vehicle trade
    -----------------------------
    dgs.add_vehicle_trade = createButton(0.355,0.79,0.09,0.04,language[language_section][22][1],true)

    -----------------------------
    ---remove vehicle trade
    -----------------------------
    dgs.lock_trade = createButton(0.46,0.79,0.09,0.04,language[language_section][24][1],true)

    -----------------------------
    ---Add money trade
    -----------------------------
    dgs.add_money_trade = createButton(0.56,0.79,0.09,0.04,language[language_section][23][1],true)

    --------------------------------
    --show items
    --------------------------------
    dgs.show_trade = createButton(0.66,0.79,0.09,0.04,language[language_section][20][1],true)

    --------------------------------
    --Approval trade btn
    -------------------------------
    dgs.approval_trade = createButton(0.76,0.79,0.09,0.04,language[language_section][21][1],true)


    ------------------------------
    --Approval Panel
    ------------------------------
        ----------------------------------------------------------
    --add remove and sell window
    ----------------------------------------------------------
    vehicle_add_rev_panel = dgsCreateWindow(0.4,0.4,0.3,0.15,panel_name,true,tocolor(255,255,255),35,title_rect,false,false,tocolor(12,12,12,200),false,true)
    dgsWindowSetSizable(vehicle_add_rev_panel,false)
    dgsWindowSetMovable(vehicle_add_rev_panel,false)
    dgsSetProperty(vehicle_add_rev_panel, "functions",[[
        dgsCanvasRender(dgsElementData[self].renderCanvas)
    ]])
    dgsSetProperty(vehicle_add_rev_panel, "renderCanvas", canvas_title)
    dgsSetFont(vehicle_add_rev_panel, "default-bold")

    local bottom_img_2 = dgsCreateImage(-0.0001,0.7,1.004,0.3,bottom_img_rect,true,vehicle_add_rev_panel,tocolor(255,166,38))
    dgsSetProperty(bottom_img_2, "functions",[[
        dgsCanvasRender(dgsElementData[self].renderCanvas)
    ]])
    dgsSetProperty(bottom_img_2, "renderCanvas", canvas_title)
    dgsImageSetImage(bottom_img_2,bottom_img_rect)


    -----------------------------------------
    --write id ( - id yazma - )
    --------------------------------------------
    id_label = dgsCreateLabel(0.04,0.14,0.2,0.25,"ID",true,vehicle_add_rev_panel,false,1.4,1.4)
    dgsLabelSetHorizontalAlign(id_label,"center")
    dgsSetFont(id_label, "default-bold")
    local id_round = dgsCreateRoundRect(12,false,tocolor(255,255,255,255))
    dgs.id_edit = dgsCreateEdit(0.04,0.3,0.2,0.25,"",true,vehicle_add_rev_panel,tocolor(0,0,0),false,false,id_round)
    dgsEditSetHorizontalAlign(dgs.id_edit,"center")
    dgsEditSetCaretStyle(dgs.id_edit,1)
    dgsSetProperty(dgs.id_edit,"caretColor",tocolor(1,1,1,255))

    -----------------------------------------
    --write price ( - price yazma - )
    ------------------------------------------
    price_label = dgsCreateLabel(0.28,0.14,0.2,0.25,language[language_section][26],true,vehicle_add_rev_panel,false,1.4,1.4)
    dgsLabelSetHorizontalAlign(price_label,"center")
    dgsSetFont(price_label, "default-bold")
    dgs.price_edit = dgsCreateEdit(0.28,0.3,0.2,0.25,"",true,vehicle_add_rev_panel,tocolor(0,0,0),false,false,id_round)
    dgsEditSetHorizontalAlign(dgs.price_edit,"center")
    dgsEditSetCaretStyle(dgs.price_edit,1)
    dgsSetProperty(dgs.price_edit,"caretColor",tocolor(1,1,1,255))

    ----------------------------------
    -- approval buton ( - onaylama buton - )
    -------------------------------------
    dgs.approval_btn = createButton(0.52,0.3,0.2,0.25,language[language_section][21],true,vehicle_add_rev_panel)
    dgs.close_approval_btn = createButton(0.76,0.3,0.2,0.25,language[language_section][2],true,vehicle_add_rev_panel)


    dgsSetVisible(trade_panel,false)
    dgsSetVisible(vehicle_add_rev_panel,false)
    dgsSetVisible(player_list_panel,false)
    dgsSetVisible(vehicle_get_panel,false)
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



