--  ========================
--  ITEM COMBO PATH OVERRIDE
--  ========================

Ext.RegisterListener("ModuleLoadStarted", function ()
    if MODINFO.ModSettings['LegacyCompatibilityMode'] then
        Debug:HFWarn("Legacy Compatibility Mode Active. Keeping old ItemCombos.txt")
    else
        Ext.AddPathOverride(
            "Public/ScribeSkillbooks_ef0ad26a-20e5-4935-9e7e-baef3dff1664/Stats/Generated/ItemCombos.txt",  --  Old ItemCombos
            "Public/ScribeSkillbooks_ef0ad26a-20e5-4935-9e7e-baef3dff1664/Stats/Override/ItemCombos.txt"    --  New ItemCombos
        )
    end
end)
