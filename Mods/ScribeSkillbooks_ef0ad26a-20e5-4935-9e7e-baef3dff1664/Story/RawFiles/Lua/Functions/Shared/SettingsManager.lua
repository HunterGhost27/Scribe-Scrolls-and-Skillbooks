--  ================
--  SETTINGS MANAGER
--  ================

MODINFO.ModSettings = {}

Settings = {}

function Settings:Sync()
    MODINFO.ModSettings = Rematerialize(self)
    PersistentVars.Settings = Rematerialize(self)
end

function Settings:Write(settings)
    local settings = settings or {}
    self = Integrate(self, settings)
    self:Sync()
end

--  ================================================
Ext.RegisterListener('SessionLoaded', Settings.Sync)
--  ================================================
