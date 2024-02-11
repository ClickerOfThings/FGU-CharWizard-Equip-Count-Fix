# FGU Character Wizard Equipment Count Fix

This repository contains Lua code for Fantasy Grounds Unity, which fixes item counting when adding starting equipment. This extension is for D&D 5E only.

Originally, the Lua code for adding chosen items in a starting equipment made every items' count equal to 1. This extension fixes this bug.

## How to install

This is a FGU extension, so it is easy to add it into your campaigns.

* Download the [archive of this repository](https://github.com/ClickerOfThings/FGU-CharWizard-Equip-Count-Fix/archive/refs/heads/main.zip)
* Rename the extension to `.ext`, OR unpack the contents in any folder
* Navigate into your FGU data folder, find the subfolder `extensions`, and move the `.ext` file or the unpacked folder in there

  Default paths for data folders:

  * Windows 10/11: `C:\Users\[username]\AppData\Roaming\SmiteWorks\Fantasy Grounds\`
  * macOS: `/Users/[username]/SmiteWorks/Fantasy Grounds/`
  * Linux: `/home/[username]/.smiteworks/fgdata/`
* Choose the "CharWizard Item Count Fix" from the Extensions list.

## How to use

This extension fixes the bug in the character wizard. Now, when you choose, for example, the rogue class, you will have 2 daggers in your starting equipment, not 1 as it originally was.

## What this extension is all about

In the script, I redeclare a function `CharWizardEquipmentManager.processKitSelection` with my own version. In there, I search for a selected item, which will be inserted into the starting equipment list, in all records (since it is the only place from inside this function where the item's count is stored), and just save count variable, which is then passed to the `table.insert` function.

Originally, the code just did this:
```lua
table.insert(tEquipment[sKey], { item = DB.findNode(sItemRecord), count = 1 });
```
Where the count is hard-coded equal to 1. So I added some processing before that to ensure correct item count.
It means that anti paladin, barbarian, fighter, paladin, ranger, rogue, sorcerer and warlock classes will have their items with count greater than 1 to be added correctly (this also applies to other classes, even homebrew one, where their equipment is added to the `charwizard_starting_equipment` variable in the `CharWizardData` class)