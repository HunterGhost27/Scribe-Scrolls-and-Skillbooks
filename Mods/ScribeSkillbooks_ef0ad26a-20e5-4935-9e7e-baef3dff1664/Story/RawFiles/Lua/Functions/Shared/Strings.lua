--  =========================
--  VALIDATE NON-EMPTY STRING
--  =========================

--- Check validity of string.
---@param str any
function ValidString(str)
    if type(str) == "string" and str ~= "" and str ~= "{}" and str ~= "[]" then return true
    else return false end
end

--  ======
--  COLORS
--  ======

Color = {
    ["black"] = "#000000",
    ["red"] = "#E03616",
    ["blue"] = "#5998C5",
    ["green"] = "#3F784C",
    ["yellow"] = "#FFFF00",
    ["orange"] = "#C17817",
    ["violet"] = "#58355E",
    ["gold"] = "#C7A758",
    ["white"] = "#FFFFFF",
    ["air"] = "#7478DC",
    ["earth"] = "#AA895B",
    ["fire"] = "#C76537",
    ["necromancy"] = "#9A5085",
    ["polymorph"] = "#FFB811",
    ["ranger"] = "#5A9646",
    ["rogue"] = "#566C6C",
    ["source"] = "#6EB09D",
    ["summoning"] = "#9440B3",
    ["warrior"] = "#A11919",
    ["water"] = "#579CCA",
}

local function addFontTags(color, str) return "<font color=\'" .. color .. "\'>" .. tostring(str) .. "</font>" end

function Color:Red(str) return addFontTags(self.red, str) end
function Color:Blue(str) return addFontTags(self.blue, str) end
function Color:Green(str) return addFontTags(self.green, str) end
function Color:Black(str) return addFontTags(self.black, str) end
function Color:White(str) return addFontTags(self.white, str) end
function Color:Yellow(str) return addFontTags(self.yellow, str) end
function Color:Orange(str) return addFontTags(self.orange, str) end
function Color:Violet(str) return addFontTags(self.violet, str) end
function Color:Gold(str) return addFontTags(self.gold, str) end

function Color:Air(str) return addFontTags(self.air, str) end
function Color:Earth(str) return addFontTags(self.earth, str) end
function Color:Fire(str) return addFontTags(self.fire, str) end
function Color:Necromancy(str) return addFontTags(self.necromancy, str) end
function Color:Polymorph(str) return addFontTags(self.polymorph, str) end
function Color:Ranger(str) return addFontTags(self.ranger, str) end
function Color:Rogue(str) return addFontTags(self.rogue, str) end
function Color:Source(str) return addFontTags(self.source, str) end
function Color:Summoning(str) return addFontTags(self.summoning, str) end
function Color:Warrior(str) return addFontTags(self.warrior, str) end
function Color:Water(str) return addFontTags(self.water, str) end
