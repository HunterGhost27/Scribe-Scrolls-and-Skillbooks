--  =======
--  SCRIBER
--  =======

local function RecipeGeneratorSkillbooks()
    Ext.Print("======================================================================")
    Ext.Print(LogPrefix .. "Scribing Skillbook Recipes")
    Ext.Print("======================================================================")
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

local function RecipeGeneratorScrolls()
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

--  ===========================================================
if CENTRAL[IDENTIFIER]["ModSettings"]["RecipeGeneration"] then
    Ext.RegisterListener("StatsLoaded", RecipeGeneratorSkillbooks)
    Ext.RegisterListener("StatsLoaded", RecipeGeneratorScrolls)
end
--  ==========================================================

--  ===============
--  ITEM COMBINATOR
--  ===============

local function ItemCombinator(...)
    --[[
    Osiris Listener for
    event ItemTemplateCombinedWithItemTemplate( (STRING)_FirstItemTemplate, 
                                                (STRING)_SecondItemTemplate,
                                                (STRING)_ThirdItemTemplate,
                                                (STRING)_ForthItemTemplate,
                                                (STRING)_FifthItemTemplate,
                                                (CHARACTERGUID)_Character,
                                                (ITEMGUID)_NewItem)
--]]

    local args = {...} -- Takes all parameters

    local character = args[6] -- fetch (CHARACTERGUID)_Character

    Ext.Print(args[1]:sub(-36))
    Ext.Print(Osi.GetItemForItemTemplateInInventory(character, args[1]:sub(-36)))
    Ext.Print(Osi.NRD_ItemGetStatsId(Osi.GetItemForItemTemplateInInventory(character, args[1]:sub(-36))))

    local stat = Osi.NRD_ItemGetStatsId(Osi.GetItemForItemTemplateInInventory(character, args[1]:sub(-36))) -- Get StatsID

    if stat ~= nil then -- if stat exists
        local itemCombination = {
            ["Item"] = {
                [1] = args[1]:sub(-36),
                [2] = args[2]:sub(-36),
                [3] = args[3]:sub(-36),
                [4] = args[4]:sub(-36),
                [5] = args[5]:sub(-36)
            },
            ["Character"] = character,
            ["Result"] = Osi.GetItemForItemTemplateInInventory(character, args[1]:sub(-36))
        }

        Ext.Print(Ext.JsonStringify(itemCombination))

        Ext.Print(Ext.GetStat(stat).Using)

        if Ext.GetStat(stat).Using == "_Skillbooks" then
            if itemCombination.Item[2] ~= "7c9e8ca5-de93-4e43-be83-2cb6a9022c2f" then
                return
            end

            if
                Osi.NRD_ItemGetStatsId(Osi.GetItemForItemTemplateInInventory(character, itemCombination.Item[3])) ~=
                    DetermineSkillbook(Ext.GetStat(stat))
             then
                return
            end

            Ext.Print(DetermineSkillbook(Ext.GetStat(stat)))

            Osi.ItemTemplateAddTo(args[1]:sub(-36), character, 1, 1)
        elseif Ext.GetStat(stat).Using == "_Scrolls" then
            Osi.ItemTemplateAddTo(args[1]:sub(-36), character, 1, 1)
        end
    end
end

--  ==============================================================================================
if not CENTRAL[IDENTIFIER]["ModSettings"]["RecipeGeneration"] then
    Ext.RegisterOsirisListener("ItemTemplateCombinedWithItemTemplate", 7, "after", ItemCombinator)
end
--  ==============================================================================================
