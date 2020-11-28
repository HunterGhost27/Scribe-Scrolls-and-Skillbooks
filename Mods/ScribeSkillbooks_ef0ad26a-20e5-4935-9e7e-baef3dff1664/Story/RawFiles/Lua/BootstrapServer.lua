--  =======
--  IMPORTS
--  =======

Ext.Require("S7_ScribeAuxiliary.lua")
Ext.Require("S7_ItemCombinator.lua")

--  ==================================
--  ACTIVATE LEGACY COMPATIBILITY MODE
--  ==================================

function S7_Scribe_ToggleLegacyMode(param)
    local legacyCompMode = false
    if param == 1 then
        legacyCompMode = true
    elseif param == 0 then
        legacyCompMode = false
    end

    local package = table.pack("ToggleLegacyMode", legacyCompMode)

    Ext.BroadcastMessage("S7_Scribe", Ext.JsonStringify(package))
    CENTRAL[IDENTIFIER]["ModSettings"]["LegacyCompatibilityMode"] = legacyCompMode
    Ext.SaveFile("S7Central.json", Ext.JsonStringify(CENTRAL))
end

--  ===================================================================================
Ext.NewCall(S7_Scribe_ToggleLegacyMode, "S7_Scribe_ToggleLegacyMode", "(INTEGER)_Flag")
--  ===================================================================================

--  ====================================
--  DEACTIVATE LEGACY COMPATIBILITY MODE
--  ====================================

local function DisableLegacyModeOnNewGame()
    if Osi.GlobalGetFlag("S7_Scribe_ModAddedTo_NewGame") == 1 and CENTRAL[IDENTIFIER]["ModSettings"]["LegacyCompatibilityMode"] then
        Osi.OpenMessageBox(Osi.CharacterGetHostCharacter(), "Looks like you've started a New-Game, but the Scribe-Scrolls-and-Skillbook's legacy mode is still active! The mod will now turn off legacy mode, but this will require you to restart the game. Sorry for the inconvenience caused.")
        S7_Scribe_ToggleLegacyMode(0)
    end
end

--  =============================================================================
Ext.RegisterOsirisListener("GameStarted", 2, "after", DisableLegacyModeOnNewGame)
--  =============================================================================