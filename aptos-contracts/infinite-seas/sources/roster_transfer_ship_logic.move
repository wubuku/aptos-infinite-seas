module infinite_seas::roster_transfer_ship_logic {
    use std::option::{Self, Option};
    use std::vector;
    use aptos_framework::object::{Self, Object};

    use infinite_seas_common::ship_util;

    use infinite_seas::pass_object;
    use infinite_seas::permission_util;
    use infinite_seas::player;
    use infinite_seas::player::Player;
    use infinite_seas::roster::{Self, Roster};
    use infinite_seas::roster_util;

    friend infinite_seas::roster_aggregate;

    const EShipNotFoundInSourceRoster: u64 = 10;
    const ERostersTooFarAway: u64 = 11;

    public(friend) fun verify(
        account: &signer,
        player_obj: Object<Player>,
        ship_id: address,
        to_roster_obj: Object<Roster>,
        to_position: Option<u64>,
        id: address,
        roster: &roster::Roster,
    ): roster::RosterShipTransferred {
        let player_id = object::object_address(&player_obj); // Player Object Address
        let player_pass_obj = player::get_player(player_id);
        let player = pass_object::borrow(&player_pass_obj);

        let to_roster_obj_addr = object::object_address(&to_roster_obj);
        let to_roster_pass_obj = roster::get_roster(to_roster_obj_addr);
        let to_roster = pass_object::borrow(&to_roster_pass_obj);

        permission_util::assert_sender_is_player_owner(player, account);
        permission_util::assert_player_is_roster_owner(player_id, roster);
        permission_util::assert_player_is_roster_owner(player_id, to_roster);
        assert!(roster_util::are_rosters_close_enough_to_transfer(roster, to_roster), ERostersTooFarAway);
        roster_util::assert_roster_ships_not_full(to_roster);

        player::return_player(player_pass_obj);
        roster::return_roster(to_roster_pass_obj);
        roster::new_roster_ship_transferred(id, roster, player_obj, ship_id, to_roster_obj, to_position)
    }

    public(friend) fun mutate(
        _account: &signer,
        roster_ship_transferred: &roster::RosterShipTransferred,
        id: address,
        roster: roster::Roster,
    ): roster::Roster {
        //let player_id = roster::roster_ship_transferred_player_id(roster_ship_transferred);
        let ship_id = roster::roster_ship_transferred_ship_id(roster_ship_transferred);
        let to_roster_object = roster::roster_ship_transferred_to_roster(roster_ship_transferred);
        let to_position = roster::roster_ship_transferred_to_position(roster_ship_transferred);

        let from_roster = roster;
        let from_ship_ids = roster::ship_ids(&mut from_roster);
        ship_util::remove_ship_id(&mut from_ship_ids, ship_id);
        roster::set_ship_ids(&mut from_roster, from_ship_ids);

        //let from_ships = roster::borrow_mut_ships(from_roster);
        //assert!(object_table::contains(from_ships, ship_id), EShipNotFoundInSourceRoster);
        //let ship = object_table::remove(from_ships, ship_id);

        let speed = roster_util::calculate_roster_speed(&mut from_roster);
        roster::set_speed(&mut from_roster, speed);

        let to_roster_object_addr = object::object_address(&to_roster_object);
        let to_roster_pass_obj = roster::get_roster(to_roster_object_addr);
        let to_roster = roster::borrow_mut(&mut to_roster_pass_obj);
        let to_ship_ids = roster::ship_ids(to_roster);

        if (option::is_some(&to_position)) {
            vector::insert(&mut to_ship_ids, option::extract(&mut to_position), ship_id);
        } else {
            vector::push_back(&mut to_ship_ids, ship_id);
        };
        roster::set_ship_ids(to_roster, to_ship_ids);

        //let to_ships = roster::borrow_mut_ships(to_roster);
        //object_table::add(to_ships, ship_id, ship);

        //TODO object::transfer()

        let speed = roster_util::calculate_roster_speed(to_roster);
        roster::set_speed(to_roster, speed);

        roster::return_roster(to_roster_pass_obj);

        from_roster
    }
}
