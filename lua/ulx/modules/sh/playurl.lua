local CATEGORY_NAME = "Apple's Creations"

// Plays the song
function ulx.playurlsound( calling_ply, urlsound )
local options = ""
	
	umsg.Start("ulib_url_sound")
		umsg.String(urlsound)
	umsg.End()
	
end
local playurlsound = ulx.command( CATEGORY_NAME, "ulx playurlsound", ulx.playurlsound, "!playurl" )
playurlsound:addParam{ type=ULib.cmds.StringArg, hint="sound", autocomplete_fn=ulx.soundComplete }
playurlsound:defaultAccess( ULib.ACCESS_ADMIN )
playurlsound:help( "Play a URL song for the server" )

