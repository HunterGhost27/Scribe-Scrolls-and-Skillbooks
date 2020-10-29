--  ================
PREFIX = "S7_Scribe"
--  ================

--  ================
--  EXCEPTIONS TABLE
--  ================

scribeException = {
    ["SKILLBOOK_AbilityPoint"] = true,
    ["SKILLBOOK_StatPoint"] = true
}

--  ==============
--  COMBO TEMPLATE
--  ==============
combo = {}

function ReinitCombo()
    combo = {
        ["AutoLevel"] = false,
        ["CraftingStation"] = "None",
        ["Ingredients"] = {},
        ["Name"] = "",
        ["RecipeCategory"] = "Grimoire",
        ["Results"] = {}
    }
end

ReinitCombo()

--  ================================
--  DETERMINE APPROPRIATE SKILLBOOK
--  ================================

function DetermineSkillbook(stat)
    local tier = "Blank_Step2_A"

    local school = "WarriorRogueRanger"

    local iterSchool = {
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
            tier = "Blank_A"
        end

        for _, element in ipairs(iterSchool) do
            if string.match(stat.Name, element) or string.match(stat.ObjectCategory, element) then
                school = element
            end
        end
    end

    if school == "WarriorRogueRanger" then
        tier = "Blank_A"
    end

    return "BOOK_Skill_" .. school .. "_" .. tier
end

--  ====
--  VARS
--  ====

LogPrefix = "[S7_Scribe:Lua:BootstrapClient] --- "

totalCount = 0
