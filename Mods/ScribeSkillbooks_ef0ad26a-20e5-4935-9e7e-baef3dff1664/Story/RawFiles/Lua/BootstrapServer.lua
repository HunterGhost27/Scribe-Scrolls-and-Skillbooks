--  =======
--  IMPORTS
--  =======

Ext.Require("Auxiliary.lua")
if not MODINFO.ModSettings["RecipeGeneration"] then Ext.Require("Server/ItemCombinator.lua") end
if Ext.IsDeveloperMode() then Ext.Require('Server/Debug.lua') end