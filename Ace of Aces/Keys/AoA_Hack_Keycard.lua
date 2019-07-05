if managers.hud then
	if AceAces.UseHackKeycard then
		AceAces.UseHackKeycard = nil
		managers.hud:show_hint({
			time = 3,
			text = "Hack Keycard [OFF]"
		})
	else
		AceAces.UseHackKeycard = true
		managers.hud:show_hint({
			time = 3,
			text = "Hack Keycard [ON]"
		})
	end
end