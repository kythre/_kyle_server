hook.Add( "PlayerDisconnected", "autorestart", function()
    timer.Simple(300, function()
        if #player.GetAll() == 0 then
			if	DiscordRelay then
				local date = os.date( "*t" )
				DiscordRelay.SendToDiscordRaw(nil, nil,  string.format( "[%02i:%02i:%02i] ", date.hour, date.min, date.sec ) .. "server empty for 5 minutes, map restarting" )
			end
			print("server empty for 5 minutes, map restarting")
			game.LoadNextMap()
        end
    end)
end)