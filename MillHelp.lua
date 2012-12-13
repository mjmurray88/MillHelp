--[[
MillHelp.lua
Author: Michael Joseph Murray aka Lyte of Lothar(US)
$Revision: 134 $
$Date: 2012-11-12 23:03:07 -0600 (Mon, 12 Nov 2012) $
@project-version@
contact: codemaster2010 AT gmail DOT com

Copyright (c) 2007-2012 Michael J. Murray aka Lyte of Lothar(US)
All rights reserved unless otherwise explicitly stated.
]]

local strformat = string.format
local strfind = string.find
local strsplit = strsplit

--localization
local L = {}
local LOCALE = GetLocale()

if LOCALE == "esES" then
--@localization(locale="esES", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="core")@
--@localization(locale="esES", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
elseif LOCALE == "esMX" then
--@localization(locale="esMX", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="core")@
--@localization(locale="esMX", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
elseif LOCALE == "deDE" then
--@localization(locale="deDE", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="core")@
--@localization(locale="deDE", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
elseif LOCALE == "ruRU" then
--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="core")@
--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
elseif LOCALE == "frFR" then
--@localization(locale="frFR", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="core")@
--@localization(locale="frFR", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
elseif LOCALE == "koKR" then
--@localization(locale="koKR", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="core")@
--@localization(locale="koKR", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
elseif LOCALE == "zhCN" then
--@localization(locale="zhCN", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="core")@
--@localization(locale="zhCN", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
elseif LOCALE == "zhTW" then
--@localization(locale="zhTW", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="core")@
--@localization(locale="zhTW", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
elseif LOCALE == "ptBR" then
--@localization(locale="ptBR", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="core")@
--@localization(locale="ptBR", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
elseif LOCALE == "itIT" then
--@localization(locale="itIT", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="core")@
--@localization(locale="itIT", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
else
--@localization(locale="enUS", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="core")@
--@localization(locale="enUS", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
end

--a table of herb itemIDs to common pigment itemIDs
local commonPigments = {
	["2449"] = 39151, --alabaster
	["2447"] = 39151,
	["765"] = 39151,
	["785"] = 39334, --dusky
	["2450"] = 39334,
	["3820"] = 39334,
	["2452"] = 39334,
	["2453"] = 39334,
	["3357"] = 39338, --golden
	["3356"] = 39338,
	["3355"] = 39338,
	["3369"] = 39338,
	["3358"] = 39339, --emerald
	["3821"] = 39339,
	["3819"] = 39339,
	["3818"] = 39339,
	["4625"] = 39340, --violet
	["8831"] = 39340,
	["8836"] = 39340,
	["8838"] = 39340,
	["8839"] = 39340,
	["8845"] = 39340,
	["8846"] = 39340,
	["13464"] = 39341, --silvery
	["13463"] = 39341,
	["13465"] = 39341,
	["13466"] = 39341,
	["13467"] = 39341,
	["22787"] = 39342, --nether
	["22790"] = 39342,
	["22789"] = 39342,
	["22792"] = 39342,
	["22791"] = 39342,
	["22785"] = 39342,
	["22793"] = 39342,
	["22786"] = 39342,
	["36906"] = 39343, --azure
	["36905"] = 39343,
	["36901"] = 39343,
	["37921"] = 39343,
	["36904"] = 39343,
	["36903"] = 39343,
	["36907"] = 39343,
	["39970"] = 39343,
	["52983"] = 61979, --ashen
	["52986"] = 61979,
	["52987"] = 61979,
	["52985"] = 61979,
	["52984"] = 61979,
	["52988"] = 61979,
	["72237"] = 79251, --shadow
	["72234"] = 79251,
	["72235"] = 79251,
	["79010"] = 79251,
	["79011"] = 79251,
	["89639"] = 79251,
}

--a table of herb itemIDs to rare pigment itemIDs
local rarePigments = {
	["3356"] = 43104, --burnt
	["3357"] = 43104,
	["3369"] = 43104,
	["3355"] = 43104,
	["785"] = 43103, --verdant
	["2450"] = 43103,
	["2452"] = 43103,
	["2453"] = 43103,
	["3820"] = 43103,
	["13466"] = 43107, --sapphire
	["13465"] = 43107,
	["13467"] = 43107,
	["13464"] = 43107,
	["13463"] = 43107,
	["4625"] = 43106, --ruby
	["8831"] = 43106,
	["8836"] = 43106,
	["8838"] = 43106,
	["8839"] = 43106,
	["8845"] = 43106,
	["8846"] = 43106,
	["22791"] = 43108, --ebon
	["22793"] = 43108,
	["22792"] = 43108,
	["22790"] = 43108,
	["22789"] = 43108,
	["22786"] = 43108,
	["22785"] = 43108,
	["22787"] = 43108,
	["36903"] = 43109, --icy
	["36905"] = 43109,
	["36906"] = 43109,
	["36901"] = 43109,
	["37921"] = 43109,
	["36904"] = 43109,
	["36907"] = 43109,
	["39970"] = 43109,
	["3358"] = 43105, --indigo
	["3821"] = 43105,
	["3819"] = 43105,
	["3818"] = 43105,
	["52983"] = 61980, --burning embers
	["52986"] = 61980,
	["52987"] = 61980,
	["52985"] = 61980,
	["52984"] = 61980,
	["52988"] = 61980,
	["72237"] = 79253, --misty
	["72234"] = 79253,
	["72235"] = 79253,
	["79010"] = 79253,
	["79011"] = 79253,
	["89639"] = 79253,
}

--a table of ink itemIDs to herb sets
local inkTable = {
	["37101"] = L["tier1"], --ivory ink (alabaster pigment)
	["39469"] = L["tier1"], --moonglow ink (alabaster pigment)
	["39774"] = L["tier2"], --midnight ink (dusky pigment)
	["43115"] = L["tier2"], --hunter's ink (verdant pigment)
	["43116"] = L["tier3"], --lion's ink (golden pigment)
	["43117"] = L["tier3"], --dawnstar ink (burnt pigment)
	["43118"] = L["tier4"], --jadefire ink (emerald pigment)
	["43119"] = L["tier4"], --royal ink (indigo pigment)
	["43120"] = L["tier5"], --celestial ink (violet pigment)
	["43121"] = L["tier5"], --fiery ink (Ruby Pigment)
	["43122"] = L["tier6"], --shimmering ink (silvery pigment)
	["43123"] = L["tier6"], --ink of the sky (Saphire Pigment)
	["43124"] = L["Outlands Herbs"], --ethereal ink (nether pigment)
	["43125"] = L["Outlands Herbs"], --darkflame ink (ebon pigment)
	["43126"] = L["Northrend Herbs"], --ink of the sea (azure pigment)
	["43127"] = L["Northrend Herbs"], -- snowfall ink (icy pigment)
	["61978"] = L["tier9"], -- blackfallow ink (ashen pigment)
	["61981"] = L["tier9"], --inferno ink (burning embers)
	["79254"] = L["tier10"], --ink of dreams (shadow pigment)
	["79255"] = L["tier10"], --starlight ink (misty pigment)
}

local inksToPigments = {
	["37101"] = 39151, --ivory ink (alabaster pigment)
	["39469"] = 39151, --moonglow ink (alabaster pigment)
	["39774"] = 39334, --midnight ink (dusky pigment)
	["43115"] = 43103, --hunter's ink (verdant pigment)
	["43116"] = 39338, --lion's ink (golden pigment)
	["43117"] = 43104, --dawnstar ink (burnt pigment)
	["43118"] = 39339, --jadefire ink (emerald pigment)
	["43119"] = 43105, --royal ink (indigo pigment)
	["43120"] = 39340, --celestial ink (violet pigment)
	["43121"] = 43106, --fiery ink (Ruby Pigment)
	["43122"] = 39341, --shimmering ink (silvery pigment)
	["43123"] = 43107, --ink of the sky (Saphire Pigment)
	["43124"] = 39342, --ethereal ink (nether pigment)
	["43125"] = 43108, --darkflame ink (ebon pigment)
	["43126"] = 39343, --ink of the sea (azure pigment)
	["43127"] = 43109, -- snowfall ink (icy pigment)
	["61978"] = 61979, -- blackfallow ink (ashen pigment)
	["61981"] = 61980, -- inferno ink (burning embers)
	["79254"] = 79251, --ink of dreams (shadow pigment)
	["79255"] = 79253, --starlight ink (misty pigment)
}

local pigmentsToInks = {
	["39151"] = 37101, --ivory ink (alabaster pigment)
	["39151"] = 39469, --moonglow ink (alabaster pigment)
	["39334"] = 39774, --midnight ink (dusky pigment)
	["43103"] = 43115, --hunter's ink (verdant pigment)
	["39338"] = 43116, --lion's ink (golden pigment)
	["43104"] = 43117, --dawnstar ink (burnt pigment)
	["39339"] = 43118, --jadefire ink (emerald pigment)
	["43105"] = 43119, --royal ink (indigo pigment)
	["39340"] = 43120, --celestial ink (violet pigment)
	["43106"] = 43121, --fiery ink (Ruby Pigment)
	["39341"] = 43122, --shimmering ink (silvery pigment)
	["43107"] = 43123, --ink of the sky (Saphire Pigment)
	["39342"] = 43124, --ethereal ink (nether pigment)
	["43108"] = 43125, --darkflame ink (ebon pigment)
	["39343"] = 43126, --ink of the sea (azure pigment)
	["43109"] = 43127, -- snowfall ink (icy pigment)
	["61979"] = 61978, --blackfallow ink (ashen pigment)
	["61980"] = 61981, --inferno ink (burning embers)
	["79251"] = 79254, --ink of dreams (shadow pigment)
	["79253"] = 79255, --starlight ink (misty pigment)
}

local getInscriptionInfo = setmetatable({}, {
	__index = function(t, k)
		local herbset = inkTable[k]
		local cPigment = commonPigments[k]
		local rPigment = rarePigments[k]
		local n1, n2, n3, n4
		
		--if herbset is not nil then the itemID belongs to an ink
		--and that means we need to add the needed pigment
		if herbset then
			local pigment = inksToPigments[k]
			n1 = GetItemInfo(pigment)
			--make sure the item returned a name, errors scare users
			if n1 == nil then
				t[k] = L["Updating Item Cache"]
				return t[k]
			end
			t[k] = strformat("|cffffffff%s\n%s|r", n1, herbset)
		end
		--if rPigment is not nil then the itemID belongs to an herb with a rare pigment result
		--this automatically means that cPigment is not nil as well
		--we add a line to the tooltip for both pigments and a line for the two inks
		if rPigment then
			local cInk = pigmentsToInks[tostring(cPigment)]
			local rInk = pigmentsToInks[tostring(rPigment)]
			--make sure the item returned a name, errors scare users
			n1, n2, n3, n4 = GetItemInfo(cPigment), GetItemInfo(cInk), GetItemInfo(rPigment), GetItemInfo(rInk)
			if n1 == nil or n2 == nil or n3 == nil or n4 == nil then
				t[k] = L["Updating Item Cache"]
				return t[k]
			end
			t[k] = strformat("|cffffffff%s (%s)|r\n|cff1eff00%s (%s)|r", n1, n2, n3, n4)
		--if rPigment is nil but cPigment is not nil
		--then the itemID is for a herb that makes the first two inks
		--so we just add the pigment to the tool tip and those two inks
		elseif cPigment then
			--make sure the item returned a name, errors scare users
			n1, n2, n3 = GetItemInfo(cPigment), GetItemInfo(37101), GetItemInfo(39469)
			if n1 == nil or n2 == nil or n3 == nil then
				t[k] = L["Updating Item Cache"]
				return t[k]
			end
			t[k] = strformat("|cffffffff%s\n(%s, %s)|r", n1, n2, n3)
		end
		
		return t[k]
	end
})

local _, ns = ...
function ns:ClearCachedTooltips()
	for k in pairs(getInscriptionInfo) do
		getInscriptionInfo[k] = nil
	end
end

local function AddMillingInfo(frame, itemLink)
	local _, _, itemString = strfind(itemLink, "^|c%x+|H(.+)|h%[.+%]")
	if itemString then
		local _, itemID = strsplit(":", itemString)
		if itemID then
			if inkTable[itemID] or rarePigments[itemID] or commonPigments[itemID] then
				if MILLHELP_HEADER then
					frame:AddLine(strformat("|cffffffff%s|r", L["Milling:"]))
				end
				frame:AddLine(getInscriptionInfo[itemID])
			end
		end
	end
	
	frame:Show()
end

local function HookIt(tt)
	tt:HookScript("OnTooltipSetItem", function(self, ...)
		local itemLink = select(2, self:GetItem())
		if itemLink and GetItemInfo(itemLink) then
			AddMillingInfo(self, itemLink)
		end
	end)
end

HookIt(GameTooltip)
HookIt(ItemRefTooltip)
