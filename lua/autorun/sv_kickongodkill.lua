hook.Add("PlayerDeath", "kickongodkill",  function(x,y,z)
	if (x ~= z and z:IsPlayer() and z:HasGodMode()) then
		z:Kick("Killing in god mode")
	end
end, HOOK_HIGH )
