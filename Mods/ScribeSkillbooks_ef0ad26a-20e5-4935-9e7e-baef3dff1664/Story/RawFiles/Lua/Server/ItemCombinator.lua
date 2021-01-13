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
    local char, itm1, itm2, itm3, itm4, itm5, requestID = table.unpack(args)
    char, itm1, itm2, itm3, itm4, itm5 = ExtractGUID(char), ExtractGUID(itm1), ExtractGUID(itm2), ExtractGUID(itm3), ExtractGUID(itm4), ExtractGUID(itm5)
    local character, item1, item2, item3, item4, item5 = Ext.GetCharacter(char), Ext.GetItem(itm1), Ext.GetItem(itm2), Ext.GetItem(itm3), Ext.GetItem(itm4), Ext.GetItem(itm5)

    Debug:FWarn({char, itm1, itm2, itm3, itm4, itm5})

    local statsID = item1.StatsId
    local inventory = character:GetInventoryItems()

    if not IsValid(statsID) then return end
    if Ext.GetStat(statsID).Using == "_Skillbooks" then
        if item2.RootTemplate.Id ~= Template['LOOT_Ink_Pot_A_Quill_A'] then return end
        Osi.ItemTemplateRemoveFrom(itm3, char, 1)
        Osi.ItemTemplateAddTo(itm1, char, 1, 1)

    elseif Ext.GetStat(statsID).Using == "_Scrolls" then
        Osi.ItemTemplateRemoveFrom(itm3, char, 1)
        Osi.ItemTemplateAddTo(itm1, char, 1, 1)
    end
end

--  =====================================================================
Ext.RegisterOsirisListener('CanCombineItem', 7, 'before', ItemCombinator)
--  =====================================================================
