--  ===========
--  MOD-UPDATER
--  ===========

Updater = {
    ['isUpdateRequired'] = false,
    ['forceUpdate'] = false,
    ['Updates'] = {}
}

---Register Update Event Action
---@param event string Listener Event or `"Now"`
---@param action function Update Action
function Updater:Register(event, action) table.insert(self.Updates, {[event] = action}) end

---Checks for Update
---@param oldVer string OldVersion
---@param newVer string NewVersion
---@param forceUpdate boolean Force Update To Occur
function Updater:Check(oldVer, newVer, forceUpdate)
    self.isUpdateRequired = false
    self.forceUpdate = forceUpdate or false
    local oldVersion = Version:Parse(oldVer)
    local newVersion = Version:Parse(newVer)
    if newVersion:IsNewerThan(oldVer) then self.isUpdateRequired = true end
    if self.isUpdateRequired or self.forceUpdate then self:Update(oldVersion, newVersion) end
end

---Update
---@param oldVersion Version
---@param newVersion Version
function Updater:Update(oldVersion, newVersion)
    Debug:HFPrint("Updating " .. IDENTIFIER .. ": " .. oldVersion:String() .. " --> " .. newVersion:String())

    for idx, update in pairs(self.Updates) do
        if update.event == "Now" then update.action()
        else Ext.RegisterListener(update.event, update.action) end
        self.Updates[idx] = nil
    end

    self.isUpdateRequired = false
    self.forceUpdate = false
end

--  =============
--  INITIAL CHECK
--  =============

CENTRAL:Load()
local prevVersion = Version:Parse(CENTRAL[IDENTIFIER]["Version"])
local currVersion = Version:Parse(MODINFO.Version)
Updater:Check(prevVersion, currVersion)
CENTRAL:Sync()
CENTRAL:Save()