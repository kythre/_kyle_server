-- LTserver ply:SteamID()e

if not SERVER then return end

function Last_Joined_Table_Check()
	if !(sql.TableExists("lastjoin")) then
		MsgN("LastJoined Table Does not Exist, CREATING NOW!")
		LTcreateTable()
	end
end

function LTcreateTable()
	local result = sql.Query("CREATE TABLE lastjoin (player INTEGER UNSIGNED NOT NULL, lastvisit VARCHAR(100) NOT NULL, lastvisittime VARCHAR(100) NOT NULL, firstjoin VARCHAR(100) NOT NULL, timesjoined VARCHAR(100) NOT NULL, steamid VARCHAR(45) NOT NULL, playername VARCHAR(100) NOT NULL, team VARCHAR(45),PRIMARY KEY (player))")
	//MsgN("14: ".. sql.LastError(result))
end
---------------------------------------

function LTonJoin( ply )
	function LTupdateLastVisit(ply)
	timer.Simple(3, function()
	if !ply:IsValid() then return end
        local CheckError = sql.Query("UPDATE lastjoin SET lastvisit = '"..os.date("%B %d 20%y").."', lastvisittime = '"..os.date("%I:%M:%S %p").."', timesjoined = '"..tonumber(ply:GetPData("LastJoinedNum") ).."', playername = "..sql.SQLStr(ply:Nick())..", team = "..sql.SQLStr(team.GetName( ply:Team() )).." WHERE player = "..ply:UniqueID().."")
		//MsgN("23: ".. sql.LastError(CheckError))
	end)
    end
	
	function LTupdateLastVisit2(ply)
		timer.Simple(1, function()
		if !ply:IsValid() then return end
			
			local LTrow22 = sql.Query("SELECT * FROM lastjoin WHERE player = "..ply:UniqueID().." LIMIT 1;")
			//MsgN("32: ".. sql.LastError(LTrow22))
				if not (LTrow22 == nil) then
					for k, v in pairs(LTrow22) do
						PlayerFirstJoinedUpdateAllFirst = tostring(v.lastvisit)
						PlayerFirstJoinedUpdateAllFirst2 = tostring(v.lastvisittime)
					end
				end
			
			
			timer.Simple(1, function()
				if PlayerFirstJoinedUpdateAllFirst == nil || PlayerFirstJoinedUpdateAllFirst == NULL || PlayerFirstJoinedUpdateAllFirst == "" then
					PlayerFirstJoinedUpdateAllFirst = tostring(os.date("%B %d 20%y"))
				elseif PlayerFirstJoinedUpdateAllFirst2 == nil || PlayerFirstJoinedUpdateAllFirst2 == NULL || PlayerFirstJoinedUpdateAllFirst2 == "" then
					PlayerFirstJoinedUpdateAllFirst2 = tostring(os.date("%I:%M:%S %p"))
				end
				local LTQc = sql.Query("UPDATE lastjoin SET firstjoin = '"..PlayerFirstJoinedUpdateAllFirst.." | "..PlayerFirstJoinedUpdateAllFirst2.."' WHERE player = "..ply:UniqueID().."")
				//MsgN("48: ".. sql.LastError(LTQc))
			end)
		end)
    end
     
    function LTaddPly(ply)
	timer.Simple(1, function()
	if !ply:IsValid() then return end
        local LTQc = sql.Query("INSERT into lastjoin ( player, lastvisit, lastvisittime, firstjoin, timesjoined, steamid, playername, team ) VALUES ( '"..ply:UniqueID().."', '"..os.date("%B %d 20%y").."', '"..os.date("%I:%M:%S %p").."', '"..os.date("%B %d 20%y").." | "..os.date("%I:%M:%S %p").."','"..tonumber(1).."', '" .. ply:SteamID() .. "', "..sql.SQLStr(ply:Nick())..", "..sql.SQLStr(team.GetName( ply:Team() ))..")")
		//MsgN("57: ".. sql.LastError(LTQc))
	end)
    end
     

        local LTrow = sql.Query("SELECT * FROM lastjoin WHERE player = '"..ply:UniqueID().."'")
		//MsgN("63: ".. sql.LastError(LTrow))
            if (LTrow) then
				timer.Simple(1, function()
				if !ply:IsValid() then return end
					if tostring(LTrow[1]['lastvisit']) == tostring(os.date("%B %d 20%y")) then
						MsgC(Color(255,255,255),"Player ",ply:Nick()," was last(",Color(0,255,0),tonumber(LTrow[1]['timesjoined']),Color(255,255,255),") on the server: ",Color(255,0,0),"Today at: ",tostring(LTrow[1]['lastvisittime']),Color(255,255,255),".\n" )
						umsg.Start("LastJoined")
						umsg.String(ply:Nick())
						umsg.String("Today at " ..tostring(LTrow[1]['lastvisittime']))
						umsg.Short(ply:Team())
						umsg.Short(tonumber(LTrow[1]['timesjoined']))
						umsg.End()
						ply:SetPData("LastVisitChecker", (tostring(LTrow[1]['lastvisit'])))
						ply:SetPData("LastVisitChecker2", (tostring(LTrow[1]['lastvisittime'])))
						ply:SetPData("LastJoinedNum", (tonumber(LTrow[1]['timesjoined'])+1))
						if tostring(LTrow[1]['firstjoin']) == nil || tostring(LTrow[1]['firstjoin']) == NULL || tostring(LTrow[1]['firstjoin']) == "" || tostring(LTrow[1]['firstjoin']) == " " then
							MsgN("test")
							LTupdateLastVisit2(ply)
						end
						LTupdateLastVisit(ply)
					else
						MsgC(Color(255,255,255),"Player ",ply:Nick()," was last(",Color(0,255,0),tonumber(LTrow[1]['timesjoined']),Color(255,255,255),") on the server: ",Color(255,0,0),tostring(LTrow[1]['lastvisit'])," - ",tostring(LTrow[1]['lastvisittime']),Color(255,255,255),".\n" )
						umsg.Start("LastJoined")
						umsg.String(ply:Nick())
						umsg.String(tostring(LTrow[1]['lastvisit']).." - "..tostring(LTrow[1]['lastvisittime']))
						umsg.Short(ply:Team())
						umsg.Short(tonumber(LTrow[1]['timesjoined']))
						umsg.End()
						ply:SetPData("LastVisitChecker", (tostring(LTrow[1]['lastvisit'])))
						ply:SetPData("LastVisitChecker2", (tostring(LTrow[1]['lastvisittime'])))
						ply:SetPData("LastJoinedNum", (tonumber(LTrow[1]['timesjoined'])+1))
						if tostring(LTrow[1]['firstjoin']) == nil || tostring(LTrow[1]['firstjoin']) == NULL || tostring(LTrow[1]['firstjoin']) == "" || tostring(LTrow[1]['firstjoin']) == " " then
							MsgN("test")
							LTupdateLastVisit2(ply)
						end
						LTupdateLastVisit(ply)
					end
				end)
            else
				timer.Simple(1, function()
				if !ply:IsValid() then return end
				MsgC(Color(255,255,255),"Player ",ply:Nick()," is: ",Color(255,0,0),"New",Color(255,255,255)," to our servers.\n" )
						umsg.Start("LastJoined")
						umsg.String(ply:Nick())
						umsg.String("First Time Joiner!")
						umsg.Short(ply:Team())
						umsg.Short(1)
						umsg.End()
					LTaddPly(ply)
				end)
            end

end
hook.Add( "PlayerInitialSpawn", "LastJoinInitialSpawn", LTonJoin )


function LTupdatePlayer(ply)
	local LTQc = sql.Query("UPDATE lastjoin SET lastvisit = '"..os.date("%B %d 20%y").."', lastvisittime = '"..os.date("%I:%M:%S %p").."', steamid = '"..ply:SteamID().."', playername = "..sql.SQLStr(tostring(ply:Nick()))..", team = "..sql.SQLStr(tostring(team.GetName( ply:Team()))).." WHERE player = "..ply:UniqueID()..";")
	//MsgN("117: ".. sql.LastError(LTQc))
end
hook.Add( "PlayerDisconnected", "LastJoinDisconnect", LTupdatePlayer )


function LastJoinedCmd(ply,cmd,args)
if args[1] == nil then return end
LJST = (args[1]..args[2]..args[3]..args[4]..args[5])
--MsgN(tostring(LJST))
    function LTcheckRow2(args)
        local LTrow2 = sql.Query("SELECT * FROM lastjoin WHERE steamid = '"..tostring(LJST).."' LIMIT 1")
			//MsgN("128: ".. sql.LastError(LTrow2))
            if (LTrow2) then
				MsgC(Color(0,255,255),"~LAST JOINED CHECK~","\n",Color(255,0,0),"Player Name",Color(255,255,255),": ",tostring(LTrow2[1]['playername']),"\n",Color(255,0,0),"Team",Color(255,255,255),": ",tostring(LTrow2[1]['team']),"\n",Color(255,0,0),"Last Online",Color(255,255,255),"(",Color(255,255,0),tonumber(LTrow2[1]['timesjoined']),Color(255,255,255),"): ",tostring(LTrow2[1]['lastvisit'])," - ",tostring(LTrow2[1]['lastvisittime']),"\n",Color(255,0,0),"Joined",Color(255,255,255),": ",tostring(LTrow2[1]['firstjoin']),"\n")
            end
    end
    LTcheckRow2(args)
end
concommand.Add("lastjoined",LastJoinedCmd)


function LastJoinedCmdA(ply,cmd,args)
    function LTcheckRow23(args)
        local LTQc = sql.Query("SELECT * FROM lastjoin ORDER BY timesjoined DESC LIMIT 10;")
		//MsgN("141: ".. sql.LastError(LTQc))
			for k, v in pairs(LTQc) do
				MsgC(Color(0,255,255),"~LAST JOINED CHECK ","[",k,"]","~","\n",Color(255,0,0),"Player Name",Color(255,255,255),": ",tostring(v.playername),"\n",Color(255,0,0),"Team",Color(255,255,255),": ",tostring(v.team),"\n",Color(255,0,0),"Last Online",Color(255,255,255),"(",Color(255,255,0),tonumber(v.timesjoined),Color(255,255,255),"): ",tostring(v.lastvisit)," - ",tostring(v.lastvisittime),"\n",Color(255,0,0),"Joined",Color(255,255,255),": ",tostring(v.firstjoin),"\n")
			end
    end
    LTcheckRow23(args)
end
concommand.Add("lastjoinedtop",LastJoinedCmdA)


hook.Add("PlayerSay", "PlayerSayECheckFirst", function( ply, text )
local text = string.Explode(" ",text)
if text[1] == "!checkjoin" && text[2] == nil then
	local LTQc = sql.Query("SELECT * FROM lastjoin WHERE player = '"..tostring(ply:UniqueID()).."' LIMIT 1;")
	//MsgN("124: ".. sql.LastError(LTQc))
	
		if not (LTQc) then
			for k, v in pairs(LTQc) do
				MsgC(Color(0,255,255),"~LAST JOINED CHECK ","[",tostring(v.id),"]","~","\n",Color(255,0,0),"Player Name",Color(255,255,255),": ",tostring(v.playername),"\n",Color(255,0,0),"Team",Color(255,255,255),": ",tostring(v.team),"\n",Color(255,0,0),"Last Online",Color(255,255,255),"(",Color(255,255,0),tonumber(v.timesjoined),Color(255,255,255),"): ",tostring(v.lastvisit)," - ",tostring(v.lastvisittime),"\n",Color(255,0,0),"Joined",Color(255,255,255),": ",tostring(v.firstjoin),"\n")
				umsg.Start("CheckJoinedPly", ply)
					umsg.String(tostring(v.playername))
					umsg.String(tostring(v.team))
					umsg.String(tostring(v.timesjoined))
					umsg.String(tostring(ply:GetPData("LastVisitChecker")))
					umsg.String(tostring(ply:GetPData("LastVisitChecker2")))
					umsg.String(tostring(v.firstjoin))
				umsg.End()
			end
		end
	
elseif text[1] == "!checkjoin" && text[2] != nil then
	JoinedServerCheckJoinTbl = {}
	JoinedServerCountNames = {}
	RockStarNameLastJoined = nil
	for k,v in pairs(text) do
		if 1 < k then
			table.insert(JoinedServerCheckJoinTbl,tostring(string.lower(v)))
		end
	end
	
	for k, v in pairs(player.GetAll()) do
		if string.match(tostring(string.lower(v:Nick())), string.Implode(" ",JoinedServerCheckJoinTbl)) != nil then
			table.insert(JoinedServerCountNames,tostring(string.lower(v:Nick())))
			RockStarNameLastJoined = v:UniqueID()
			RockStarNameLastJoinedCK = tostring(v:GetPData("LastVisitChecker"))
			RockStarNameLastJoinedCK2 = tostring(v:GetPData("LastVisitChecker2"))
		end
	end
	if RockStarNameLastJoined == nil || JoinedServerCountNames == nil then return end
	for k,v in pairs(JoinedServerCountNames) do
		if k != 1 then
		MsgN("Too many names!")
		umsg.Start("LastJoinedError", ply)
			umsg.String(tostring("Please be more specific, there happens too be two people with the same name!"))
		umsg.End()
		return end
	end

	local LTQc = sql.Query("SELECT * FROM lastjoin WHERE player = '"..tostring(RockStarNameLastJoined).."' LIMIT 1;")
	//MsgN("198: ".. sql.LastError(LTQc))
	
		if not (LTQc == nil) then
			for k, v in pairs(LTQc) do
				MsgC(Color(0,255,255),"~LAST JOINED CHECK ","[",tostring(v.id),"]","~","\n",Color(255,0,0),"Player Name",Color(255,255,255),": ",tostring(v.playername),"\n",Color(255,0,0),"Team",Color(255,255,255),": ",tostring(v.team),"\n",Color(255,0,0),"Last Online",Color(255,255,255),"(",Color(255,255,0),tonumber(v.timesjoined),Color(255,255,255),"): ",tostring(v.lastvisit)," - ",tostring(v.lastvisittime),"\n",Color(255,0,0),"Joined",Color(255,255,255),": ",tostring(v.firstjoin),"\n")
				umsg.Start("CheckJoinedPly", ply)
					umsg.String(tostring(v.playername))
					umsg.String(tostring(v.team))
					umsg.String(tostring(v.timesjoined))
					umsg.String(tostring(ply:GetPData("LastVisitChecker")))
					umsg.String(tostring(ply:GetPData("LastVisitChecker2")))
					umsg.String(tostring(v.firstjoin))
				umsg.End()
			end
		end
end

end)

Last_Joined_Table_Check()