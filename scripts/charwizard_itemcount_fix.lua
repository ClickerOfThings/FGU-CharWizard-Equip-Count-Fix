local function processKitSelection(w)
	local sKey = w.windowlist.window.getKitType() .. "items";

	local tEquipment = CharWizardManager.character_choices["equipment"];
	if not tEquipment[sKey] then
		tEquipment[sKey] = {};
	end
	local _,sItemRecord = w.link.getValue();

	-- Searching for a count of a selected item
	local itemCount = 1;

    -- getting all records and compare them to the wanted item.
    -- we have to do it, since the item record doesn't have count field
	allRecords = w.windowlist.window.getAllRecords();

	for _, item in pairs(allRecords) do
		for _, item in pairs(item) do -- Items in the "allRecords" table, for some reason, have arrays inside of them
			if item.vNode.getPath() == sItemRecord then -- If the reference path are equal
				itemCount = item.nCount;
				break;
			end
		end
	end

	table.insert(tEquipment[sKey], { item = DB.findNode(sItemRecord), count = itemCount });

	w.windowlist.window.selection.setValue(w.name.getValue());
	w.windowlist.window.selectionlink.setValue(sItemRecord);
	w.windowlist.window.button_modify.setVisible(true);
	w.windowlist.setVisible(false);
	w.windowlist.window.sub_paging.setVisible(false);

	CharWizardEquipmentManager.onInventoryChanged(w);

	CharWizardManager.updateAlerts();
end

function onInit()
    CharWizardEquipmentManager.processKitSelection = processKitSelection
end