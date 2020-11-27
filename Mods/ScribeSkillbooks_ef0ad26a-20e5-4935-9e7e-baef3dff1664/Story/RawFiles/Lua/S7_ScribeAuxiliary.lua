
--  ---------------------------------
IDENTIFIER = "S7_Scribe" -- ModPrefix
--  ---------------------------------

--  ===============
--  MOD INFORMATION
--  ===============

ModInfo = Ext.GetModInfo("ef0ad26a-20e5-4935-9e7e-baef3dff1664")    --  fetch ModInformation

CENTRAL = {}    --  Holds Global Settings and Information
local file = Ext.LoadFile("S7Central.json") or ""
if file ~= nil and file ~= "" then
    CENTRAL = Ext.JsonParse(file)
end

if CENTRAL[IDENTIFIER] == nil then
    CENTRAL[IDENTIFIER] = {} -- Initialize Mod's Global Settings Profile
    for k, v in pairs(ModInfo) do
        CENTRAL[IDENTIFIER][k] = v
    end
    CENTRAL[IDENTIFIER]["ModSettings"] = {}
    Ext.SaveFile("S7Central.json", Ext.JsonStringify(CENTRAL))
end

--  ==============
--  MOD VERSIONING
--  ==============

function ParseVersion(version, returnMode)
    local major, minor, revision, build = 0, 0, 0, 0

    if type(version) == "string" then
        if string.gmatch(version, "[^.]+") ~= nil then
            local tbl = {}
            for v in string.gmatch(version, "[^.]+") do
                tbl[#tbl+1] = v
            end
            major, minor, revision, build = table.unpack(tbl)
        else
            version = math.floor(tonumber(version))
            ParseVersion(version)
        end
	elseif type(version) == "number" then
		version = math.tointeger(version)
        major = math.floor(version >> 28)
        minor = math.floor(version >> 24) & 0x0F
        revision = math.floor(version >> 16) & 0xFF
        build = math.floor(version & 0xFFFF)
	end

    local versionTable = table.pack(major, minor, revision, build)

    if returnMode == "table" then
        return versionTable
    elseif returnMode == "string" then
        return string.format("%s.%s.%s.%s", major, minor, revision, build)
    else
        return major, minor, revision, build
    end
end

--  ================
--  EXCEPTIONS TABLE
--  ================

ScribeException = {
    --  list of all stats to ignore
    ["SKILLBOOK_AbilityPoint"] = true,
    ["SKILLBOOK_StatPoint"] = true
}

--  ==============
--  COMBO TEMPLATE
--  ==============

Combo = {}

function ReinitCombo() --  Resets combo table to initial values
    Combo = {
        ["AutoLevel"] = false,
        ["CraftingStation"] = "None",
        ["Ingredients"] = {},
        ["Name"] = "",
        ["RecipeCategory"] = "Grimoire",
        ["Results"] = {}
    }
end

ReinitCombo() --  Initialize combo

--  ================================
--  DETERMINE APPROPRIATE SKILLBOOK
--  ================================

function DetermineSkillbook(stat) --  Determine the school and tier of blank skillbook required
    local tier = "Blank_Step2_A" --   Tier 2 by default

    local school = "WarriorRogueRanger" --  Generic blank skillbook by default

    local iterSchool = {
        --  Valid Schools (except WarriorRogueRanger)
        "Air",
        "Water",
        "Fire",
        "Earth",
        "Polymorph",
        "Necromancy",
        "Summoning"
    }

    if stat.ObjectCategory ~= nil then --  if ObjectCategory exists
        if string.match(stat.ObjectCategory, "Starter") or string.match(stat.ObjectCategory, "Early") then
            tier = "Blank_A" --  If Object Category is Starter or Early then set Tier 1
        end

        for _, element in ipairs(iterSchool) do
            if string.match(stat.Name, element) or string.match(stat.ObjectCategory, element) then
                school = element --   Get School name
            end
        end
    end

    if school == "WarriorRogueRanger" then
        tier = "Blank_A" -- As there is no tier 2 for Generic Blank Skillbooks reset tier to 1
    end

    return "BOOK_Skill_" .. school .. "_" .. tier --  Return Skillbook
end

--  ====
--  VARS
--  ====

LogSource = "ScribeAuxiliary"
LogPrefix = "[" .. IDENTIFIER .. ":Lua:" .. LogSource .. "] --- " --  All logs start with this prefix.
TotalCount = 0 -- Variable to track the number of recipes created.
