module infinite_seas::roster_transfer_ship_inventory_logic {
    use aptos_framework::object::{Self, Object};

    use infinite_seas_common::item_id_quantity_pairs;
    use infinite_seas_common::item_id_quantity_pairs::ItemIdQuantityPairs;
    use infinite_seas_common::sorted_vector_util;

    use infinite_seas::pass_object;
    use infinite_seas::permission_util;
    use infinite_seas_player::player;
    use infinite_seas_player::player::Player;
    use infinite_seas::roster;
    use infinite_seas::ship;

    friend infinite_seas::roster_aggregate;

    public(friend) fun verify(
        account: &signer,
        player_obj: Object<Player>,
        from_ship_id: address,
        to_ship_id: address,
        item_id_quantity_pairs: ItemIdQuantityPairs,
        id: address,
        roster: &roster::Roster,
    ): roster::RosterShipInventoryTransferred {
        let player_id = object::object_address(&player_obj);
        let player_pass_obj = player::get_player(player_id);
        let player = player::borrow(&player_pass_obj);
        permission_util::assert_sender_is_player_owner(player, account);
        permission_util::assert_player_is_roster_owner(player_id, roster);
        //todo more checks?

        player::return_player(player_pass_obj);
        roster::new_roster_ship_inventory_transferred(
            id,
            roster,
            player_obj,
            from_ship_id,
            to_ship_id,
            item_id_quantity_pairs
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        roster_ship_inventory_transferred: &roster::RosterShipInventoryTransferred,
        id: address,
        roster: roster::Roster,
    ): roster::Roster {
        //let player_id = roster::roster_ship_inventory_transferred_player_id(roster_ship_inventory_transferred);
        let from_ship_id = roster::roster_ship_inventory_transferred_from_ship_id(roster_ship_inventory_transferred);
        let to_ship_id = roster::roster_ship_inventory_transferred_to_ship_id(roster_ship_inventory_transferred);
        let item_id_quantity_pairs = roster::roster_ship_inventory_transferred_item_id_quantity_pairs(
            roster_ship_inventory_transferred
        );
        //let roster_id = roster::roster_id(roster);

        //let ships = roster::borrow_mut_ships(roster);
        //let form_ship = object_table::borrow_mut(ships, from_ship_id);
        let from_ship_pass_obj = ship::get_ship(from_ship_id);
        let from_ship = ship::borrow_mut(&mut from_ship_pass_obj);
        let from_inv = ship::borrow_mut_inventory(from_ship);
        sorted_vector_util::subtract_item_id_quantity_pairs(
            from_inv,
            &item_id_quantity_pairs::items(&item_id_quantity_pairs)
        );

        //let to_ship = object_table::borrow_mut(ships, to_ship_id);
        let to_ship_pass_obj = ship::get_ship(to_ship_id);
        let to_ship = ship::borrow_mut(&mut to_ship_pass_obj);
        let to_inv = ship::borrow_mut_inventory(to_ship);
        sorted_vector_util::merge_item_id_quantity_pairs(
            to_inv,
            &item_id_quantity_pairs::items(&item_id_quantity_pairs)
        );

        ship::return_ship(from_ship_pass_obj);
        ship::return_ship(to_ship_pass_obj);
        roster
    }
}
