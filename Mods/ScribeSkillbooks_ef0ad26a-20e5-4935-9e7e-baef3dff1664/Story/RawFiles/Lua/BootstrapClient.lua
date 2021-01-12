--  =======
--  IMPORTS
--  =======

Ext.Require("Auxiliary.lua")
if CENTRAL[IDENTIFIER]["ModSettings"]["RecipeGeneration"] then Ext.Require("Client/RecipeGenerator.lua") end
if CENTRAL[IDENTIFIER]["ModSettings"]["LegacyCompatibilityMode"] then Ext.Require("Client/LegacyCompatibilityMode.lua") end
