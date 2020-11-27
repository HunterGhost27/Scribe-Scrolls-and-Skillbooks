--  =======
--  SCRIBER
--  =======

local function S7_ScribeSkillbooks()
    Ext.Print(LogPrefix .. "======================================================================")
    Ext.Print(LogPrefix .. "Scribing Skillbook Recipes")
    Ext.Print(LogPrefix .. "======================================================================")
    local objects = Ext.GetStatEntries("Object") --  Get All Object Entries.

    local count = 0
    for _, scribable in ipairs(objects) do --  Iterate over object entries.
        if ScribeException[scribable] ~= true then --  If not in exceptions table.
            local stat = Ext.GetStat(scribable) or nil --  Get Stat Object for entry.

            if stat ~= nil and stat.Using == "_Skillbooks" then --  If stat is a skillbook
                ReinitCombo() --  Reinitialize combo table

                --  BUILD INGREDIENTS TABLE
                --  =======================

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

                Combo.Ingredients = ingredientTable

                Combo.Name = IDENTIFIER .. "_" .. scribable

                --  CREATE RESULTS TABLE
                --  ====================

                local resultsTable = {
                    ["Name"] = IDENTIFIER .. scribable .. "_1",
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
                Combo.Results[1] = resultsTable

                --  UPDATE ITEM COMBO
                --  =================

                -- Ext.UpdateItemCombo(combo)
                count = count + 1
                Ext.Print(LogPrefix .. "Scribing --> " .. Combo.Name)
            end
        end
    end
    Ext.Print("======================================================================")
    Ext.Print(LogPrefix .. "Scribed " .. count .. " Skillbooks!")
    TotalCount = TotalCount + count
end

--  ====================================================
Ext.RegisterListener("StatsLoaded", S7_ScribeSkillbooks)
--  ====================================================

local function S7_ScribeScrolls()
    Ext.Print(LogPrefix .. "Scribing Scroll Recipes")
    Ext.Print("======================================================================")
    local scrolls = Ext.GetStatEntries("ItemCombination") --  Get ItemCombinations entries.

    local count = 0
    for _, scribable in ipairs(scrolls) do
        local combination = Ext.GetItemCombo(scribable)
        if
            combination.RecipeCategory == "Grimoire" and
                string.match(combination.Results[1]["Results"][1]["Result"], "SCROLL")
         then
            local result = combination.Results[1]["Results"][1]["Result"]

            ReinitCombo() --  Reinitialize Combo Table.

            --  CREATE INGREDIENTS
            --  ==================

            local ingredientTable = {
                [1] = {
                    ["IngredientType"] = "Object",
                    ["ItemRarity"] = "Sentinel",
                    ["Object"] = result,
                    ["Transform"] = "None"
                },
                [2] = combination.Ingredients[2],
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

            Combo.Ingredients = ingredientTable

            Combo.Name = IDENTIFIER .. "_" .. result

            --  CREATE RESULTS TABLE
            --  ====================

            local resultsTable = {
                ["Name"] = IDENTIFIER .. result .. "_1",
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
            Combo.Results[1] = resultsTable

            --  UPDATE ITEM COMBO
            --  =================

            -- Ext.UpdateItemCombo(combo)
            count = count + 1
            Ext.Print(LogPrefix .. "Scribing --> " .. Combo.Name)
        end
    end
    Ext.Print(LogPrefix .. "======================================================================")
    Ext.Print(LogPrefix .. "Scribed " .. count .. " Scrolls!")
    TotalCount = TotalCount + count

    Ext.Print(LogPrefix .. "----------------------------------------------------------------------")
    Ext.Print(LogPrefix .. "Scribed a total of " .. TotalCount .. " Crafting-Recipes!")
    Ext.Print(LogPrefix .. "----------------------------------------------------------------------")
end

--  =================================================
Ext.RegisterListener("StatsLoaded", S7_ScribeScrolls)
--  =================================================
