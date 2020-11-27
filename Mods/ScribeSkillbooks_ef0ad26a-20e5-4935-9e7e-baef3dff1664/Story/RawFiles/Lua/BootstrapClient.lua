--  =======
--  IMPORTS
--  =======

Ext.Require("S7_ScribeAuxiliary.lua")
Ext.Require("S7_Scriber.lua")

local function onBroadcast(channel, payload)
    if channel == "S7_Scribe" and payload == "ExistingPlaythrough" then
        local settings = {["RevertItemCombos"] = true}
        Ext.SaveFile("S7_ScribeSettings.json", Ext.JsonStringify(settings))
    end
end

--  =============================================
Ext.RegisterNetListener("S7_Scribe", onBroadcast)
--  =============================================

local function RevertItemCombo()
    local file = Ext.LoadFile("S7_ScribeSettings.json") or ""
    local settings = {}
    if file ~= nil and file ~= "" then
        settings = Ext.JsonParse(file)
    end

    if settings ~= {} and settings ~= nil then
        Ext.Print(LogPrefix .. "Settings Loaded.")

        if settings["RevertItemCombos"] == true then
            Ext.AddPathOverride(
                "Public/ScribeSkillbooks_ef0ad26a-20e5-4935-9e7e-baef3dff1664/Stats/Generated/ItemCombos.txt",
                "Public/ScribeSkillbooks_ef0ad26a-20e5-4935-9e7e-baef3dff1664/Stats/Override/ItemCombos.txt"
            )
            Ext.Print(LogPrefix .. "Player in existing-save. Reverting ItemCombos.txt")
        end
    end
end

--  ======================================================
Ext.RegisterListener("ModuleLoadStarted", RevertItemCombo)
--  ======================================================
