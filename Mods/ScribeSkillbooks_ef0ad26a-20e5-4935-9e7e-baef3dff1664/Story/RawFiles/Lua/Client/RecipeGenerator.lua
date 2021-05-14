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

--  list of stats to ignore
local ScribeException = {
    ["SKILLBOOK_AbilityPoint"] = true,
    ["SKILLBOOK_StatPoint"] = true,
    ["BOOK_Skill_WarriorRogueRanger_Blank_A"] = true,
}

---Generates Skillbook Scribing Recipes
local function RecipeGeneratorSkillbooks()
    Write:SetHeader("Scribing Skillbook Recipes")
    local objects = Ext.GetStatEntries("Object") -- Get all Object stat-entries

    local count = 0
    ForEach(objects, function(idx, scribable)
        if ScribeException[scribable] then return end -- Exit if stat is in ScribeException

        local stat = Ext.GetStat(scribable)
        if stat and stat.Using == "_Skillbooks" then -- Stat's parent is a _Skillbooks

            local Combo = ItemCombination:New(Ext.GetItemCombo(IDENTIFIER .. "_" .. scribable))

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
            Write:NewLine("Scribing --> " .. Combo.Name .. " for " .. scribable)
            count = count + 1
        end
    end)
    Write:LineBreak("_")
    Write:NewLine("Scribed " .. count .. " Skillbooks!")
    Debug:FPrint(Write:Display())
    TotalCount = TotalCount + count
end

local function RecipeGeneratorScrolls()
    Write:SetHeader("Scribing Scroll Recipes")
    local scrolls = Ext.GetStatEntries("ItemCombination") --  Get ItemCombination entries.

    local count = 0
    ForEach(scrolls, function(idx, scribable)
        if string.match(scribable, 'BOOK_Paper_Sheet_A') then
            if ScribeException[scribable] then return end -- Exit if stat is in ScribeException
            local Combo = ItemCombination:New(Ext.GetItemCombo(scribable))
            local scroll = Combo.Results[1].Results[1].Result

            --  CREATE INGREDIENTS
            --  ==================

            local target = 2
            for idx, tbl in pairs(Combo.Ingredients) do
                if string.match(tbl.Object, "Essence") or string.match(tbl.Object, "Source") or string.match(tbl.Object, "Tormented") then
                    target = idx
                end
            end

            local ingredientTable = {
                [1] = {
                    ["IngredientType"] = "Object",
                    ["ItemRarity"] = "Sentinel",
                    ["Object"] = scroll, -- Original Scroll
                    ["Transform"] = "None"
                },
                [2] = Combo.Ingredients[target], -- Elemental Essence
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
            Combo.Name = IDENTIFIER .. "_" .. scroll -- Update ItemCombo's Name

            --  CREATE RESULTS TABLE
            --  ====================

            local resultsTable = {
                ["Name"] = IDENTIFIER .. "_" .. scroll .. "_1",
                ["PreviewIcon"] = "",
                ["PreviewStatsId"] = scroll,
                ["PreviewTooltip"] = "",
                ["ReqLevel"] = 0,
                ["Requirement"] = "Sentinel",
                ["Results"] = {
                    [1] = {
                        ["Boost"] = "",
                        ["Result"] = scroll,
                        ["ResultAmount"] = 1
                    }
                }
            }
            Combo.Results[1] = resultsTable -- Update ItemCombo's Results Table

            --  UPDATE ITEM COMBO
            --  =================

            Ext.UpdateItemCombo(Combo)
            Write:NewLine("Scribing --> " .. Combo.Name .. " for " .. scroll)
            count = count + 1
        end
    end)
    Write:LineBreak("_")
    Write:NewLine("Scribed " .. count .. " Scrolls!")
    Debug:FPrint(Write:Display())
    TotalCount = TotalCount + count

    Debug:HFPrint("Scribed a total of " .. TotalCount .. " Crafting-Recipes!", {['highlight'] = "="})
end

--  ==========================================================
Ext.RegisterListener("StatsLoaded", RecipeGeneratorSkillbooks)
Ext.RegisterListener("StatsLoaded", RecipeGeneratorScrolls)
--  ==========================================================
