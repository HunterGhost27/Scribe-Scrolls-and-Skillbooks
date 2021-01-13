--  ===============
--  ITEM COMBINATOR
--  ===============

local function ItemCombinator(char, itm1, itm2, itm3, itm4, itm5, requestID)
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

    Ext.Print(char, itm1, itm2, itm3, itm4, itm5, requestID)

    local function extractGUIDIfValid(x) if ValidString(x) then return ExtractGUID(x) else return nil end end

    local combinator = {
        ['char'] = extractGUIDIfValid(char),
        ['item1'] = extractGUIDIfValid(itm1),
        ['item2'] = extractGUIDIfValid(itm2),
        ['item3'] = extractGUIDIfValid(itm3),
        ['item4'] = extractGUIDIfValid(itm4),
        ['item5'] = extractGUIDIfValid(itm5),
        ['requestID'] = requestID
    }

    Ext.Print(Ext.JsonStringify(combinator))
end

--  =====================================================================
Ext.RegisterOsirisListener('CanCombineItem', 7, 'before', ItemCombinator)
--  =====================================================================
