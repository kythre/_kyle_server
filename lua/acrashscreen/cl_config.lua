local _this = aCrashScreen.config
---------------------------------

-- Chat ID, useful for multiple servers
-- Not case sensitive only letters, numbers and underscores are allowed
_this.chatID = "server_one"

-- Your community name
_this.communityName = "the server"

-- The web-based server status checker
-- This will check if the server is online, if it is it will automatically reconnect
-- Set this to false if you want to use auto reconnection after x amount of seconds
_this.serverStatusURL = ""

_this.serverStatusURL = false

-- How long to wait for the client to reconnect to the server when it is back up
-- If you're reconnecting before the server is fully loaded, increase this value
_this.serverOnlineReconnectingTime = 15

-- Only if serverStatusURL is false, this will auto reconnect after x amount of seconds
_this.reconnectingTime = 40

-- THIS server's IP address and Port
-- Only needed if you use serverStatusURL
_this.serverIP = ""
_this.serverPort = ""

-- Background image(s), must give the correct image width and height
-- Animated images won't work
-- Maximum size of the image is 2048 pixels in width and height
-- Backgrounds will be chosen randomly
-- Set backgroundUrls to false to use backgroundColor instead
_this.backgroundUrls = {
	{ 
		"http://orig10.deviantart.net/7dd2/f/2014/159/a/5/mac_wallpaper___flat_colors___1920x1200_by_dakirby309-d7lmemf.jpg", -- Image URL
		1920, 1080, -- Width, Height
		false -- true is Fill, false is Stretch. Fill and Stretch explained: http://i.imgur.com/jlzYCvT.png
	}
}

_this.backgroundUrls = false

-- Color of the background, will only be shown if the background image is disabled
_this.backgroundColor = Color( 0, 0, 0 )

-- Song(s), has to be a direct url to the file
-- Will be chosen randomly, but will only play once until all songs have been played
-- Set this to false if you want this disabled
_this.songUrls = false

-- The web-based chat
-- Set this to false if you want this disabled
_this.chatURL = "http://kythre.nl/acrashscreen/chat/chat.php"

-- Chat user properties: nick names and noticable messages
local ranks = {}
ranks[ 'manager' ] = { Color( 125, 0, 180 ), true } -- { nick name color, if true user can use ! in front of their text to type a noticable message }
ranks[ 'kyle' ] = { Color( 200, 200, 200 ), false }

function _this.getUserProperties( ply ) -- This is somewhat more advanced
	
	local userGroup = ply:GetUserGroup()
	if ranks[ userGroup ] then
		return ranks[ userGroup ][ 1 ], ranks[ userGroup ][ 2 ] or false
	end
	
	if ply:IsSuperAdmin() then return Color( 255, 71, 71 ), true end -- Any superadmin
	if ply:IsAdmin() then return Color( 128, 0, 255 ), true end -- Any admin
	
	return Color( 200, 200, 200 ), false -- Default color
end

-- Custom buttons
_this.buttons = {
	-- "Button text", function or server ip:port to connect to
	-- { "Our forums", function() gui.OpenURL( 'http://www.example.com' ) end },
	-- { "Join DarkRP #2", '127.0.0.1:27016' },
	-- { "Join TTT", '127.0.0.1:27017' }
}

-- If you want to adjust the looks of the crash menu find file 'cl_menu.lua'
-- To enable readable error messages go to 'sh_start.lua'
-- Obviously this will require you to have some GLua knowledge
-- If you do manage to break something while editing this file do not ask for support, revert the changes instead

--[[////////////////////////// Contact & Support /////////////////////////////////
//                                                                              //
//        If you find any bugs or have a problem feel free to contact me:       //
//                    http://steamcommunity.com/id/ikefi                        //
//                     As my profile description states:                        //
//               i might not add you right away or not at all.                  //
//              it'll be better to just create a ticket instead.                //
//                                                                              //
////////////////////////////////////////////////////////////////////////////////]]