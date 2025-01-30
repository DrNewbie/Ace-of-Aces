_G.AceAces = _G.AceAces or {}
AceAces.Settings = AceAces.Settings or {}

function AceAces:Reload_Gui(them, item)
	self:Save()
	self:Skill_Apply()
	
	local panel = item:panel()
	SimpleGUIEffectSpewer.infamous_up(panel:world_center_x(), panel:world_center_y(), them._fullscreen_panel)
	them:on_notify(item:tree(), {label = "refresh"})
	managers.menu_component:post_event("menu_skill_investment")
	them:update_item()
	them:reload_connections()
	WalletGuiObject.refresh()
	them:refresh_reset_skills_legends(them._selected_page:trees_idx())
	
	MenuCallbackHandler:_update_outfit_information()
end

function AceAces:Yes(them, item)
	local skill_id = item:skill_id()
	local tree = item:tree()
	local tier = item:tier()
	local step = them._skilltree:next_skill_step(skill_id)
	local skill_data = tweak_data.skilltree.skills[skill_id]
	if not self.Skill_Tweak[skill_id] then
		QuickMenu:new("[Ace of Aces]", "'"..managers.localization:text(skill_data.name_id) .."' is not allowed to be 'Ace of Aces'", {{text = managers.localization:text("menu_back"), is_cancel_button = true}}, true)
		return
	end
	local profile = self:GetCurrentSet()
	self.Settings[profile] = self.Settings[profile] or {}
	self.Settings[profile]["ID_"..tier] = {skill_id = skill_id, tree = tree, tier = tier, step = step}
	--No more popping, 2025-01-30
		--QuickMenu:new("[Ace of Aces]", "'"..managers.localization:text(skill_data.name_id) .."' is 'Ace of Aces' now", {{text = managers.localization:text("menu_back"), is_cancel_button = true}}, true)
	self:Reload_Gui(them, item)
end

function AceAces:No(them, item)
	local skill_id = item:skill_id()
	local profile = self:GetCurrentSet()
	self.Settings[profile] = self.Settings[profile] or {}
	local tier = "ID_"..item:tier()
	local skill_data = tweak_data.skilltree.skills[skill_id]
	if self.Settings[profile][tier] and tostring(self.Settings[profile][tier].skill_id) == skill_id then
		self.Settings[profile][tier] = {"None"}
		--No more popping, 2025-01-30
			--QuickMenu:new("[Ace of Aces]", "'"..managers.localization:text(skill_data.name_id) .."' is not 'Ace of Aces' anymore", {{text = managers.localization:text("menu_back"), is_cancel_button = true}}, true)
		self:Reload_Gui(them, item)
	end
end

function NewSkillTreeSkillItem:AAMaxedIconSetVisible(status)
	if alive(self._skill_panel) then
		local skill_id = self._skill_id
		if skill_id then
			local skill_icon_panel = self._skill_panel:child("SkillIconPanel")
			if skill_icon_panel then
				local aceaces_maxed_indicator = skill_icon_panel:child("AceacesMaxedIndicator")
				local maxed_indicator = skill_icon_panel:child("MaxedIndicator")
				if maxed_indicator and managers.skilltree:skill_completed(skill_id) then
					maxed_indicator:set_visible(not status)
				end
				if aceaces_maxed_indicator then
					aceaces_maxed_indicator:set_visible(status)
					if not managers.skilltree:skill_completed(skill_id) or not managers.skilltree:skill_unlocked(nil, skill_id) then
						aceaces_maxed_indicator:set_visible(false)
					end
				end
			end
		end
	end
end

Hooks:PostHook(NewSkillTreeSkillItem, "init", "AA_NewSkillTreeGui_Init", function(self)
	if alive(self._skill_panel) then
		local skill_id = self._skill_id
		if skill_id then
			local skill_icon_panel = self._skill_panel:child("SkillIconPanel")
			if skill_icon_panel then
				local aceaces_maxed_indicator = skill_icon_panel:bitmap({
					texture = "guis/textures/pd2/skilltree_2/aceaces_symbol",
					name = "AceacesMaxedIndicator",
					blend_mode = "add",
					color = tweak_data.screen_colors.button_stage_2
				})
				aceaces_maxed_indicator:set_size(skill_icon_panel:w() * 1.8, skill_icon_panel:h() * 1.8)
				aceaces_maxed_indicator:set_center(skill_icon_panel:w() / 2, skill_icon_panel:h() / 2)
				self:AAMaxedIconSetVisible(AceAces:Skill_in_AA(skill_id))
			end
		end
	end
end)

Hooks:PostHook(NewSkillTreeSkillItem, "refresh", "AA_NewSkillTreeGui_Refresh", function(self)
	self:AAMaxedIconSetVisible(AceAces:Skill_in_AA(self._skill_id))
end)

Hooks:PreHook(NewSkillTreeGui, "invest_point", "AAClickEvent", function(self, item)
	local skill_id = item:skill_id()
	local step = self._skilltree:next_skill_step(skill_id)
	local unlocked = self._skilltree:skill_unlocked(nil, skill_id)
	local completed = self._skilltree:skill_completed(skill_id)
	local skill_data = tweak_data.skilltree.skills[skill_id]
	if not unlocked then
		return
	end
	if completed and AceAces.Skill_Tweak[skill_id] then
		--No more asking, 2025-01-30
		--[[
			local menu_message = "Do you want to upgrade '"..managers.localization:text(skill_data.name_id).."' to 'Ace of Aces'?"
			local menu_options = {}
			table.insert(menu_options,
				{
					text = managers.localization:text("dialog_yes"),
					callback = function ()
						AceAces:Yes(self, item)
						self:_update_description(item)
						item:flash()
					end
				}
			)
			table.insert(menu_options,
				{
					text = managers.localization:text("dialog_no"),
					callback = function ()
						AceAces:No(self, item)
						self:_update_description(item)
					end
				}
			)
			table.insert(menu_options,
				{
					text = managers.localization:text("menu_back"),
					is_cancel_button = true
				}
			)
			QuickMenu:new("[Ace of Aces]", menu_message, menu_options, true)
		]]
		if AceAces:Skill_in_AA(skill_id) then
			AceAces:No(self, item)
		else
			AceAces:Yes(self, item)
		end
		self:_update_description(item)
		item:flash()
		return
	end
end)

Hooks:PostHook(NewSkillTreeGui, "_update_description", "AADoDescUpdate", function(self, item)
	local skill_id = item:skill_id()
	local status = AceAces:Skill_in_AA(skill_id)
	if AceAces.Skill_Tweak[skill_id] then
		self:AAUpdateDescription(item)
	end
	item:AAMaxedIconSetVisible(status)
end)

local small_font_size = tweak_data.menu.pd2_small_font_size

function NewSkillTreeGui:AAUpdateDescription(item)
	local desc_panel = self._panel:child("InfoRootPanel"):child("DescriptionPanel")
	local text = desc_panel:child("DescriptionText")
	local tier = item:tier()
	local skill_id = item:skill_id()
	local tweak_data_skill = tweak_data.skilltree.skills[skill_id]
	local skill_stat_color = tweak_data.screen_colors.resource
	local color_replace_table = {}
	local points = self._skilltree:points() or 0
	local basic_cost = self._skilltree:get_skill_points(skill_id, 1) or 0
	local pro_cost = self._skilltree:get_skill_points(skill_id, 2) or 0
	local talent = tweak_data.skilltree.skills[skill_id]
	local unlocked = self._skilltree:skill_unlocked(nil, skill_id)
	local step = self._skilltree:next_skill_step(skill_id)
	local completed = self._skilltree:skill_completed(skill_id)
	local skill_descs = tweak_data.upgrades.skill_descs[skill_id] or {
		0,
		0
	}
	local basic_color_index = 1
	local pro_color_index = 2 + (skill_descs[1] or 0)

	if step > 1 then
		basic_cost = utf8.to_upper(managers.localization:text("st_menu_skill_owned"))
		color_replace_table[basic_color_index] = tweak_data.screen_colors.resource
	else
		basic_cost = managers.localization:text(basic_cost == 1 and "st_menu_point" or "st_menu_point_plural", {points = basic_cost})
	end

	if step > 2 then
		pro_cost = utf8.to_upper(managers.localization:text("st_menu_skill_owned"))
		color_replace_table[pro_color_index] = tweak_data.screen_colors.resource
	else
		pro_cost = managers.localization:text(pro_cost == 1 and "st_menu_point" or "st_menu_point_plural", {points = pro_cost})
	end

	local macroes = {
		basic = basic_cost,
		pro = pro_cost
	}

	for i, d in pairs(skill_descs) do
		macroes[i] = d
	end

	local skill_btns = tweak_data.upgrades.skill_btns[skill_id]

	if skill_btns then
		for i, d in pairs(skill_btns) do
			macroes[i] = d()
		end
	end

	local basic_cost = managers.skilltree:skill_cost(tier, 1)
	local aced_cost = managers.skilltree:skill_cost(tier, 2)
	local skill_string = managers.localization:to_upper_text(tweak_data_skill.name_id)
	local cost_string = managers.localization:to_upper_text(basic_cost == 1 and "st_menu_skill_cost_singular" or "st_menu_skill_cost", {
		basic = basic_cost,
		aced = aced_cost
	})
	local desc_string = managers.localization:text(tweak_data.skilltree.skills[skill_id].desc_id, macroes)
	local full_string = skill_string .. "\n\n" .. desc_string .. "\n\n" .. managers.localization:to_upper_text("aceaces_own") .. "\n" .. managers.localization:text("aceaces_"..skill_id)
	
	text:set_text(full_string)
	managers.menu_component:make_color_text(text)

	local _, _, _, h = text:text_rect()

	if desc_panel:h() - text:top() < h then
		text:set_font_size(small_font_size * 0.95)
	else
		text:set_font_size(small_font_size)
	end
end