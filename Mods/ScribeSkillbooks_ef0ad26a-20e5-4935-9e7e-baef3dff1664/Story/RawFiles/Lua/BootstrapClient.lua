Ext.Require("S7_ScribeAuxiliary.lua")

--  =======
--  SCRIBER
--  =======

local function S7_ScribeSkillbooks()
    Ext.Print(LogPrefix .. "======================================================================")
    Ext.Print(LogPrefix .. "Scribing Skillbook Recipes")
    Ext.Print(LogPrefix .. "======================================================================")
    local objects = Ext.GetStatEntries("Object")

    local count = 0
    for _, scribable in ipairs(objects) do
        if scribeException[scribable] ~= true then
            local stat = Ext.GetStat(scribable) or nil

            if stat ~= nil and stat.Using == "_Skillbooks" then
                ReinitCombo()

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
                    ["Name"] = PREFIX .. scribable .. "_1",
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

                Ext.UpdateItemCombo(combo)
                count = count + 1
                Ext.Print(LogPrefix .. "Scribing --> " .. combo.Name)
            end
        end
    end
    Ext.Print("======================================================================")
    Ext.Print(LogPrefix .. "Scribed " .. count .. " Skillbooks!")
    totalCount = totalCount + count
end

--  ====================================================
Ext.RegisterListener("StatsLoaded", S7_ScribeSkillbooks)
--  ====================================================

local function S7_ScribeScrolls()
    Ext.Print(LogPrefix .. "Scribing Scroll Recipes")
    Ext.Print("======================================================================")
    local scrolls = Ext.GetStatEntries("ItemCombination")

    local count = 0
    for _, scribable in ipairs(scrolls) do
        local combination = Ext.GetItemCombo(scribable)
        if
            combination.RecipeCategory == "Grimoire" and
                string.match(combination.Results[1]["Results"][1]["Result"], "SCROLL")
         then
            local result = combination.Results[1]["Results"][1]["Result"]

            ReinitCombo()

            local ingredientTable = {
                [3] = {
                    ["IngredientType"] = "Object",
                    ["ItemRarity"] = "Sentinel",
                    ["Object"] = "LOOT_Ink_Pot_A_Quill_A",
                    ["Transform"] = "None"
                },
                [4] = {
                    ["IngredientType"] = "Object",
                    ["ItemRarity"] = "Sentinel",
                    ["Object"] = "BOOK_Paper_Sheet_A",
                    ["Transform"] = "Transform"
                }
            }
            combo.Ingredients[1] = combination.Ingredients[1]
            combo.Ingredients[2] = combination.Ingredients[2]
            combo.Ingredients[3] = ingredientTable[3]
            combo.Ingredients[4] = ingredientTable[4]

            combo.Name = PREFIX .. "_" .. result

            local resultsTable = {
                ["Name"] = PREFIX .. result .. "_1",
                ["PreviewIcon"] = "",
                ["PreviewStatsId"] = result,
                ["PreviewTooltip"] = "",
                ["ReqLevel"] = 0,
                ["Requirement"] = "Sentinel",
                ["Results"] = {
                    [1] = {
                        ["Boost"] = "",
                        ["Result"] = result,
                        ["ResultAmount"] = 1
                    }
                }
            }
            combo.Results[1] = resultsTable

            Ext.UpdateItemCombo(combo)
            count = count + 1
            Ext.Print(LogPrefix .. "Scribing --> " .. combo.Name)
        end
    end
    Ext.Print(LogPrefix .. "======================================================================")
    Ext.Print(LogPrefix .. "Scribed " .. count .. " Scrolls!")
    totalCount = totalCount + count

    Ext.Print(LogPrefix .. "Scribed a total of " .. totalCount .. " Crafting-Recipes!")
end

--  =================================================
Ext.RegisterListener("StatsLoaded", S7_ScribeScrolls)
--  =================================================
