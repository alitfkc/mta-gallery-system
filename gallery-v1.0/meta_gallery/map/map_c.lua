txd = engineLoadTXD ( "map/object/object.txd" )
engineImportTXD ( txd,sign_object_id )
dff = engineLoadDFF ( "map/object/object.dff" )
engineReplaceModel ( dff, sign_object_id )
engineSetModelLODDistance(sign_object_id, 9000)


function cancel_ped_damage()
    cancelEvent()
end
setTimer(function()
    for k,v in ipairs(getElementsByType('ped' , getResourceRootElement(getThisResource()), true)) do 
        addEventHandler("onClientPedDamage",v,cancel_ped_damage)
    end
end,5000,1)
