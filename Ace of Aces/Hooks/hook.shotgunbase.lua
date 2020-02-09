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
		self.__old_fire_raycast = self._fire_raycast
	end
end)

Hooks:PostHook(ShotgunBase, "_fire_raycast", "AA_"..Idstring("PostHook:ShotgunBase:_fire_raycast"):key(), function(self, ...)
	if self.__old_fire_raycast and self._AA_shotgun_more_bullet_addon and not self._AA_shotgun_more_bullet_bool and managers.player:has_category_upgrade("shotgun", "shotgun_more_bullet") then
		self._AA_shotgun_more_bullet_bool = true
		for i = 1, self._AA_shotgun_more_bullet_addon do
			self:__old_fire_raycast(...)
		end
		self._AA_shotgun_more_bullet_bool = nil
	end
end)