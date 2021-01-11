--  ================
--  ITEM COMBINATION
--  ================

---@class ItemCombination
---@field AutoLevel boolean
---@field CraftingStation string
---@field Ingredients table
---@field Name string
---@field RecipeCategory string
---@field Results table
ItemCombination = {
    ["AutoLevel"] = false,
    ["CraftingStation"] = "None",
    ["Ingredients"] = {},
    ["Name"] = "",
    ["RecipeCategory"] = "Grimoire",
    ["Results"] = {}
}

function ItemCombination:New(object)
    local object = object or {}
    object = Integrate(self, object)
    return object
end


--  =======
--  SCRIBER
--  =======

local function RecipeGeneratorSkillbooks()
    Stringer:SetHeader("Scribing Skillbook Recipes")
    local objects = Ext.GetStatEntries("Object") -- Get all Object stat-entries

    --  list of stats to ignore
    local ScribeException = {
        ["SKILLBOOK_AbilityPoint"] = true,
        ["SKILLBOOK_StatPoint"] = true
    }

    local count = 0
    for _, scribable in pairs(objects) do
        if ScribeException[scribable] then return end -- Exit if stat is in ScribeException

        local stat = Ext.GetStat(scribable)
        if stat and stat.Using == "_Skillbooks" then -- Stat's parent is a _Skillbooks

            Combo = ItemCombination:New(Ext.GetItemCombo(IDENTIFIER .. "_" .. scribable))

            --  BUILD INGREDIENTS TABLE
            --  =======================

            local ingredientTable = {
                [1] = {
                    ["IngredientType"] = "Object",
                    ["ItemRarity"] = "Sentinel",
                    ["Object"] = scribable, -- Original Skillbook
                    ["Transform"] = "None"
                },
                [2] = {
                    ["IngredientType"] = "Object",
                    ["ItemRarity"] = "Sentinel",
                    ["Object"] = "LOOT_Ink_Pot_A_Quill_A", -- Inkpot-&-Quill
                    ["Transform"] = "None"
                },
                [3] = {
                    ["IngredientType"] = "Object",
                    ["ItemRarity"] = "Sentinel",
                    ["Object"] = DetermineSkillbook(stat), -- Associated Blank Skillbook
                    ["Transform"] = "Transform"
                }
            }

            Combo.Ingredients = ingredientTable -- Update ItemCombo's Ingredients Table
            Combo.Name = IDENTIFIER .. "_" .. scribable -- Update ItemCombo's Name

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
            Combo.Results[1] = resultsTable -- Update ItemCombo's Results Table

            --  UPDATE ITEM COMBO
            --  =================

            Ext.UpdateItemCombo(Combo)
            Stringer:Add("Scribing --> " .. Combo.Name)
            count = count + 1
        end
    end
    Debug:FPrint(Stringer:Build())
    Debug:FPrint("Scribed " .. count .. " Skillbooks!")
    TotalCount = TotalCount + count
end

local function RecipeGeneratorScrolls()
    Stringer:SetHeader("Scribing Scroll Recipes")
    local scrolls = Ext.GetStatEntries("ItemCombination") --  Get ItemCombinations entries.

    local count = 0
    for _, scribable in pairs(scrolls) do
        Combo = ItemCombination:New(Ext.GetItemCombo(IDENTIFIER .. "_" .. scribable))

        local result = Combo.Results[1]["Results"][1]["Result"]
        if Combo.RecipeCategory == "Grimoire" and string.match(result, "SCROLL") then

            --  CREATE INGREDIENTS
            --  ==================

            local ingredientTable = {
                [1] = {
                    ["IngredientType"] = "Object",
                    ["ItemRarity"] = "Sentinel",
                    ["Object"] = result, -- Original Scroll
                    ["Transform"] = "None"
                },
                [2] = Combo.Ingredients[2], -- Essense, I think
                [3] = {
                    ["IngredientType"] = "Object",
                    ["ItemRarity"] = "Sentinel",
                    ["Object"] = "LOOT_Ink_Pot_A_Quill_A", -- Inkpot-&-Quill
                    ["Transform"] = "None"
                },
                [4] = {
                    ["IngredientType"] = "Object",
                    ["ItemRarity"] = "Sentinel",
                    ["Object"] = "BOOK_Paper_Sheet_A", -- Sheet of Paper
                    ["Transform"] = "Transform"
                }
            }

            Combo.Ingredients = ingredientTable -- Update ItemCombo's Ingredients Table
            Combo.Name = IDENTIFIER .. "_" .. result -- Update ItemCombo's Name

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
            Combo.Results[1] = resultsTable -- Update ItemCombo's Results Table

            --  UPDATE ITEM COMBO
            --  =================

            Ext.UpdateItemCombo(Combo)
            Stringer:Add("Scribing --> " .. Combo.Name)
            count = count + 1
            break --@TODO REMOVE THIS LMAO
        end
    end
    Debug:FPrint(Stringer:Build())
    Debug:FPrint("Scribed " .. count .. " Scrolls!")
    TotalCount = TotalCount + count

    Debug:HFPrint("Scribed a total of " .. TotalCount .. " Crafting-Recipes!", {['highlight'] = "-"})
end

--  ==============================================================
if CENTRAL[IDENTIFIER]["ModSettings"]["RecipeGeneration"] then
    Ext.RegisterListener("StatsLoaded", RecipeGeneratorSkillbooks)
    Ext.RegisterListener("StatsLoaded", RecipeGeneratorScrolls)
end
--  ==============================================================
