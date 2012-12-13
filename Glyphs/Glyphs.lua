--[[
MillHelp
Author: Michael Joseph Murray aka Lyte of Lothar(US)
$Revision: 138 $
$Date: 2012-11-29 12:40:10 -0600 (Thu, 29 Nov 2012) $
@project-version@
contact: codemaster2010 AT gmail DOT com

Copyright (c) 2007-2012 Michael J. Murray aka Lyte of Lothar(US)
All rights reserved unless otherwise explicitly stated.
]]

local INK_PER_GLYPH = 3
local PIGMENT_PER_INK = 2

local strformat = string.format
local strfind = string.find
local strsplit = strsplit

--localization
local L = {}
local LOCALE = GetLocale()

if LOCALE == "esES" then
--@localization(locale="esES", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
elseif LOCALE == "esMX" then
--@localization(locale="esMX", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
elseif LOCALE == "deDE" then
--@localization(locale="deDE", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
elseif LOCALE == "ruRU" then
--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
elseif LOCALE == "frFR" then
--@localization(locale="frFR", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
elseif LOCALE == "koKR" then
--@localization(locale="koKR", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
elseif LOCALE == "zhCN" then
--@localization(locale="zhCN", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
elseif LOCALE == "zhTW" then
--@localization(locale="zhTW", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
elseif LOCALE == "ptBR" then
--@localization(locale="ptBR", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
elseif LOCALE == "itIT" then
--@localization(locale="itIT", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
else
--@localization(locale="enUS", format="lua_additive_table", handle-unlocalized="english", table-name="\tL", namespace="shared")@
end

local fmtstring = "|cffffffff%s x%d (%s x%d)|r"

--glyphTable is a mapping of Glyph itemIDs to ink itemIDs
local glyphTable = {
	--    Death Knight    --
	--Major
	["43533"] = "43126", --Anti-magic shell
	["43534"] = "43126", --unholy frenzy
	["43536"] = "43122", --icebound fortitude
	["43537"] = "43126", --chains of ice
	["43541"] = "43122", --death grip
	["43542"] = "43126", --death and decay
	["43543"] = "43122", --shifting presences
	["43546"] = "43122", --icy touch
	["43547"] = "43126", --enduring infection
	["43548"] = "43124", --pestilence
	["43549"] = "43124", --mind freeze
	["43552"] = "43126", --strangulate
	["43553"] = "43124", --pillar of frost
	["43554"] = "43124", --vampiric blood
	["43825"] = "43124", --unholy command
	["43826"] = "43124", --outbreak
	["45799"] = "43124", --dancing rune weapon
	["45800"] = "43124", --dark simulacrum
	["45804"] = "43122", --death coil
	["68793"] = "43122", --dark succor
	--Minor
	["43535"] = "43124", --geist
	["43539"] = "43124", --death's embrace
	["43544"] = "43124", --horn of winter
	["43550"] = "43126", --army of the dead
	["43551"] = "43124", --foul menagerie
	["43671"] = "43124", --path of frost
	["43672"] = "43124", --resilient grip
	["43673"] = "43124", --death gate
	["43827"] = "43124", --corpse explosion
	["45806"] = "43124", --tranquil grip
	--    Druid    --
	--Major
	["40896"] = "43124", --frenzied regen
	["40897"] = "39774", --maul
	["40899"] = "43126", --solar beam
	["40901"] = "43122", --shred
	["40902"] = "43120", --prowl
	["40903"] = "43124", --pounce
	["40906"] = "43126", --stampede
	["40908"] = "43126", --innervate
	["40909"] = "43118", --rebirth
	["40912"] = "43126", --regrowth
	["40913"] = "39774", --rejuvenation
	["40914"] = "43116", --healing touch
	["40915"] = "43126", --lifebloom
	["40916"] = "43120", --moonbeast
	["40920"] = "43126", --hurricane
	["40921"] = "43126", --skull bash
	["40922"] = "39774", --nature's grasp
	["40923"] = "43116", --savagery
	["40924"] = "43116", --entangling roots
	["43331"] = "43116", --blooming
	["43674"] = "43118", --dash
	["44928"] = "43126", --master shapeshifter
	["45601"] = "43124", --survival instincts
	["45602"] = "43124", --wild growth
	["45603"] = "43126", --might of ursoc
	["45604"] = "43126", --stampeding roar
	["45622"] = "43122", --cyclone
	["45623"] = "43120", --barkskin
	["48720"] = "39774", --feroucious bite
	["67484"] = "43124", --fae silence
	["67485"] = "43116", --faerie fire
	["67487"] = "43116", --cat form
	--Minor
	["40900"] = "43126", --stag
	["40919"] = "43118", --orca
	["43316"] = "43116", --aquatic form
	["43332"] = "39774", --grace
	["43334"] = "43118", --chameleon
	["43335"] = "39774", --charm woodland creature
	["44922"] = "43126", --stars
	["67486"] = "43118", --predator
	["68039"] = "43118", --treant
	["89868"] = "43118", --cheetah
	--    Hunter    --
	--Major
	["42898"] = "43116", --camouflage
	["42899"] = "43126", --marked for death
	["42900"] = "43116", --mending
	["42901"] = "43126", --distracting shot
	["42902"] = "43126", --endless wrath
	["42903"] = "43120", --deterrence
	["42904"] = "43120", --disengage
	["42905"] = "43122", --freezing trap
	["42906"] = "43124", --ice trap
	["42907"] = "39774", --misdirection
	["42908"] = "43116", --explosive trap
	["42909"] = "43126", --animal bond
	["42910"] = "43118", --no escape
	["42911"] = "43124", --pathfinding
	["42913"] = "43126", --snake trap
	["42914"] = "43126", --aimed shot
	["42915"] = "43126", --mend pet
	["42917"] = "43126", --solace
	["45625"] = "43124", --chimera shot
	["45731"] = "43124", --tranq shot
	["45733"] = "43118", --master's call
	["45734"] = "43116", --scatter shot
	["45735"] = "39774", --mirrored blades
	["85684"] = "79254", --black ice
	--Minor
	["42897"] = "43118", --aspects
	["42912"] = "39774", --tame beast
	["43338"] = "39774", --revive pet
	["43350"] = "39774", --lesser proportion
	["43351"] = "43118", --fireworks
	["43355"] = "43120", --aspect of the pack
	["43356"] = "39774", --stampede
	["45732"] = "43126", --aspect of the cheetah
	["85683"] = "43126", --aspect of the beast
	["87278"] = "79254", --direction
	["87279"] = "79254", --marking
	["87393"] = "43116", --fetch
	--    Mage    --
	--Major
	["42736"] = "43124", --arcane explosion
	["42737"] = "43116", --blink
	["42738"] = "43118", --evocation
	["42739"] = "43126", --combustion
	["42741"] = "39774", --frost nova
	["42744"] = "43120", --ice block
	["42745"] = "43126", --ice lance
	["42746"] = "43118", --cone of cold
	["42748"] = "43126", --invisibility
	["42749"] = "43124", --mana gem
	["42752"] = "43126", --polymorph
	["42753"] = "43126", --icy veins
	["42754"] = "43126", --spellsteal
	["44684"] = "43126", --frostfire bolt
	["44920"] = "43126", --remove curse
	["44955"] = "43124", --arcane power
	["45736"] = "43124", --water elemental
	["45737"] = "43124", --slow
	["45740"] = "43120", --deep freeze
	["50045"] = "43122", --counterspell
	["63539"] = "43126", --fire blast
	["69773"] = "43126", --armors
	--Minor
	["42735"] = "43116", --loose mana
	["42743"] = "39774", --momentum
	["42751"] = "43126", --crittermorph
	["43339"] = "39774", --porcupine
	["43359"] = "39774", --conjure familiar
	["43360"] = "43116", --monkey
	["43361"] = "39774", --penguin
	["43364"] = "39774", --arcane language
	["45738"] = "43124", --illusion
	["45739"] = "43126", --mirror image
	["63416"] = "43118", --rapid teleportation
	["92727"] = "79254", --discreet magic
	--    Monk    --
	--Major
	["82345"] = "79254", --expel harm
	["84652"] = "79254", --transcendence
	["85685"] = "79254", --breath of fire
	["85687"] = "79254", --clash
	["85689"] = "79254", --enduring healing sphere
	["85691"] = "79254", --guard
	["85692"] = "79254", --mana tea
	["85695"] = "43126", --zen meditation
	["85696"] = "43126", --renewing mists
	["85697"] = "43126", --spinning crane kick
	["85699"] = "43126", --surging mist
	["85700"] = "43126", --touch of death
	["87880"] = "43120", --crackling jade lightning
	["87891"] = "43118", --afterlife
	["87892"] = "43126", --fists of fury
	["87893"] = "43122", --fortifying brew
	["87894"] = "43124", --leer of the ox
	["87895"] = "43124", --life cocoon
	["87896"] = "43126", --retreat
	["87897"] = "43126", --path of blossoms
	["87898"] = "43126", --sparring
	["87899"] = "43126", --stoneskin
	["87900"] = "43126", --touch of karma
	["87901"] = "43126", --uplift
	--Minor
	["85698"] = "79254", --spinning fire blossom
	["87881"] = "43126", --cracking tiger lightning
	["87882"] = "43126", --flying serpent kick
	["87883"] = "79254", --honor
	["87884"] = "79254", --jab
	["87885"] = "79254", --rising tiger kick
	["87887"] = "79254", --spirit roll
	["87888"] = "43126", --fighting pose
	["87889"] = "79254", --water roll
	["87890"] = "79254", --zen flight
	["90715"] = "43126", --blackout kick
	--    Paladin    --
	--Major
	["41092"] = "43116", --double jeopardy
	["41094"] = "43124", --rebuke
	["41095"] = "39774", --holy wrath
	["41096"] = "39774", --divine protection
	["41097"] = "43126", --templar's vedict
	["41098"] = "43120", --avenging wrath
	["41099"] = "43120", --consecration
	["41101"] = "43126", --focused shield
	["41102"] = "43126", --turn evil
	["41103"] = "43122", --blinding light
	["41104"] = "43118", --final wrath
	["41105"] = "43124", --word of glory
	["41106"] = "43116", --illumination
	["41107"] = "43126", --harsh words
	["41108"] = "43116", --divinity
	["41109"] = "43126", --light of dawn
	["41110"] = "43126", --blessed life
	["43367"] = "39774", --flash of light
	["43867"] = "43126", --denounce
	["43868"] = "43126", --dazing shield
	["43869"] = "43126", --immediate truth
	["45741"] = "43124", --beacon of light
	["45742"] = "43124", --hammer of the righteous
	["45743"] = "43124", --divine storm
	["45744"] = "43126", --alabaster shield
	["45745"] = "43126", --divine plea
	["45746"] = "43120", --holy shock
	["45747"] = "43116", --inquisition
	["66918"] = "43126", --protector of the innocent
	["81959"] = "79254", --battle healer
	["83107"] = "79254", --mass exorcism
	--Minor
	["41100"] = "43118", --luminous charger
	["43340"] = "39774", --mounted king
	["43365"] = "43116", --contemplation
	["43366"] = "39774", --winged vengeance
	["43368"] = "43116", --seal of blood
	["43369"] = "43118", --fire from the heavens
	["80584"] = "79254", --falling avenger
	["80585"] = "79254", --righteous retreat
	["80586"] = "79254", --bladed judgment
	--    Priest    --
	--Major
	["42396"] = "43126", --circle of healing
	["42397"] = "43120", --purify
	["42398"] = "43116", --fade
	["42399"] = "43122", --fear ward
	["42400"] = "43116", --inner sanctum
	["42401"] = "43124", --holy nova
	["42402"] = "43116", --inner fire
	["42403"] = "43126", --lightwell
	["42404"] = "43126", --mass dispel
	["42405"] = "43126", --psychic horror
	["42406"] = "43124", --holy fire
	["42407"] = "43126", --inner focus
	["42408"] = "39774", --power word: shield
	["42409"] = "43126", --spirit of redemption
	["42410"] = "39774", --psychic scream
	["42411"] = "43118", --renew
	["42412"] = "43126", --scourge imprisonment
	["42414"] = "43126", --mind blast
	["42415"] = "43118", --dispel magic
	["42416"] = "43120", --smite
	["42417"] = "43126", --prayer of mending
	["43370"] = "43118", --levitate
	["43372"] = "43118", --reflective shield
	["45753"] = "43124", --dispersion
	["45755"] = "43124", --leap of faith
	["45756"] = "43124", --penance
	["45757"] = "43126", --dark binding
	["45758"] = "43124", --mind spike
	["45760"] = "43122", --desperation
	["87902"] = "43122", --lightspring
	["79513"] = "43120", --mind flay
	["79514"] = "79254", --shadow word: death
	["79515"] = "79254", --vampiric embrace
	--Minor
	["43342"] = "39774", --shadow ravens
	["43371"] = "39774", --borrowed time
	["43373"] = "43116", --shackle undead
	["43374"] = "43126", --dark archangel
	["77101"] = "43116", --shadow
	["86541"] = "79254", --confession
	["87276"] = "79254", --holy ressurection
	["87277"] = "79254", --val'kyr
	["87392"] = "79254", --shadowy friends
	["79538"] = "79254", --heavens
	--    Rogue    --
	--Major
	["42954"] = "43126", --shadow walk
	["42955"] = "43124", --ambush
	["42957"] = "43126", --blade flurry
	["42958"] = "43126", --crippling poison
	["42959"] = "43126", --recuperate
	["42960"] = "39774", --evasion
	["42961"] = "43116", --debilitation
	["42962"] = "43116", --expose armor
	["42963"] = "43124", --feint
	["42964"] = "43116", --garrote
	["42966"] = "43118", --gouge
	["42968"] = "43126", --smoke bomb
	["42969"] = "43126", --cheap shot
	["42970"] = "43118", --sap
	["42971"] = "43126", --kick
	["42972"] = "43120", --adrenaline rush
	["42973"] = "43120", --shiv
	["42974"] = "43122", --sprint
	["45761"] = "43124", --vendetta
	["45764"] = "43124", --stealth
	["45766"] = "43126", --deadly momentum
	["45769"] = "43124", --cloak of shadows
	["63420"] = "43124", --vanish
	["64493"] = "43118", --blind
	--Minor
	["42956"] = "39774", --decoy
	["42965"] = "43126", --detection
	["42967"] = "43126", --hemorrhage
	["43343"] = "39774", --pick pocket
	["43376"] = "43116", --distract
	["43377"] = "43116", --pick lock
	["43378"] = "43120", --safe fall
	["43379"] = "39774", --blurred speed
	["43380"] = "43116", --poisons
	["45762"] = "43124", --killing spree
	["45767"] = "43126", --tricks of the trade
	["45768"] = "43122", --disguise
	--    Shaman    --
	--Major
	["41517"] = "43126", --unstable earth
	["41518"] = "43126", --chain lightning
	["41524"] = "43126", --spirit walk
	["41526"] = "43126", --capacitor totem
	["41527"] = "43124", --purge
	["41529"] = "43126", --fire elemental totem
	["41530"] = "43116", --fire nova
	["41531"] = "39774", --flame shock
	["41532"] = "43116", --wind shear
	["41533"] = "43120", --healing stream totem
	["41534"] = "43126", --healing wave
	["41535"] = "43120", --totemic recall
	["41536"] = "43116", --telluric currents
	["41538"] = "43126", --grounding totem
	["41539"] = "43126", --spiritwalker's grace
	["41541"] = "43122", --water shield
	["41542"] = "43124", --cleansing waters
	["41547"] = "43118", --frost shock
	["41552"] = "43126", --chaining
	["43344"] = "43116", --healing storm
	["43725"] = "43116", --ghost wolf
	["45770"] = "43124", --thunder
	["45771"] = "43124", --feral spirit
	["45772"] = "43124", --riptide
	["45776"] = "43122", --shamanistic rage
	["45777"] = "43126", --hex
	["45778"] = "39774", --totemic vigor
	["71155"] = "43126", --unleashed lightning
	--Minor
	["41537"] = "39774", --lakestrider
	["41540"] = "43118", --lava lash
	["43381"] = "43118", --astral recall
	["43385"] = "43118", --far sight
	["43386"] = "43116", --spectral wolf
	["43388"] = "43118", --totemic encirclement
	["44923"] = "43126", --thunderstorm
	["45775"] = "43122", --deluge
	--    Warlock    --
	--Major
	["42454"] = "43126", --conflagrate
	["42455"] = "39774", --siphon life
	["42458"] = "43116", --fear
	["42460"] = "43126", --demon training
	["42462"] = "39774", --healthstone
	["42464"] = "43126", --dark soul
	["42465"] = "43116", --imp swarm
	["42466"] = "43120", --soul swap
	["42470"] = "43120", --soulstone
	["42472"] = "43126", --unstable affliction
	["43390"] = "39774", --soul consumption
	["43392"] = "43118", --curse of exhaustion
	["45779"] = "43124", --soul shards
	["45780"] = "43124", --demon hunting
	["45781"] = "43124", --burning embers
	["45782"] = "43126", --demonic circle
	["45783"] = "43126", --shadowflame
	["45785"] = "39774", --life tap
	["50077"] = "43126", --everlasting affliction
	--Minor
	["42453"] = "43124", --hand of gul'dan
	["42456"] = "43126", --verdant spheres
	["42457"] = "43126", --nightmares
	["42459"] = "43126", --felguard
	["42461"] = "43116", --health funnel
	["42463"] = "43126", --subtlety
	["42467"] = "43118", --shadow bolt
	["42471"] = "43124", --carrion swarm
	["42473"] = "43118", --falling meteor
	["43389"] = "43116", --unending breath
	["43391"] = "43116", --eye of kilrogg
	["43393"] = "43118", --enslave demon
	["43394"] = "43126", --soulwell
	["45789"] = "43116", --crimson banish
	["93202"] = "43116", --gateway attunement
	--    Warrior    --
	--Major
	["43397"] = "39774", --long charge
	["43399"] = "39774", --unending rage
	["43413"] = "39774", --enraged speed
	["43414"] = "43120", --hindering strikes
	["43415"] = "43126", --heavy repercussions
	["43416"] = "43122", --bloodthirst
	["43417"] = "43116", --rude interruption
	["43418"] = "39774", --gag order
	["43419"] = "43126", --blitz
	["43421"] = "43126", --mortal strike
	["43422"] = "43118", --overpower
	["43423"] = "43116", --hamstring
	["43424"] = "43118", --hold the line
	["43425"] = "43126", --shield slam
	["43427"] = "43116", --hoarse voice
	["43428"] = "43124", --sweeping strikes
	["43430"] = "43126", --resonating power
	["43431"] = "43126", --victory rush
	["43432"] = "43124", --raging wind
	["45790"] = "43124", --whirlwind
	["45792"] = "43124", --death from above
	["45793"] = "43126", --furious sundering
	["45795"] = "43124", --spell reflection
	["45797"] = "43116", --shield wall
	["63481"] = "61978", --colossus smash
	["67482"] = "43122", --bull rush
	["67483"] = "43118", --recklessness
	["83096"] = "79254", --incite
	--Minor
	["43395"] = "39774", --mystic shout
	["43396"] = "39774", --bloodcurdling shout
	["43398"] = "43116", --gushing wound
	["43400"] = "43124", --mighty victory
	["43412"] = "43126", --bloody healing
	["45794"] = "43126", --intimidating shout
	["49084"] = "43126", --thunder strike
	["80587"] = "79254", --crow feast
	["80588"] = "79254", --burning anger
	["85221"] = "79254", --blazing trail
}

--inkTable is a mapping of Ink itemIDs to pigment itemIDs
local inkTable = {
	["43120"] = "39340", --celestial ink (violet pigment)
	["43124"] = "39342", --ethereal ink (nether pigment)
	["43126"] = "39343", --ink of the sea (azure pigment)
	["43118"] = "39339", --jadefire ink (emerald pigment)
	["43116"] = "39338", --lion's ink (golden pigment)
	["39774"] = "39334", --midnight ink (dusky pigment)
	["43122"] = "39341", --shimmering ink (silvery pigment)
	["61978"] = "61979", --blackfallow ink (ashen pigment)
	["79254"] = "79251", --ink of dreams (shadow pigment)
}

local getGlyphString = setmetatable({}, {
	__index = function(t, k)
		local ink = glyphTable[k]
		local pigment = inkTable[ink]
		
		--convert the itemIDs into localized names via GII
		local pigmentName = GetItemInfo(tonumber(pigment))
		local inkName = GetItemInfo(tonumber(ink))
		
		--make sure the names are actually returned
		if (not inkName) or (not pigmentName) then
			t[k] = L["Updating Item Cache"]
			return t[k]
		end
		
		t[k] = strformat(fmtstring, inkName, INK_PER_GLYPH, pigmentName, PIGMENT_PER_INK*INK_PER_GLYPH)
		return t[k]
	end
})

_G["MillHelp_Glyphs"] = {}
function MillHelp_Glyphs:ClearCachedTooltips()
	for k in pairs(getGlyphString) do
		getGlyphString[k] = nil
	end
end

local function AddGlyphInfo(frame, itemLink)
	local _, _, itemString = strfind(itemLink, "^|c%x+|H(.+)|h%[.+%]")
	if itemString then
		local _, itemID = strsplit(":", itemString)
		if itemID then
			--see if the itemID is a glyph
			if glyphTable[itemID] then
				frame:AddLine(getGlyphString[itemID])
			end
		end
	end
	
	frame:Show()
end

local function HookIt(tt)
	tt:HookScript("OnTooltipSetItem", function(self, ...)
		local itemLink = select(2, self:GetItem())
		if itemLink and GetItemInfo(itemLink) then
			AddGlyphInfo(self, itemLink)
		end
	end)
end

HookIt(GameTooltip)
HookIt(ItemRefTooltip)
