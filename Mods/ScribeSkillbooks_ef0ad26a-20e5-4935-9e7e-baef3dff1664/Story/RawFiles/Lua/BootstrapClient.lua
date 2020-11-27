--  =======
--  IMPORTS
--  =======

Ext.Require("S7_ScribeAuxiliary.lua")
Ext.Require("S7_Scriber.lua")

--  ==================
--  BROADCAST RESPONSE
--  ==================

local function onBroadcast(channel, payload)
    if channel == "S7_Scribe" and payload == "ExistingPlaythrough" then
        CENTRAL[IDENTIFIER]["ModSettings"]["LegacyCompatibilityMode"] = true
        Ext.SaveFile("S7Central.json", Ext.JsonStringify(CENTRAL))
    end
end

--  =============================================
Ext.RegisterNetListener("S7_Scribe", onBroadcast)
--  =============================================

local function RevertItemCombo()
    if CENTRAL[IDENTIFIER]["ModSettings"]["LegacyCompatibilityMode"] == true then
        Ext.AddPathOverride(
            "Public/ScribeSkillbooks_ef0ad26a-20e5-4935-9e7e-baef3dff1664/Stats/Generated/ItemCombos.txt",
            "Public/ScribeSkillbooks_ef0ad26a-20e5-4935-9e7e-baef3dff1664/Stats/Override/ItemCombos.txt"
        )
        Ext.Print(LogPrefix .. "Legacy Compatibility Mode Active. Reverting ItemCombos.txt")
    end
end

--  ======================================================
Ext.RegisterListener("ModuleLoadStarted", RevertItemCombo)
--  ======================================================
