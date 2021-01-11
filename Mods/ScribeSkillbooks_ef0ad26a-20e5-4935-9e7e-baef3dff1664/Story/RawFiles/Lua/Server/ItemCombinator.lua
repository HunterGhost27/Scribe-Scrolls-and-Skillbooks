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

    local args = {...}
    local char, item1, item2, item3, item4, item5, requestID = table.unpack(args)
    char = ExtractGUID(char)
    item1 = ExtractGUID(item1)
    item2 = ExtractGUID(item2)
    item3 = ExtractGUID(item3)
    item4 = ExtractGUID(item4)
    item5 = ExtractGUID(item5)

    Debug:FWarn({char, item1, item2, item3, item4, item5})

    local statsID = Osi.NRD_ItemGetStatsId(Osi.GetItemForItemTemplateInInventory(char, item1)) -- Get StatsID

    if statsID ~= nil then -- if stat exists
        if Ext.GetStat(statsID).Using == "_Skillbooks" then
            if item2 ~= "7c9e8ca5-de93-4e43-be83-2cb6a9022c2f" then return end
            Osi.ItemTemplateRemoveFrom(item3, char, 1)
            Osi.ItemTemplateAddTo(item1, char, 1, 1)
        
        elseif Ext.GetStat(statsID).Using == "_Scrolls" then
            Osi.ItemTemplateRemoveFrom(item3, char, 1)
            Osi.ItemTemplateAddTo(item1, char, 1, 1)
        end
    end
end

--  ============================================================================================================================================
if not CENTRAL[IDENTIFIER]["ModSettings"]["RecipeGeneration"] then Ext.RegisterOsirisListener('CanCombineItem', 6, 'before', ItemCombinator) end
--  ============================================================================================================================================
