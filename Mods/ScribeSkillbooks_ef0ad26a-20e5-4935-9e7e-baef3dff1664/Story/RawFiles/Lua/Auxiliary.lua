----------------------------------------------------------------
--==============================================================
MODINFO = Ext.GetModInfo('ef0ad26a-20e5-4935-9e7e-baef3dff1664')
IDENTIFIER = 'S7_Scribe'
PersistentVars = {}
--==============================================================
----------------------------------------------------------------

--  ========  AUX FUNCTIONS  =========
Ext.Require("Functions/Auxiliary.lua")
--  ==================================

--  ====================
--  DEFAULT MOD-SETTINGS
--  ====================

Settings:Write({
    ['LegacyCompatibilityMode'] = false,
    ['RecipeGeneration'] = true
})
CENTRAL:ReSync()

--  ====
--  VARS
--  ====

TotalCount = 0 -- Variable to track the number of recipes created.
InkpotNQuillTemplate = "7c9e8ca5-de93-4e43-be83-2cb6a9022c2f"

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