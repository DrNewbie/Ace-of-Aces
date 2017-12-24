Hooks:PostHook(MissionDoor, "activate", 'AA_MissionDoor_activate', function(self)
	if self._unit and alive(self._unit) and self._unit:interaction() then
		if type(self._devices) == "table" then
			for _type, data in pairs(self._devices) do
				if _type == "key" then
					self._unit:interaction():set_tweak_data("hack_keycard")
					self._unit:interaction():set_active(true, false)
					break
				end
			end
		end
	end
end)