module infinite_seas_player::player_properties {
    use std::vector;

    use infinite_seas_common::inventory_entry;
    use infinite_seas_common::inventory_entry::InventoryEntry;
    use infinite_seas_common::item_id_quantity_pair;
    use infinite_seas_common::item_id_quantity_pair::ItemIdQuantityPair;
    use infinite_seas_common::sorted_vector_util;

    use infinite_seas_player::player;
    use infinite_seas_player::player::Player;

    friend infinite_seas_player::player_gather_island_resources_logic;
    friend infinite_seas_player::player_update_logic;

    //     public(friend) fun increase_experience_and_inventory_and_set_level(
    //         player: &mut Player,
    //         increased_experience: u32,
    //         items: vector<ItemIdQuantityPair>,
    //         level: u16
    //     ) {
    //         increase_experience(player, increased_experience);
    //         increase_inventory(player, items);
    //         set_level(player, level);
    //     }

    //     // public(friend) fun borrow_mut_player(player_pass_obj: &mut pass_object::PassObject<Player>): &mut Player {
    //     //     player::borrow_mut(player_pass_obj)
    //     // }

    public(friend) fun modify_inventory(player: &mut Player, items: &vector<InventoryEntry>) {
        let i = 0;
        let l = vector::length(items);
        let inv = player::borrow_mut_inventory(player);
        while (i < l) {
            let entry = vector::borrow(items, i);
            let item_id_and_quantity = inventory_entry::item_id_and_quantity(entry);
            let item_id = item_id_quantity_pair::item_id(&item_id_and_quantity);
            let quantity = item_id_quantity_pair::quantity(&item_id_and_quantity);
            let sign = inventory_entry::sign(entry);
            if (sign == 0) {
                sorted_vector_util::insert_or_add_item_id_quantity_pair(
                    inv,
                    item_id_quantity_pair::new(item_id, quantity)
                );
            } else if (sign == 1) {
                sorted_vector_util::subtract_item_id_quantity_pair(inv, item_id_quantity_pair::new(item_id, quantity));
            };
            i = i + 1;
        };
    }

    public(friend) fun deduct_inventory(player: &mut Player, items: vector<ItemIdQuantityPair>) {
        let inv = player::borrow_mut_inventory(player);
        let i = 0;
        let l = vector::length(&items);
        while (i < l) {
            let item = vector::borrow(&items, i);
            // let item_id = item_id_quantity_pair::item_id(item);
            // let quantity = item_id_quantity_pair::quantity(item);
            sorted_vector_util::subtract_item_id_quantity_pair(inv, *item);
            i = i + 1;
        };
    }

    public(friend) fun increase_inventory(player: &mut Player, items: vector<ItemIdQuantityPair>) {
        let i = 0;
        let l = vector::length(&items);
        while (i < l) {
            let item = vector::borrow(&items, i);
            let item_id = item_id_quantity_pair::item_id(item);
            let quantity = item_id_quantity_pair::quantity(item);
            increase_player_item_quantity(player, item_id, quantity);
            i = i + 1;
        };
    }

    public(friend) fun increase_player_item_quantity(player: &mut player::Player, item_id: u32, quantity: u32) {
        let inv = player::borrow_mut_inventory(player);
        sorted_vector_util::insert_or_add_item_id_quantity_pair(inv, item_id_quantity_pair::new(item_id, quantity));
    }

    public(friend) fun increase_experience(player: &mut Player, increased_experience: u32) {
        let old_experience = player::experience(player);
        player::set_experience(player, old_experience + increased_experience);
    }

    public(friend) fun set_level(player: &mut Player, level: u16) {
        player::set_level(player, level);
    }
}
