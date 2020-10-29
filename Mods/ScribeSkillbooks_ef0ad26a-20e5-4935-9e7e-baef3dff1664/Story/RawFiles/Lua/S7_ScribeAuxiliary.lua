--  ================
PREFIX = "S7_Scribe"
--  ================

--  ================
--  EXCEPTIONS TABLE
--  ================

scribeException = {
    --  list of all stats to ignore
    ["SKILLBOOK_AbilityPoint"] = true,
    ["SKILLBOOK_StatPoint"] = true
}

--  ==============
--  COMBO TEMPLATE
--  ==============

combo = {}

function ReinitCombo() --  Resets combo table to initial values
    combo = {
        ["AutoLevel"] = false,
        ["CraftingStation"] = "None",
        ["Ingredients"] = {},
        ["Name"] = "",
        ["RecipeCategory"] = "Grimoire",
        ["Results"] = {}
    }
end

ReinitCombo() --  Initialize combo

--  ================================
--  DETERMINE APPROPRIATE SKILLBOOK
--  ================================

function DetermineSkillbook(stat) --  Determine the school and tier of blank skillbook required
    local tier = "Blank_Step2_A" --   Tier 2 by default

    local school = "WarriorRogueRanger" --  Generic blank skillbook by default

    local iterSchool = {
        --  Valid Schools
        "Air",
        "Water",
        "Fire",
        "Earth",
        "Polymorph",
        "Necromancy",
        "Summoning"
    }

    if stat.ObjectCategory ~= nil then
        if string.match(stat.ObjectCategory, "Starter") or string.match(stat.ObjectCategory, "Early") then
            tier = "Blank_A" --  If Object Category is Starter or Early then set Tier 1
        end

        for _, element in ipairs(iterSchool) do
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

LogPrefix = "[S7_Scribe:Lua:BootstrapClient] --- "
totalCount = 0
