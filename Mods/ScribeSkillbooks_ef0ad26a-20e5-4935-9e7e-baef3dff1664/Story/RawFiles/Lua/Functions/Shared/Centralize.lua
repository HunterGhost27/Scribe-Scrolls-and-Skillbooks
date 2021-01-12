--  ==========
--  CENTRALIZE
--  ==========

CENTRAL = {}
CENTRAL.Template = {
    ["Author"] = MODINFO.Author,
    ["Name"] = MODINFO.Name,
    ["UUID"] = MODINFO.UUID,
    ["Version"] = MODINFO.Version,
    ["ModVersion"] = "0.0.0.0",
    ["ModSettings"] = {}
}

function CENTRAL:Load() CENTRAL = LoadFile('S7Central.json') or {} end
function CENTRAL:Sync() CENTRAL[IDENTIFIER] = Intersection(CENTRAL.Template, MODINFO) end
function CENTRAL:Save() SaveFile('S7Central.json', CENTRAL) end

function CENTRAL:ReSync()
    self:Load()
    self:Sync()
    self:Save()
end
