// client side apple

// Spawn
function LastJoined( data )
local name = data:ReadString()
local date = data:ReadString()
local teamcolour = team.GetColor(data:ReadShort())
local timesjoined = data:ReadShort()
	chat.AddText(teamcolour,name, Color( 255, 255, 255 ), " was last on this server on: ",teamcolour,date, Color( 255, 255, 255 ), " (",teamcolour,tostring(timesjoined),Color( 255, 255, 255 ),")")
end
usermessage.Hook("LastJoined", LastJoined)


function LastJoinedError( data )
local errorname = data:ReadString()
	chat.AddText( Color( 255, 0, 255 ), "[Server] ", Color( 255, 0, 0 ), errorname )
end
usermessage.Hook("LastJoinedError", LastJoinedError)


function CheckJoinedPly( data )
local plyplayername = data:ReadString()
local plyteam = data:ReadString()
local plytimesjoined = data:ReadString()
local plylastvisit = data:ReadString()
local plylastvisittime = data:ReadString()
local plyfirstjoin = data:ReadString()
MsgN(plyteam)
for k, v in pairs(team.GetAllTeams( )) do
if tostring(v['Name']) == tostring(plyteam) then
PlayerTeamColorr = tonumber(v['Color'].r)
PlayerTeamColorg = tonumber(v['Color'].g)
PlayerTeamColorb = tonumber(v['Color'].b)
PlayerTeamColora = tonumber(v['Color'].a)
end
end
	chat.AddText( Color( 255, 255, 255 ), "Join Stats For: ",Color(PlayerTeamColorr,PlayerTeamColorg,PlayerTeamColorb,PlayerTeamColora),plyplayername )
	chat.AddText( Color( 255, 255, 255 ), "First Joined: ",Color( 0, 255, 0),tostring(plyfirstjoin))
	chat.AddText( Color( 255, 255, 255 ), "Last Joined: ",Color( 0, 255, 0),tostring(plylastvisit), " | ", plylastvisittime)
	chat.AddText( Color( 255, 255, 255 ), "Times Joined: ",Color( 0, 255, 0),tostring(plytimesjoined))
end
usermessage.Hook("CheckJoinedPly", CheckJoinedPly)
