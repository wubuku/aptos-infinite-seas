module infinite_seas::roster_take_out_ship_inventory_logic {
    use std::vector;
    use aptos_framework::object::{Self, Object};
    use infinite_seas::ship::Ship;

    use infinite_seas_common::coordinates::Coordinates;
    use infinite_seas_common::item_id::ship;
    use infinite_seas_common::item_id_quantity_pairs;
    use infinite_seas_common::item_id_quantity_pairs::ItemIdQuantityPairs;
    use infinite_seas_common::roster_status;
    use infinite_seas_common::sorted_vector_util;

    use infinite_seas::pass_object;
    use infinite_seas::permission_util;
    use infinite_seas::player;
    use infinite_seas::player::Player;
    use infinite_seas::roster;
    use infinite_seas::roster_util;
    use infinite_seas::ship;

    friend infinite_seas::roster_aggregate;

    const EShipNotOwnedByRoster: u64 = 101;
    const EShipIdNotInRoster: u64 = 102;

    public(friend) fun verify(
        account: &signer,
        player_obj: Object<Player>,
        ship_id: address,
        item_id_quantity_pairs: ItemIdQuantityPairs,
        updated_coordinates: Coordinates,
        id: address,
        roster: &mut roster::Roster,
    ): roster::RosterShipInventoryTakenOut {
        let player_id = object::object_address(&player_obj);
        let player_pass_obj = player::get_player(player_id);
        let player = pass_object::borrow(&player_pass_obj);
        permission_util::assert_sender_is_player_owner(player, account);
        permission_util::assert_player_is_roster_owner(player_id, roster);
        roster_util::assert_roster_is_not_unassigned_ships(roster); // Is this necessary?
        assert!(object::is_owner(object::address_to_object<Ship>(ship_id), id), EShipNotOwnedByRoster);
        assert!(vector::contains(&roster::ship_ids(roster), &ship_id), EShipIdNotInRoster);

        // Check if the ship has anchored at the island
        if (roster::status(roster) == roster_status::underway()) {
            // let (updated_coordinates, coordinates_updated_at, new_status)
            //     = roster_util::calculate_current_location(roster, clock);
            let (updatable, coordinates_updated_at, new_status)
                = roster_util::is_current_location_updatable(roster, //clock,
                updated_coordinates);
            if (updatable) {
                roster::set_updated_coordinates(roster, updated_coordinates);
                roster::set_coordinates_updated_at(roster, coordinates_updated_at);
                roster::set_status(roster, new_status);
            }
        };
        roster_util::assert_roster_is_anchored_at_claimed_island(roster, player);
        player::return_player(player_pass_obj);
        roster::new_roster_ship_inventory_taken_out(
            id,
            roster,
            player_obj,
            ship_id,
            item_id_quantity_pairs,
            updated_coordinates
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        roster_ship_inventory_taken_out: &roster::RosterShipInventoryTakenOut,
        id: address,
        roster: roster::Roster,
    ): roster::Roster {
        let player_obj = roster::roster_ship_inventory_taken_out_player_id(roster_ship_inventory_taken_out);
        let ship_id = roster::roster_ship_inventory_taken_out_ship_id(roster_ship_inventory_taken_out);
        let item_id_quantity_pairs = roster::roster_ship_inventory_taken_out_item_id_quantity_pairs(
            roster_ship_inventory_taken_out
        );
        //let roster_id = roster::roster_id(roster);
        //let ships = roster::borrow_mut_ships(roster);
        //let ship = object_table::borrow_mut(ships, ship_id);
        let ship_pass_obj = ship::get_ship(ship_id);
        let ship = ship::borrow_mut(&mut ship_pass_obj);
        let ship_inv = ship::borrow_mut_inventory(ship);

        let player_pass_obj = player::get_player(object::object_address(&player_obj));
        let player = player::borrow_mut(&mut player_pass_obj);
        let player_inv = player::borrow_mut_inventory(player);
        let items = item_id_quantity_pairs::items(&item_id_quantity_pairs);
        let i = 0;
        let l = vector::length(&items);
        while (i < l) {
            let item = vector::borrow(&items, i);
            sorted_vector_util::subtract_item_id_quantity_pair(ship_inv, *item); // - item from ship
            sorted_vector_util::insert_or_add_item_id_quantity_pair(player_inv, *item); // + item to player
            i = i + 1;
        };

        ship::return_ship(ship_pass_obj);
        player::return_player(player_pass_obj);
        roster
    }
}
