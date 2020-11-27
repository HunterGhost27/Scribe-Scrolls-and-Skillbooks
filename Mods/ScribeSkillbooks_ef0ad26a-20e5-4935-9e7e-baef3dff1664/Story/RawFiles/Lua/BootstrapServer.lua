--  =======
--  IMPORTS
--  =======

Ext.Require("S7_ScribeAuxiliary.lua")
Ext.Require("S7_Scriber.lua")

--  ==================================
--  ACTIVATE LEGACY COMPATIBILITY MODE
--  ==================================

local function S7_ExistingPlaythrough(param)
    local active = false
    if param == "1" then active = true elseif param == "0" then active = false end

    Ext.BroadcastMessage("S7_Scribe", "S7_ExistingPlaythrough")
    CENTRAL[IDENTIFIER]["ModSettings"]["LegacyCompatibilityMode"] = active
    Ext.SaveFile("S7Central.json", Ext.JsonStringify(CENTRAL))
end
