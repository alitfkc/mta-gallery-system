_outputChatBox = outputChatBox
function outputChatBox(text,r,g,b)
    if not notification then 
        _outputChatBox(text,r,g,b)
    else
        notification:event(text,r,g,b)
    end
end