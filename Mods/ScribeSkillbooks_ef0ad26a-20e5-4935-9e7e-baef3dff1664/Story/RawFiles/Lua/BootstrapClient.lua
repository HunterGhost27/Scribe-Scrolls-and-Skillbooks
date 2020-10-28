local PREFIX = "S7_Scribe"

--  ================
--  EXCEPTIONS TABLE
--  ================

local scribeException = {
    ["SKILLBOOK_AbilityPoint"] = true,
    ["SKILLBOOK_StatPoint"] = true
}

--  ================================
--  DETERMINE APPROPRIATE SKILLBOOK
--  ================================

local function DetermineSkillbook(stat)
    local tier = "Blank_Step2_A"

    local iterSchool = {
        "Air",
        "Water",
        "Fire",
        "Earth",
        "Polymorph",
        "Necromancy",
        "Summoning"
    }

    local school = "WarriorRogueRanger"

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

    local skillbook = "BOOK_Skill_" .. school .. "_" .. tier

    return skillbook
end

--  ################################################################################################################

--  =======
--  SCRIBER
--  =======

local function S7_Scribe()
    local objects = Ext.GetStatEntries("Object")

    local expo = {}

    for _, scribable in ipairs(objects) do
        if scribeException[scribable] ~= true then
            local stat = Ext.GetStat(scribable) or nil

            if stat ~= nil and stat.Using == "_Skillbooks" then
                local combo = {
                    ["AutoLevel"] = false,
                    ["CraftingStation"] = "None",
                    ["Ingredients"] = {},
                    ["Name"] = "",
                    ["RecipeCategory"] = "Grimoire",
                    ["Results"] = {}
                }

                local ingredientTable = {
                    [1] = {
                        ["IngredientType"] = "Object",
                        ["ItemRarity"] = "Sentinel",
                        ["Object"] = scribable,
                        ["Transform"] = "None"
                    },
                    [2] = {
                        ["IngredientType"] = "Object",
                        ["ItemRarity"] = "Sentinel",
                        ["Object"] = "LOOT_Ink_Pot_A_Quill_A",
                        ["Transform"] = "None"
                    },
                    [3] = {
                        ["IngredientType"] = "Object",
                        ["ItemRarity"] = "Sentinel",
                        ["Object"] = DetermineSkillbook(stat),
                        ["Transform"] = "Transform"
                    }
                }

                combo.Ingredients = ingredientTable

                combo.Name = PREFIX .. "_" .. scribable

                local resultsTable = {
                    ["Name"] = "Scribe_" .. scribable .. "_1",
                    ["PreviewIcon"] = "",
                    ["PreviewStatsId"] = scribable,
                    ["PreviewTooltip"] = "",
                    ["ReqLevel"] = 0,
                    ["Requirement"] = "Sentinel",
                    ["Results"] = {
                        [1] = {
                            ["Boost"] = "",
                            ["Result"] = scribable,
                            ["ResultAmount"] = 1
                        }
                    }
                }
                combo.Results[1] = resultsTable

                Ext.Print("Updated: " .. "Scribe_" .. scribable)
                expo[scribable] = DetermineSkillbook(stat)
                Ext.UpdateItemCombo(combo)
            end
        end
    end
    Ext.SaveFile("S7_Expo.json", Ext.JsonStringify(expo))
end

--  ==========================================
Ext.RegisterListener("StatsLoaded", S7_Scribe)
--  ==========================================
