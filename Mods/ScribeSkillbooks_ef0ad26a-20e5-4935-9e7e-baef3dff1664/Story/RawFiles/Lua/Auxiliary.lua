----------------------------------------------------------------
--==============================================================

IDENTIFIER = 'S7_Scribe'

---@class MODINFO: ModInfo
---@field ModVersion string
---@field ModSettings table
MODINFO = Ext.GetModInfo('ef0ad26a-20e5-4935-9e7e-baef3dff1664')

DefaultSettings = {
    ['LegacyCompatibilityMode'] = false,
    ['RecipeGeneration'] = true
}

PersistentVars = {}

--  ========  AUX FUNCTIONS  =========
Ext.Require("Functions/Auxiliary.lua")
--  ==================================

--==============================================================
----------------------------------------------------------------

--  ====
--  VARS
--  ====

TotalCount = 0 -- Variable to track the number of recipes created.
Template = {
    ['LOOT_Ink_Pot_A_Quill_A'] = "7c9e8ca5-de93-4e43-be83-2cb6a9022c2f",
    ['BOOK_Paper_Sheet_A'] = "f0872b5d-ee7a-43f9-a63e-e3200abdb1a3",
}

--  ================================
--  DETERMINE APPROPRIATE SKILLBOOK
--  ================================

 ---Determine the school and tier of blank skillbook required
 ---@param stat table
 ---@return string
function DetermineSkillbook(stat)
    local tier = "Blank_Step2_A" --   Tier 2 by default
    local school = "WarriorRogueRanger" --  Generic blank skillbook by default

    --  Valid Schools (except WarriorRogueRanger)
    local iterSchool = {
        "Air",
        "Water",
        "Fire",
        "Earth",
        "Polymorph",
        "Necromancy",
        "Summoning"
    }

    if IsValid(stat.ObjectCategory) then --  if ObjectCategory exists
        if string.match(stat.ObjectCategory, "Starter") or string.match(stat.ObjectCategory, "Early") then
            tier = "Blank_A" --  If Object Category is Starter or Early then set Tier 1
        end

        for _, element in pairs(iterSchool) do
            if string.match(stat.Name, element) or string.match(stat.ObjectCategory, element) then
                school = element --   Get School name
            end
        end
    end

    if school == "WarriorRogueRanger" then -- Nomatch then revert to tier 1
        tier = "Blank_A" -- As there is no tier 2 for Generic Blank Skillbooks reset tier to 1
    end

    return "BOOK_Skill_" .. school .. "_" .. tier --  Return Skillbook
end