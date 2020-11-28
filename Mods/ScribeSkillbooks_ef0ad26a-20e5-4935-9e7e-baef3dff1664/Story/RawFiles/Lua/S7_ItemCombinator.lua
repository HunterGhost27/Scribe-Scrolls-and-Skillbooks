LogSource = "ItemCombinator"

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
    local item1, item2, item3, item4, item5, character, newItem = table.unpack(args)

    local statsID = Osi.NRD_ItemGetStatsId(Osi.GetItemForItemTemplateInInventory(character, item1:sub(-36))) -- Get StatsID

    if statsID ~= nil then -- if stat exists
        if Ext.GetStat(statsID).Using == "_Skillbooks" then
            if item2:sub(-36) ~= "7c9e8ca5-de93-4e43-be83-2cb6a9022c2f" then
                return
            end

            Osi.ItemTemplateRemoveFrom(item3, character, 1)
            Osi.ItemTemplateAddTo(item1:sub(-36), character, 1, 1)
        
        elseif Ext.GetStat(statsID).Using == "_Scrolls" then
            Osi.ItemTemplateRemoveFrom(item3, character, 1)
            Osi.ItemTemplateAddTo(item1:sub(-36), character, 1, 1)
        end
    end
end

--  ==============================================================================================
if not CENTRAL[IDENTIFIER]["ModSettings"]["RecipeGeneration"] then
    Ext.RegisterOsirisListener("ItemTemplateCombinedWithItemTemplate", 7, "after", ItemCombinator)
end
--  ==============================================================================================
