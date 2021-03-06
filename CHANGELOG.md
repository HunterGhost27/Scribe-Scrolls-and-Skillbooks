# Scribe Scrolls and Skillbooks Changelog

----------

## [1.2.0.0] --- 13th January 2020 --- **_Luaification_**

### NEW

* _Added_ *BlankSkillbooks* to treasure-tables.

### CHANGED

* _Complete_ Luaification.
* _Fixed_ Scroll Scribing.

### REMOVED

* _Removed_ `ItemCombinator`.
* _Removed_ BlankSkillbook recipe. Will integrate into treasure-tables.

## [1.1.0.0] --- 27th November 2020 --- **_S7 CENTRALIZE_**

### NEW

* _Linked_ project to `S7Central`.
* _Created_ function to parse versioning information. -- Credits to LaughingLeader 💯
* _Added_ a check to disable `LegacyMode` on NewGame.
* _Created_ proper `ModVersioning`.

### CHANGED

* _Reverts_ to `LegacyCompatibilityMode` if player has an on-going playthrough.
* _Renamed_ `S7_Scriber` to `S7_RecipeGenerator` and split `ItemCombinator` into its own file.
* _Switched_ old and new `ItemCombo.txt` around. People without extender can continue using old files this way.
* _Recreated_ `ToggleLegacyMode` from scratch. <-- The mod (at this point) has roughly 350 all-time users. **all-time**. Will anyone even benefit from these shenanigans?

## [1.1.0.0] --- 8th November 2020 --- **_Scriber_**

### NEW

* _Moved_ `Scriber` to a new lua file. Gets imported to both `BootstrapClient` and `BootstrapServer`.
* _Started_ work on a third scribing method. Will not require creation of any recipes.

## [1.1.0.0] --- 29th October 2020 --- **_Finalized ItemCombo Creation_**

### NEW

* _Created_ `S7_Auxiliary.lua`
* _Created_ Osiris ModVersioning Scripts.
* Script to create scroll recipes.

### CHANGED

* _Moved_ support functions to `S7_Auxiliary.lua`

## [1.0.5.0] --- 28th October 2020 --- **_Script-Extender Initialized_**

### NEW

* _Initialized_ script-extender.
* _Delegated_ `ItemCombo` stat creation to `lua`.

## [1.0.2.0] --- 10th March 2020 --- *_Restoration Fix_*

### FIXES

* Fixed Restoration Skillbook recipe. Changed "SKILLBOOK_Water_RegenerateStart" to "SKILLBOOK_Water_Restoration". Cause of Confusion : Scroll was called "SCROLL_Water_RegenerateStart".

## [1.0.0.0] --- 8th March 2020 --- *_Public Release_*

### NEW

* Changed visibility of the mod on steam workshop to Public.

## [0.0.3.0] --- 5th March 2020 --- *_Removed Redundant Recipes_*

### REMOVED

* CuttingTool + Feather => Quill. Already included in Larian's Crafter-Kit Giftbag. Removed to avoid redundancy.

## [0.0.2.0] --- 4th March 2020 --- *_Steam Workshop Description_*

### NEW

* Wrote a description for the steam page. Updated thumbnail to look less depressing.

## [0.0.1.0] --- 3rd March 2020 --- *_INITIAL RELEASE_*

### NEW

* Added crafting recipes that allow players to copy scrolls and skillbooks.
