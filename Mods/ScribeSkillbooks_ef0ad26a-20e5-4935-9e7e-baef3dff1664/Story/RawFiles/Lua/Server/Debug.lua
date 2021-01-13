--  ==========
--  DEBUG MODE
--  ==========

local function DebugMode()
    local host = Osi.CharacterGetHostCharacter()
    Osi.ItemTemplateAddTo(Template.LOOT_Ink_Pot_A_Quill_A, host, 1, 1)
    Osi.ItemTemplateAddTo(Template.BOOK_Paper_Sheet_A, host, 50, 1)
    Osi.CharacterAddAbilityPoint(host, 10)
    Osi.CharacterAddSkill(host, 'Target_Apportation', 1)
end

ConsoleCommander:Register({
    ['Name'] = 'DebugMode',
    ['Description'] = "Adds an assortment of debug-items",
    ['Action'] = DebugMode,
    ['Context'] = 'Server'
})