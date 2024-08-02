module infinite_seas::roster_set_sail_logic {
    use std::option;
    use std::vector;
    use std::signer;

    use aptos_framework::object;
    use aptos_framework::object::Object;
    use aptos_framework::timestamp;

    use infinite_seas_common::coordinates::Coordinates;
    use infinite_seas_common::roster_status;
    use infinite_seas_common::speed_util;

    use infinite_seas::pass_object;
    use infinite_seas::permission_util;
    use infinite_seas_player::player;
    use infinite_seas_player::player::Player;
    use infinite_seas::roster;
    use infinite_seas::roster_util;

    friend infinite_seas::roster_aggregate;

    const ERosterUnfitToSail: u64 = 10;
    const ENotEnoughEnergy: u64 = 11;
    const EIllegalSailDuration: u64 = 12;
    const EInvalidUpdatedCoordinates: u64 = 101;

    const ENERGY_AMOUNT_PER_SECOND_PER_SHIP: u64 = 1388889;

    public(friend) fun verify(
        account: &signer,
        player_obj: Object<Player>,
        target_coordinates: Coordinates,
        sail_duration: u64,
        updated_coordinates: Coordinates,
        id: address,
        roster: &roster::Roster,
    ): roster::RosterSetSail {
        let player_addr = object::object_address(&player_obj);
        let player_pass_obj = player::get_player(player_addr);
        let player = player::borrow(&player_pass_obj);
        permission_util::assert_sender_is_player_owner(player, account);
        permission_util::assert_player_is_roster_owner(player_addr, roster);
        roster_util::assert_roster_is_not_unassigned_ships(roster);
        roster_util::assert_roster_ships_not_empty(roster);

        let new_updated_coordinates: Coordinates; // current location of the roster
        let status = roster::status(roster);
        if (status == roster_status::at_anchor()) {
            new_updated_coordinates = roster::updated_coordinates(roster);
        } else if (status == roster_status::underway()) {
            //let (_updated_coordinates, _coordinates_updated_at, _new_status) = roster_util::calculate_current_location(
            //    roster, clock
            //);
            // new_updated_coordinates = _updated_coordinates;
            let (updatable, _coordinates_updated_at, _new_status)
                = roster_util::is_current_location_updatable(roster, //clock,
                updated_coordinates
            );
            if (updatable) {
                new_updated_coordinates = updated_coordinates;
            } else {
                // new_updated_coordinates = roster::updated_coordinates(roster);
                abort EInvalidUpdatedCoordinates
            };
        } else {
            abort ERosterUnfitToSail
        };
        let energy_cost = 10000000000000;//TODO balance::value(energy);
        let total_time = speed_util::calculate_total_time(new_updated_coordinates, target_coordinates,
            roster::speed(roster));
        assert!(sail_duration >= total_time, EIllegalSailDuration);
        let ship_count = vector::length(roster::borrow_ship_ids(roster));
        //assert!(energy_cost >= MIN_SAIL_ENERGY, ENotEnoughEnergy);
        assert!(energy_cost >= total_time * ship_count * ENERGY_AMOUNT_PER_SECOND_PER_SHIP, ENotEnoughEnergy);
        let set_sail_at = timestamp::now_seconds();//clock::timestamp_ms(clock) / 1000;
        player::return_player(player_pass_obj);
        roster::new_roster_set_sail(id, roster, player_obj, target_coordinates, sail_duration, set_sail_at,
            new_updated_coordinates, energy_cost)
    }

    public(friend) fun mutate(
        _account: &signer,
        roster_set_sail: &roster::RosterSetSail,
        id: address,
        roster: roster::Roster,
    ): roster::Roster {
        //TODO let energy_cost = roster::roster_set_sail_energy_cost(roster_set_sail);
        let target_coordinates = roster::roster_set_sail_target_coordinates(roster_set_sail);
        let set_sail_at = roster::roster_set_sail_set_sail_at(roster_set_sail);
        let updated_coordinates = roster::roster_set_sail_updated_coordinates(roster_set_sail);
        let sail_duration = roster::roster_set_sail_sail_duration(roster_set_sail);

        roster::set_updated_coordinates(&mut roster, updated_coordinates); // update current location first
        roster::set_target_coordinates(&mut roster, option::some(target_coordinates));
        roster::set_origin_coordinates(&mut roster, option::some(updated_coordinates));
        roster::set_coordinates_updated_at(&mut roster, set_sail_at);
        if (target_coordinates != updated_coordinates) {
            roster::set_status(&mut roster, roster_status::underway());
        } else {
            roster::set_status(&mut roster, roster_status::at_anchor());
        };
        roster::set_sail_duration(&mut roster, sail_duration);
        //TODO let energy_vault = roster::borrow_mut_energy_vault(roster);
        //balance::join(energy_vault, energy);

        roster
    }
}
