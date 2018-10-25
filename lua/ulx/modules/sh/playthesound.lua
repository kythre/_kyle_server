if not(CLIENT) then return end

function playsoundpleaseokay(data)
        url = data:ReadString()
        if LocalPlayer().channel ~= nil && LocalPlayer().channel:IsValid() then
                LocalPlayer().channel:Stop()
        end
        sound.PlayURL(url,"",function(ch)
                if ch != nil and ch:IsValid() then
                        ch:Play()
                        LocalPlayer().channel = ch
                end
                end)
end

usermessage.Hook( "ulib_url_sound", playsoundpleaseokay )



function stopmysongplease(data)
local stoppingsong = "You have stopped the URL for yourself."
        if LocalPlayer().channel ~= nil && LocalPlayer().channel:IsValid() then
                LocalPlayer().channel:Stop()
        end
	chat.AddText(Color(0,0,200),stoppingsong)
end

usermessage.Hook("stopmysongplease",stopmysongplease)

function startmysongplease(data)
local startingsong = "You have started a URL for yourself."
        urlme = data:ReadString()
        if LocalPlayer().channel ~= nil && LocalPlayer().channel:IsValid() then
                LocalPlayer().channel:Stop()
        end
        sound.PlayURL(urlme,"",function(ch)
                if ch != nil and ch:IsValid() then
                        ch:Play()
                        LocalPlayer().channel = ch
                end
                end)
	chat.AddText(Color(0,0,200),startingsong)
end

usermessage.Hook("startmysongplease",startmysongplease)