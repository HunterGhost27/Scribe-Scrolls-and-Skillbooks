--  =======
--  IMPORTS
--  =======

Ext.Require("Auxiliary.lua")
Ext.Require("Client/RecipeGenerator.lua")

--  ========================
--  ITEM COMBO PATH OVERRIDE
--  ========================

local function ItemComboPathOverride()
    if CENTRAL[IDENTIFIER]["ModSettings"]["LegacyCompatibilityMode"] then
        Debug:Warn("Legacy Compatibility Mode Active. Keeping old ItemCombos.txt")
    else
        Ext.AddPathOverride(
            "Public/ScribeSkillbooks_ef0ad26a-20e5-4935-9e7e-baef3dff1664/Stats/Generated/ItemCombos.txt",  --  Old ItemCombos
            "Public/ScribeSkillbooks_ef0ad26a-20e5-4935-9e7e-baef3dff1664/Stats/Override/ItemCombos.txt"    --  New ItemCombos
        )
    end
end

--  ============================================================
Ext.RegisterListener("ModuleLoadStarted", ItemComboPathOverride)
--  ============================================================

--  ==================
--  BROADCAST RESPONSE
--  ==================

local function onBroadcast(channel, payload)
    if channel == "S7_Scribe" then
        local msg, legacyCompMode = table.unpack(Ext.JsonParse(payload))

        if msg == "ToggleLegacyMode" then
            CENTRAL[IDENTIFIER]["ModSettings"]["LegacyCompatibilityMode"] = legacyCompMode
            CENTRAL[IDENTIFIER]["ModSettings"]["RecipeGeneration"] = not legacyCompMode
            Ext.SaveFile("S7Central.json", Ext.JsonStringify(CENTRAL))
            Debug:Print("LegacyMode: " .. tostring(legacyCompMode))
            Debug:Print("RecipeGenerator: " .. tostring(not legacyCompMode))
        end
    end
end

--  =============================================
Ext.RegisterNetListener("S7_Scribe", onBroadcast)
--  =============================================