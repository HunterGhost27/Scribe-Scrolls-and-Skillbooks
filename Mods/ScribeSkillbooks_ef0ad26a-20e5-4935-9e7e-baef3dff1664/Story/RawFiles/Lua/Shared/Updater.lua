--  ===========
--  MOD-UPDATER
--  ===========

local prevVersion = {[1] = 0, [2] = 0, [3] = 0, [4] = 0}
if CENTRAL[IDENTIFIER] and CENTRAL[IDENTIFIER]["Version"] then prevVersion = ParseVersion(CENTRAL[IDENTIFIER]["Version"], "table") end
local currVersion = ParseVersion(MODINFO.Version, "table")

--- Mod Update Logic
---@param oldVersion table
---@param newVersion table
---@param forceUpdate boolean
local function ModUpdater(oldVersion, newVersion, forceUpdate)
    local isUpdatedRequired = false
    local forceUpdate = forceUpdate or false

    for k, _ in ipairs(newVersion) do
        if newVersion[k] == oldVersion[k] then
        else
            isUpdatedRequired = newVersion[k] > oldVersion[k]
            break
        end
    end

    if isUpdatedRequired or forceUpdate then
        Debug:HFPrint("Updating " .. IDENTIFIER .. ": " .. ParseVersion(oldVersion, "string") .. " --> " .. ParseVersion(newVersion, "string"))
        --  ===============
        --  DO UPDATE STUFF
        --  ===============
    end
end

--  ================================
ModUpdater(prevVersion, currVersion)
--  ================================