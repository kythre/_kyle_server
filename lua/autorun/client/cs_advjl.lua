--[[
	Advanced Join & Leave Messages Supporting Sounds & GEOPIP for ULX
	Written by Fannney' or also known as MyU
	Contact:
		Skype: myudev
		Mail: myudev0@googlemail.com
		Steam: http://steamcommunity.com/id/fannney/
]]
local netMsgStr = "advjl_info"
local playerColors = {}

function Ply(name)
	name = string.lower(name);
	for _,v in ipairs(player.GetHumans()) do
		if(string.find(string.lower(v:Name()),name,1,true) != nil)
			then return v;
		end
	end
end

-- TEST ME
local function AddText_Colorful ( text )
	local args = {}
	local coloring_happend = false
	for i=1, #text do
		local char = string.sub ( text , i, i )
		
		local name = string.sub(string.Explode("#", text, false)[1], 3, #string.Explode("#", text, false)[1]-1)
		
		if char == "$" then
			playerColors[name]=playerColors[name] or team.GetColor(Ply(name):Team())
		
			table.insert ( args, playerColors[name])
			table.insert ( args, name.." ")
		end
		
		
		if char == "#" then
			local colend = i+7
			local color = string.sub ( text, i+1, i+6 )

			local r,g,b = tonumber ( "0x" .. string.sub(color, 1, 2) ), tonumber ( "0x" .. string.sub(color, 3, 4) ), tonumber ( "0x" .. string.sub(color, 5, 6) ) -- hu, hacky! 
			local iLastText = 0
			for ii=colend, #text do
				local charInner = string.sub ( text , ii, ii )
				if charInner == "#" then
					break
				else
					iLastText = ii
				end
			end
			table.insert ( args, Color(r,g,b,255) )
			table.insert ( args, string.sub(text, colend, iLastText) )
			coloring_happend = true
		end
	
	end

	if coloring_happend then
		chat.AddText ( unpack ( args ) )
	else
		chat.AddText ( text )
	end
	
end

net.Receive( netMsgStr, function( len )
	local data = net.ReadTable()
	if data then 
		AddText_Colorful ( data.msg )
	end
end)
