_outputChatBox = outputChatBox
function outputChatBox(text,player,r,g,b)
    if not notification then 
        _outputChatBox(text,player,r,g,b)
    else
        notification:event(text,player,r,g,b)
    end
end