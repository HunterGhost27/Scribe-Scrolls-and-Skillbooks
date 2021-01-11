--  =======
--  SCRIBER
--  =======

local function RecipeGeneratorSkillbooks()
    Debug:HFPrint("Scribing Skillbook Recipes")
    local objects = Ext.GetStatEntries("Object") --  Get All Object Entries.

    local count = 0
    for _, scribable in pairs(objects) do --  Iterate over object entries.
        if ScribeException[scribable] ~= true then --  If not in exceptions table.
            local stat = Ext.GetStat(scribable) or nil --  Get Stat Object for entry.

            if stat ~= nil and stat.Using == "_Skillbooks" then --  If stat is a skillbook

                Combo = Ext.GetItemCombo(IDENTIFIER .. "_" .. scribable) or nil
                if Combo == nil then
                    ReinitCombo() --  Reinitialize combo table
                end

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
                    ["Name"] = IDENTIFIER .. "_" .. scribable .. "_1",
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

                Ext.UpdateItemCombo(Combo)
                count = count + 1
                Debug:Print("Scribing --> " .. Combo.Name)
                ReinitCombo()
            end
        end
    end
    Ext.Print("======================================================================")
    Debug:Print("Scribed " .. count .. " Skillbooks!")
    TotalCount = TotalCount + count
end

local function RecipeGeneratorScrolls()
    Debug:Print("Scribing Scroll Recipes")
    Ext.Print("======================================================================")
    local scrolls = Ext.GetStatEntries("ItemCombination") --  Get ItemCombinations entries.

    local count = 0
    for _, scribable in pairs(scrolls) do
        local combination = Ext.GetItemCombo(IDENTIFIER .. "_" .. scribable)
        if combination == nil then
            ReinitCombo() --  Reinitialize Combo Table.
        else
            Combo = combination
        end

        if
            combination.RecipeCategory == "Grimoire" and
                string.match(combination.Results[1]["Results"][1]["Result"], "SCROLL")
         then
            local result = combination.Results[1]["Results"][1]["Result"]


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
                ["Name"] = IDENTIFIER .. "_" .. result .. "_1",
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

            Ext.UpdateItemCombo(Combo)
            count = count + 1
            Debug:Print("Scribing --> " .. Combo.Name)
            break
        end
    end
    Debug:Print("======================================================================")
    Debug:Print("Scribed " .. count .. " Scrolls!")
    TotalCount = TotalCount + count

    Debug:Print("----------------------------------------------------------------------")
    Debug:Print("Scribed a total of " .. TotalCount .. " Crafting-Recipes!")
    Debug:Print("----------------------------------------------------------------------")
end

--  ==============================================================
if CENTRAL[IDENTIFIER]["ModSettings"]["RecipeGeneration"] then
    Ext.RegisterListener("StatsLoaded", RecipeGeneratorSkillbooks)
    -- Ext.RegisterListener("StatsLoaded", RecipeGeneratorScrolls)
end
--  ==============================================================
