_G.AceAces = _G.AceAces or {}
AceAces.Settings = AceAces.Settings or {}

Hooks:PostHook(ShotgunBase, "setup_default", "AA_"..Idstring("PostHook:ShotgunBase:setup_default"):key(), function(self)
	if managers.player:has_category_upgrade("shotgun", "shotgun_no_falloff") then
		if not self.__old_damage_near then
			self.__old_damage_near = self._damage_near
		end
		self._damage_near = math.huge
	end
	if managers.player:has_category_upgrade("shotgun", "shotgun_more_bullet") then
		self._AA_shotgun_more_bullet_addon = managers.player:upgrade_value("shotgun", "shotgun_more_bullet", 0)
	end
end)

local AA_shotgun_more_bullet_data = nil

local old_fire_raycast = ShotgunBase._fire_raycast

function ShotgunBase:_fire_raycast(...)
	if self._AA_shotgun_more_bullet_addon and not self._AA_shotgun_more_bullet_bool and managers.player:has_category_upgrade("shotgun", "shotgun_more_bullet") then
		self._AA_shotgun_more_bullet_bool = true
		AA_shotgun_more_bullet_data = nil
		AA_shotgun_more_bullet_data = {...}
		for __i = 1, self._AA_shotgun_more_bullet_addon do
			DelayedCalls:Add("AA_shotgun_more_bullet_delay_"..__i, 0.05*__i, function()
				if type(AA_shotgun_more_bullet_data) == "table" then
					ShotgunBase.super._fire_raycast(self, unpack(AA_shotgun_more_bullet_data))
				end
			end)
		end
		self._AA_shotgun_more_bullet_bool = nil
	end
	return old_fire_raycast(self, ...)
end