module infinite_seas_common::inventory_entry_util {
    use std::vector;

    use infinite_seas_common::inventory_entry;
    use infinite_seas_common::inventory_entry::InventoryEntry;
    use infinite_seas_common::item_id_quantity_pair::ItemIdQuantityPair;

    public fun new_plus_inventory_entries(items: vector<ItemIdQuantityPair>): vector<InventoryEntry> {
        new_inventory_entries_from_item_id_quantity_pairs(items, 0)
    }

    public fun new_minus_inventory_entries(items: vector<ItemIdQuantityPair>): vector<InventoryEntry> {
        new_inventory_entries_from_item_id_quantity_pairs(items, 1)
    }

    fun new_inventory_entries_from_item_id_quantity_pairs(
        items: vector<ItemIdQuantityPair>,
        sign: u8
    ): vector<InventoryEntry> {
        let inventory_entries = vector::empty<InventoryEntry>();
        let items = items;
        let i = 0;
        let l = vector::length(&items);
        while (i < l) {
            let item = vector::borrow(&items, i);
            vector::push_back(&mut inventory_entries, inventory_entry::new(*item, sign));
            i = i + 1;
        };
        inventory_entries
    }
}