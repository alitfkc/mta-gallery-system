
function cancel_ped_damage()
    cancelEvent()
end
setTimer(function()
    for k,v in ipairs(getElementsByType('ped' , getResourceRootElement(getThisResource()), true)) do 
        addEventHandler("onClientPedDamage",v,cancel_ped_damage)
    end
end,5000,1)
