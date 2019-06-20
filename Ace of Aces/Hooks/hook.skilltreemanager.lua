_G.AceAces = _G.AceAces or {}

Hooks:PreHook(SkillTreeManager, "infamy_reset", "AceAces_ResetAA_After_infamy_reset", function(self)
	os.remove(AceAces.SavePath)
	AceAces:Skill_Apply()
end)