module infinite_seas::roster_adjust_ships_position_logic {
    use std::option;
    use std::vector;
    use aptos_framework::object::{Self, Object};

    use infinite_seas_common::ship_util;

    use infinite_seas::pass_object;
    use infinite_seas::permission_util;
    use infinite_seas_player::player;
    use infinite_seas_player::player::Player;
    use infinite_seas::roster;

    friend infinite_seas::roster_aggregate;

    const EShipIdsAndPositionsLengthMismatch: u64 = 10;
    const EShipIdNotFound: u64 = 11;

    public(friend) fun verify(
        account: &signer,
        player_obj: Object<Player>,
        positions: vector<u64>,
        ship_ids: vector<address>,
        id: address,
        roster: &roster::Roster,
    ): roster::RosterShipsPositionAdjusted {
        let player_obj_addr = object::object_address(&player_obj);
        let player_pass_obj = player::get_player(player_obj_addr);
        let player = player::borrow(&player_pass_obj);
        permission_util::assert_sender_is_player_owner(player, account);
        permission_util::assert_player_is_roster_owner(player_obj_addr, roster);
        assert!(vector::length(&ship_ids) == vector::length(&positions), EShipIdsAndPositionsLengthMismatch);
        player::return_player(player_pass_obj);
        roster::new_roster_ships_position_adjusted(id, roster, player_obj, positions, ship_ids)
    }

    public(friend) fun mutate(
        _account: &signer,
        roster_ships_position_adjusted: &roster::RosterShipsPositionAdjusted,
        id: address,
        roster: roster::Roster,
    ): roster::Roster {
        let player_id = roster::roster_ships_position_adjusted_player_id(roster_ships_position_adjusted);

        let new_positions = roster::roster_ships_position_adjusted_positions(roster_ships_position_adjusted);
        let adjusted_ship_ids = roster::roster_ships_position_adjusted_ship_ids(roster_ships_position_adjusted);
        let i = 0;
        let l = vector::length(&new_positions);
        let roster_ship_ids = roster::ship_ids(&mut roster);
        while (i < l) {
            let ship_id = *vector::borrow(&adjusted_ship_ids, i);
            let new_position = *vector::borrow(&new_positions, i);
            let old_position_o = ship_util::find_ship_id(&roster_ship_ids, ship_id);
            assert!(option::is_some(&old_position_o), EShipIdNotFound);
            let old_position = option::extract(&mut old_position_o);
            if (old_position != new_position) {
                vector::remove(&mut roster_ship_ids, old_position);
                vector::insert(&mut roster_ship_ids, new_position, ship_id);
            };
            i = i + 1;
        };
        roster::set_ship_ids(&mut roster, roster_ship_ids);

        roster
    }
}
