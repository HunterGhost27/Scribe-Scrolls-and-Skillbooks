local CRAFTER_KIT = '68a99fef-d125-4ed0-893f-bb6751e52c5e'

if Ext.ModIsLoaded(CRAFTER_KIT) then return end

Ext.RegisterListener("StatsLoaded", function ()
    Ext.UpdateItemCombo({
        ["AutoLevel"] = false,
        ["CraftingStation"] = "None",
        ["Ingredients"] = {
            [1] = {
                ["IngredientType"] = "Category",
                ["ItemRarity"] = "Sentinel",
                ["Object"] = "CuttingTool",
                ["Transform"] = "Transform"
            },
            [2] = {
                ["IngredientType"] = "Object",
                ["ItemRarity"] = "Sentinel",
                ["Object"] = "LOOT_Feather_A",
                ["Transform"] = "None"
            }
        },
        ["Name"] = "CuttingTool_LOOT_Feather_A",
        ["RecipeCategory"] = "Grimoire",
        ["Results"] = {
            [1] = {
                ["Name"] = "CuttingTool_LOOT_Feather_A_1",
                ["PreviewIcon"] = "",
                ["PreviewStatsId"] = "LOOT_Feather_A_Quill_A",
                ["PreviewTooltip"] = "",
                ["ReqLevel"] = 0,
                ["Requirement"] = "Sentinel",
                ["Results"] = {
                    [1] = {
                        ["Boost"] = "",
                        ["Result"] = "LOOT_Feather_A_Quill_A",
                        ["ResultAmount"] = 1
                    }
                }
            }
        }
    })
end)