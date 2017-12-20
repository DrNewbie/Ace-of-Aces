local set_attributes_original = NetworkMatchMakingSTEAM.set_attributes
function NetworkMatchMakingSTEAM:set_attributes(settings, ...)
	settings.numbers[3] = settings.numbers[3] < 2 and 2 or settings.numbers[3]
	set_attributes_original(self, settings, ...)
end

local is_server_ok_original = NetworkMatchMakingSTEAM.is_server_ok
function NetworkMatchMakingSTEAM:is_server_ok(friends_only, room, attributes_numbers, is_invite, ...)
	if attributes_numbers[3] < 2 then
		return false
	end
	return is_server_ok_original(self, friends_only, room, attributes_numbers, is_invite, ...)
end