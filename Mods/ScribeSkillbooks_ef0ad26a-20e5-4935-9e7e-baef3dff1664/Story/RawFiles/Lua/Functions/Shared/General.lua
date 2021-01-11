--  ============
--  DISINTEGRATE
--  ============

---Disintegrate element into pieces
---@param element string|table
---@param separator string
function Disintegrate(element, separator)
    local pieces = {}
    local separator = separator or " "
    if type(element) ~= "string" and type(element) ~= "table" then return end
    if type(element) == "table" then return table.unpack(element) end
    for split in string.gmatch(element, "[^" .. separator .. "]+") do pieces[#pieces + 1] = split end
    return table.unpack(pieces)
end

--  =========
--  INTEGRATE
--  =========

--- Merge source and target. Existing source elements have priority.
---@param target table|string
---@param source table
---@return table source
function Integrate(target, source)
    local source = source or {}
    if type(target) ~= "table" then source[#source + 1] = target; return source end

    for key, value in pairs(target) do
        if type(value) == "table" then
            if not source[key] then source[key] = {} end
            source[key] = Integrate(value, source[key])
        elseif type(value) == "boolean" and source[key] == false then source[key] = false
        elseif type(value) == "string" and not ValidString(value) then source[key] = source[key]
        else source[key] = source[key] or value end
    end

    return source
end

--  =============
--  REMATERIALIZE
--  =============

--- Clone an element
---@param element any Element to copy
---@param config table Configuration table
---@return any element Rematerialized element
function Rematerialize(element, config, clones)
    config = Integrate({["metatables"] = false, ['nonstringifiable'] = false}, config)
    clones = clones or {}
    local clone = {}

    if type(element) == "table" then
        if clones[element] then clone = clones[element]
        else
            clone = {}
            clones[element] = clone
            for key, value in next, element do clone[Rematerialize(key, clones)] = Rematerialize(value, clones) end
            if config.metatables then setmetatable(clone, Rematerialize(getmetatable(element), clones)) end   --  Copy metatables
        end
    else clone = element end    --  if element is anything other than a table, return as is

    if type(element) == "function" or type(element) == "userdata" or type(element) == "thread" then
        if config.nonstringifiable then clone = element else clone = nil end
    end

    return clone
end
