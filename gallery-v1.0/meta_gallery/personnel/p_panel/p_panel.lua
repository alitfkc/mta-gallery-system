gui = {}
local function resource_start_p()
    ----------------------------------------------
    -- Personnel Panel
    ----------------------------------------------
    p_panel = guiCreateWindow(0.2,0.25,0.75,0.5,language[language_section][14][1],true)

    --edit 1 id (id)
    local id_p_panel = guiCreateLabel(0.01,0.05,0.12,0.05,"ID",true,p_panel)
    guiLabelSetHorizontalAlign(id_p_panel,"center")
    gui.id = guiCreateEdit(0.01,0.1,0.12,0.05,"",true,p_panel)
    
    --edit 2 brand (marka)
    local brand_p_panel = guiCreateLabel(0.16,0.05,0.12,0.05,language[language_section][5][1],true,p_panel)
    guiLabelSetHorizontalAlign(brand_p_panel,"center")
    gui.brand = guiCreateEdit(0.16,0.1,0.12,0.05,"",true,p_panel)

    --edit 3 model (model)
    local model_p_panel = guiCreateLabel(0.28,0.05,0.12,0.05,language[language_section][6][1],true,p_panel)
    guiLabelSetHorizontalAlign(model_p_panel,"center")
    gui.model = guiCreateEdit(0.30,0.1,0.12,0.05,"",true,p_panel)

    --edit 4 model year (model yılı)
    local model_year_p_panel = guiCreateLabel(0.42,0.05,0.12,0.05,language[language_section][7][1],true,p_panel)
    guiLabelSetHorizontalAlign(model_year_p_panel,"center")
    gui.model_year = guiCreateEdit(0.44,0.1,0.12,0.05,"",true,p_panel)

    --edit 5 price
    local price_p_panel = guiCreateLabel(0.56,0.05,0.12,0.05,language[language_section][8][1],true,p_panel)
    guiLabelSetHorizontalAlign(price_p_panel,"center")
    gui.price = guiCreateEdit(0.58,0.1,0.12,0.05,"",true,p_panel)

    
    --edit 6 stocks
    local stock_p_panel = guiCreateLabel(0.70,0.05,0.12,0.05,language[language_section][9][1],true,p_panel)
    guiLabelSetHorizontalAlign(stock_p_panel,"center")
    gui.stock = guiCreateEdit(0.72,0.1,0.12,0.05,"",true,p_panel)

    --add cars button
    gui.add_remove_car = guiCreateButton(0.85,0.1,0.15,0.05,language[language_section][15][1],true,p_panel)

    
    --change car's id
    gui.change_id = guiCreateButton(0.01,0.165,0.12,0.05,language[language_section][24][1],true,p_panel)

    --change car's brand
    gui.change_brand = guiCreateButton(0.16,0.165,0.12,0.05,language[language_section][16][1],true,p_panel)

    --change car's model
    gui.change_model = guiCreateButton(0.30,0.165,0.12,0.05,language[language_section][17][1],true,p_panel)

    --change car's model year
    gui.change_model_year = guiCreateButton(0.44,0.165,0.12,0.05,language[language_section][18][1],true,p_panel)

    --change car's price
    gui.change_price = guiCreateButton(0.58,0.165,0.12,0.05,language[language_section][19][1],true,p_panel)

    --change car's stock
    gui.change_stock = guiCreateButton(0.72,0.165,0.12,0.05,language[language_section][20][1],true,p_panel)

    --search car's
    gui.search_vehicle = guiCreateEdit(0.85,0.165,0.15,0.05,language[language_section][4][1],true,p_panel)

    -- cars list
    p_p_cars_list = guiCreateGridList(0.01,0.23,0.98,0.88,true,p_panel)
    cars_list_column1 = guiGridListAddColumn(p_p_cars_list,"ID",0.08)
    cars_list_column2 = guiGridListAddColumn(p_p_cars_list,language[language_section][5][1],0.2)
    cars_list_column3 = guiGridListAddColumn(p_p_cars_list,language[language_section][6][1],0.2)
    cars_list_column4 = guiGridListAddColumn(p_p_cars_list,language[language_section][7][1],0.15)
    cars_list_column5 = guiGridListAddColumn(p_p_cars_list,language[language_section][8][1],0.18)
    cars_list_column6 = guiGridListAddColumn(p_p_cars_list,language[language_section][9][1],0.14)

    guiSetVisible(p_panel,false)
end
addEventHandler("onClientResourceStart",resourceRoot,resource_start_p)