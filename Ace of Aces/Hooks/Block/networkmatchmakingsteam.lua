local AABlock_set_attributes = NetworkMatchMakingSTEAM.set_attributes
function NetworkMatchMakingSTEAM:set_attributes(settings, ...)
	if settings.numbers[3] == 1 then
		settings.numbers[3] = 2
	end
	AABlock_set_attributes(self, settings, ...)
end

function NetworkMatchMakingSTEAM:is_server_ok(friends_only, room)
	local OK = false
	if Steam:logged_on() and Steam:friends() then
		for _, friend in ipairs(Steam:friends()) do
			if friend:id() == room then
				OK = true
				break
			end
		end
	end
	return OK
end