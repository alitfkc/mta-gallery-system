marker_players = {}
local function resource_start_marker()
    for k,v in ipairs(gallerys) do 
        local x,y,z,scale,type,r,g,b,a = unpack(v[1])
        local marker = createMarker(x,y,z,type,scale,r,g,b,a,root)
        addEventHandler("onMarkerHit",marker,marker_join)
    end
end

--------------------------------------------------------
-- Marker hit open shop panel ( - Markere girince mağaza paneli açılması - )
----------------------------------------------------------
function marker_join(hit)
    if getElementType(hit) ~= "player" then return end
    local mx,my,mz = getElementPosition(source)
    for k,v in ipairs(gallerys) do 
        local x,y,z = unpack(v[1])
        x,y,z,mx,my,mz = math.floor(x),math.floor(y),math.floor(z),math.floor(mx),math.floor(my),math.floor(mz)
        if x == mx and y == my and z == mz then 
            marker_players[hit] = v[2]
            local marker_vehicles =  v[3]
            local state = triggerClientEvent("open_bazaar_panel",hit,marker_vehicles,global_vehicle)
            if state then 
                set_shop_camera(hit)
            end
        end
    end
end

---------------------------------------------------------------
-- player quit remove marker_player table ( - oyuncu oyundan çıkarsa marker -)
---------------------------------------------------------------
local function player_quit()
    if marker_players[source] then 
        marker_players[source] = nil
    end
end
addEventHandler("onPlayerQuit",root,player_quit)

---------------------------------------------------------------------
-- set camera matrix ( - kamera matrisini ayarla - )
---------------------------------------------------------------------
function set_shop_camera(player)
    setElementInterior(player,1)
    setElementPosition(player,1418.31982, -18.02064, 1000.92712)
    setCameraMatrix(player,1384.92134, -25.15254, 1006.52308,1362.17554, -25.66608, 1004.40240)
end




addEventHandler("onResourceStart",resourceRoot,resource_start_marker)