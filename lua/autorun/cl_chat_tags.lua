hook.Add("OnPlayerChat", "Tags", function(ply, Text, Team, PlayerIsDead)
	if ply:IsPlayer() then
		local TagDeadColor = Color(255, 0, 0, 255)
		local TagDeadText = "*DEAD* "
		local TagTeamColor = Color(0, 200, 0, 255)
		local TagTeamText = "(TEAM) "
		local TagGroupColor = team.GetColor(ply:Team())
		local TagGroupText = team.GetName(ply:Team())
		local TagDividerGroupName = " | "
		local TagDividerGroupNameColor = Color(50, 50, 50, 255)
		local TagDividerNameText = ": "
		local TagDividerNameColor = Color(255, 255, 255, 255)
		local TagTextColor = Color(255, 255, 255, 255)

		if Team then
			if ply:Alive() then
				chat.AddText(TagTeamColor, TagTeamText, TagGroupColor, TagGroupText, TagDividerGroupNameColor, TagDividerGroupName, TagGroupColor, ply:Nick(), TagDividerNameColor, TagDividerNameText, TagTextColor, Text)
			else
				chat.AddText(TagDeadColor, TagDeadText, TagTeamColor, TagTeamText, TagGroupColor, TagGroupText, TagDividerGroupNameColor, TagDividerGroupName, TagGroupColor, ply:Nick(), TagDividerNameColor, TagDividerNameText, TagTextColor, Text)
			end
		else
			if ply:Alive() then
				chat.AddText(TagTeamColor, TagGroupColor, TagGroupText, TagDividerGroupNameColor, TagDividerGroupName, TagGroupColor, ply:Nick(), TagDividerNameColor, TagDividerNameText, TagTextColor, Text)
			else
				chat.AddText(TagDeadColor, TagDeadText, TagGroupColor, TagGroupText, TagDividerGroupNameColor, TagDividerGroupName, TagGroupColor, ply:Nick(), TagDividerNameColor, TagDividerNameText, TagTextColor, Text)
			end
		end
		return true
	end
end)
