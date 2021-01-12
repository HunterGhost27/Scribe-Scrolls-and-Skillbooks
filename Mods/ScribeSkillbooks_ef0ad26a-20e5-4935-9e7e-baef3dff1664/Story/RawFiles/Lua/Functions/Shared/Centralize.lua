--  ==========
--  CENTRALIZE
--  ==========

CENTRAL = {}
CENTRAL[IDENTIFIER] = {
    ["Author"] = MODINFO.Author,
    ["Name"] = MODINFO.Name,
    ["UUID"] = MODINFO.UUID,
    ["Version"] = MODINFO.Version,
    ["ModVersion"] = "0.0.0.0",
    ["ModSettings"] = {}
}

function CENTRAL:Load() self = Integrate(self, LoadFile('S7Central.json')) end
function CENTRAL:Sync() self[IDENTIFIER] = Intersection(self[IDENTIFIER], MODINFO) end
function CENTRAL:Save() SaveFile('S7Central.json', Rematerialize(self)) end

function CENTRAL:ReSync()
    self:Load()
    self:Sync()
    self:Save()
end
