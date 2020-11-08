--  =======
--  IMPORTS
--  =======

Ext.Require("S7_ScribeAuxiliary.lua")
Ext.Require("S7_Scriber.lua")

--  =======
--  SCRIBER
--  =======

local function S7_Scriber(...)
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

    character = args[6] -- fetch (CHARACTERGUID)_Character

    Ext.Print(args[1]:sub(-36))
    Ext.Print(Osi.GetItemForItemTemplateInInventory(character, args[1]:sub(-36)))
    Ext.Print(Osi.NRD_ItemGetStatsId(Osi.GetItemForItemTemplateInInventory(character, args[1]:sub(-36))))

    stat = Osi.NRD_ItemGetStatsId(Osi.GetItemForItemTemplateInInventory(character, args[1]:sub(-36))) -- Get StatsID

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

        Ext.PostMessageToClient(character, "Test", Ext.JsonStringify(itemCombination))
    end
end

Ext.RegisterOsirisListener("ItemTemplateCombinedWithItemTemplate", 7, "after", S7_Scriber)
