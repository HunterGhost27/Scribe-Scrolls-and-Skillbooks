--  ======== AUX FUNCTIONS  ==========
Ext.Require("Functions/Auxiliary.lua")
--  ==================================

--  ===============
--  MOD INFORMATION
--  ===============

local modInfoTable = {
    ["Author"] = MODINFO.Author,
    ["Name"] = MODINFO.Name,
    ["UUID"] = MODINFO.UUID,
    ["Version"] = MODINFO.Version,
    ["PublishedVersion"] = MODINFO.PublishVersion,
    ["ModVersion"] = "0.0.0.0",
    ["ModSettings"] = {
        ["LegacyCompatibilityMode"] = true,
        ["RecipeGeneration"] = false
    }
}

CENTRAL = LoadFile("S7Central.json") or {} --  Holds Global Settings and Information
if CENTRAL[IDENTIFIER] == nil then CENTRAL[IDENTIFIER] = Rematerialize(modInfoTable) end

--  =========  UPDATER  =========
Ext.Require("Shared/Updater.lua")
--  =============================

--- Initialize CENTRAL
---@param ref table Reference table
---@param tar table Target table
local function initCENTRAL(ref, tar)
    for field, value in pairs(ref) do
        if type(value) == 'table' then initCENTRAL(value, tar[field]) end
        if MODINFO[field] then tar[field] = Rematerialize(MODINFO[field])
        else if not tar[field] then tar[field] = Rematerialize(value) end end
    end
end

initCENTRAL(modInfoTable, CENTRAL[IDENTIFIER])
CENTRAL[IDENTIFIER]["ModVersion"] = ParseVersion(MODINFO.Version, "string")
SaveFile("S7Central.json", CENTRAL)

--  ================================
--  DETERMINE APPROPRIATE SKILLBOOK
--  ================================

function DetermineSkillbook(stat) --  Determine the school and tier of blank skillbook required
    local tier = "Blank_Step2_A" --   Tier 2 by default

    local school = "WarriorRogueRanger" --  Generic blank skillbook by default

    local iterSchool = {
        --  Valid Schools (except WarriorRogueRanger)
        "Air",
        "Water",
        "Fire",
        "Earth",
        "Polymorph",
        "Necromancy",
        "Summoning"
    }

    if stat.ObjectCategory ~= nil then --  if ObjectCategory exists
        if string.match(stat.ObjectCategory, "Starter") or string.match(stat.ObjectCategory, "Early") then
            tier = "Blank_A" --  If Object Category is Starter or Early then set Tier 1
        end

        for _, element in pairs(iterSchool) do
            if string.match(stat.Name, element) or string.match(stat.ObjectCategory, element) then
                school = element --   Get School name
            end
        end
    end

    if school == "WarriorRogueRanger" then
        tier = "Blank_A" -- As there is no tier 2 for Generic Blank Skillbooks reset tier to 1
    end

    return "BOOK_Skill_" .. school .. "_" .. tier --  Return Skillbook
end


--  ====
--  VARS
--  ====

TotalCount = 0 -- Variable to track the number of recipes created.
InkpotNQuillTemplate = "7c9e8ca5-de93-4e43-be83-2cb6a9022c2f"