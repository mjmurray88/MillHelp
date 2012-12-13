--[[
MillHelp_Frame.lua
Author: Michael Joseph Murray aka Lyte of Lothar(US)
Please see license.txt for details.
$Revision: 122 $
$Date: 2012-09-25 19:18:47 -0500 (Tue, 25 Sep 2012) $
@project-version@
contact: codemaster2010 AT gmail DOT com

Copyright (c) 2007-2012 Michael J. Murray aka Lyte of Lothar
All rights reserved unless otherwise explicitly stated.
]]

local _, ns = ...

local itemList = {
	"39151", --alabaster
	"39334", --dusky
	"39338", --golden
	"39339", --emerald
	"39340", --violet
	"39341", --silvery
	"39342", --nether
	"39343", --azure
	"43104", --burnt
	"43103", --verdant
	"43107", --sapphire
	"43106", --ruby
	"43108", --ebon
	"43109", --icy
	"43105", --indigo
	"61979", --ashen pigment
	"61980", --burning embers
	"79251", --shadow pigment
	"79253", --misty pigment
	"37101",--ivory ink 
	"39469", --moonglow ink
	"39774", --midnight ink
	"43115", --hunter's ink
	"43116", --lion's ink
	"43117", --dawnstar ink
	"43118", --jadefire ink
	"43119", --royal ink
	"43120", --celestial ink
	"43121", --fiery ink
	"43122", --shimmering ink
	"43123", --ink of the sky
	"43124", --ethereal ink
	"43125", --darkflame ink
	"43126", --ink of the sea
	"43127", -- snowfall ink
	"61978", --blackfallow ink
	"61981", --inferno ink
	"79254", --ink of dreams
	"79255", --starlight ink
}

local frame = CreateFrame("FRAME")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
local tt = CreateFrame("GAMETOOLTIP", "MILLHELP_TOOLTIP", UIParent, "GameTooltipTemplate")
tt:SetOwner(WorldFrame, 'ANCHOR_NONE')

local function serverQuery()
	for i, itemID in ipairs(itemList) do
		--make sure it's owned and hidden
		if not tt:IsOwned(WorldFrame) then
			tt:SetOwner(WorldFrame, 'ANCHOR_NONE')
		end
		
		--query the server for the item
		tt:SetHyperlink("item:"..itemID)
		
		--only run 5 queries at a time
		if i % 5 == 0 then
			coroutine.yield()
		end
	end
end

frame:SetScript("OnEvent", function(self, event)
	--only run this code once
	self:UnregisterEvent(event)
	
	--create the coroutine that performs the queries
	self.thread = coroutine.create(serverQuery)
	
	--periodically resume the coroutine until it finishes
	local lastUpdate = 0
	local throttle = 10
	self:SetScript("OnUpdate", function(self, elapsed)
		lastUpdate = lastUpdate + elapsed
		if lastUpdate >= throttle then
			lastUpdate = 0
			if coroutine.status(self.thread) ~= "dead" then
				coroutine.resume(self.thread)
			else
				self:Hide()
				tt:Hide()
				ns:ClearCachedTooltips()
				if MillHelp_Glyphs then
					MillHelp_Glyphs:ClearCachedTooltips()
				end
			end
		end
	end)
	self:Show()
end)
