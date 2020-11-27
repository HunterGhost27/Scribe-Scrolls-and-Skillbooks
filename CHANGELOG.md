# Scribe Scrolls and Skillbooks Changelog

----------

## [1.1.0.0] --- 27th November 2020 --- **_S7 CENTRALIZE_**

### NEW

* _Linked_ project to `S7Central`.
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
