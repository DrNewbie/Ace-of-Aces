_G.AceAces = _G.AceAces or {}
AceAces.ModPath = ModPath
dofile(AceAces.ModPath.."Base.lua")

Hooks:PostHook(MultiProfileManager, "set_current_profile", "AA_NewSkillTreeGui_RefreshAfterChangeProfile", function(self)
	AceAces:Skill_Apply()
end)