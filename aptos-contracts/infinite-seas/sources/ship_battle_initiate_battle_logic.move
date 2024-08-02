module infinite_seas::ship_battle_initiate_battle_logic {
    use std::option;
    use aptos_framework::object::{Self, Object};
    use aptos_framework::timestamp;

    use infinite_seas_common::battle_status;
    use infinite_seas_common::coordinates::Coordinates;
    use infinite_seas_common::roster_status;

    use infinite_seas::permission_util;
    use infinite_seas_player::player;
    use infinite_seas_player::player::Player;
    use infinite_seas::roster;
    use infinite_seas::roster::Roster;
    use infinite_seas::roster_util;
    use infinite_seas::ship_battle;
    use infinite_seas::ship_battle_util;

    friend infinite_seas::ship_battle_aggregate;

    const EInitiatorNotBattleReady: u64 = 10;
    const EResponderNotBattleReady: u64 = 11;
    const ENotCloseEnoughToBattle: u64 = 12;

    const FIRST_ROUND_NUMBER: u32 = 1;

    public(friend) fun verify(
        account: &signer,
        player_obj: Object<Player>,
        initiator_obj: Object<Roster>,
        responder_obj: Object<Roster>,
        initiator_coordinates: Coordinates,
        responder_coordinates: Coordinates,
    ): ship_battle::ShipBattleInitiated {
        let player_obj_addr = object::object_address(&player_obj); // Player Object ID
        let initiator_obj_addr = object::object_address(&initiator_obj);
        let responder_obj_addr = object::object_address(&responder_obj);
        let player_pass_obj = player::get_player(player_obj_addr);
        let initiator_pass_obj = roster::get_roster(initiator_obj_addr);
        let responder_pass_obj = roster::get_roster(responder_obj_addr);
        let player = player::borrow(&player_pass_obj);
        let initiator = roster::borrow_mut(&mut initiator_pass_obj);
        let responder = roster::borrow_mut(&mut responder_pass_obj);

        assert!(roster_util::is_status_battle_ready(initiator), EInitiatorNotBattleReady);
        assert!(roster_util::is_status_battle_ready(responder), EResponderNotBattleReady);
        permission_util::assert_sender_is_player_owner(player, account);
        //permission_util::assert_player_is_roster_owner(player, initiator);
        permission_util::assert_player_is_roster_owner(player_obj_addr, initiator);
        roster_util::assert_roster_is_not_unassigned_ships(initiator);
        roster_util::assert_roster_is_not_unassigned_ships(responder);
        // todo more checks???

        // Update the locations of the two rosters,
        if (roster_status::underway() == roster::status(initiator)) {
            //roster_aggregate::update_location(initiator, clock, ctx);
            //let (initiator_coordinates, t, _new_status) = roster_util::calculate_current_location(initiator, clock);
            let (updatable, t, _new_status) = roster_util::is_current_location_updatable(
                initiator,
                initiator_coordinates
            );
            if (updatable) {
                roster::set_updated_coordinates(initiator, initiator_coordinates);
                roster::set_coordinates_updated_at(initiator, t);
            };
        };
        if (roster_status::underway() == roster::status(responder)) {
            //roster_aggregate::update_location(responder, clock, ctx);
            //let (responder_coordinates, t, _new_status) = roster_util::calculate_current_location(responder, clock);
            let (updatable, t, _new_status) = roster_util::is_current_location_updatable(
                responder,
                responder_coordinates
            );
            if (updatable) {
                roster::set_updated_coordinates(responder, responder_coordinates);
                roster::set_coordinates_updated_at(responder, t);
            };
        };

        // and then assert if they are close enough to each other
        assert!(ship_battle_util::are_rosters_close_enough(initiator, responder), ENotCloseEnoughToBattle);
        let (attacker_ship_id, defender_ship_id, roster_indicator) = ship_battle_util::determine_attacker_and_defender(
            initiator_obj_addr, initiator, responder_obj_addr, responder, FIRST_ROUND_NUMBER
        );
        let first_round_mover = if (roster_indicator == 1) {
            ship_battle_util::initiator()
        } else {
            ship_battle_util::responder()
        };
        player::return_player(player_pass_obj);
        roster::return_roster(initiator_pass_obj);
        roster::return_roster(responder_pass_obj);
        ship_battle::new_ship_battle_initiated(
            player_obj_addr, initiator_obj_addr, responder_obj_addr,
            initiator_coordinates,
            responder_coordinates,
            timestamp::now_seconds(),
            option::some(first_round_mover),
            option::some(attacker_ship_id),
            option::some(defender_ship_id),
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        ship_battle_initiated: &ship_battle::ShipBattleInitiated,
        ship_battle_id: address,
    ): ship_battle::ShipBattle {
        //let player_obj_addr = ship_battle::ship_battle_initiated_player_id(ship_battle_initiated);
        let initiator_obj_addr = ship_battle::ship_battle_initiated_initiator_id(ship_battle_initiated);
        let responder_obj_addr = ship_battle::ship_battle_initiated_responder_id(ship_battle_initiated);
        //let initiator_coordinates = ship_battle::ship_battle_initiated_initiator_coordinates(ship_battle_initiated);
        //let responder_coordinates = ship_battle::ship_battle_initiated_responder_coordinates(ship_battle_initiated);
        let started_at = ship_battle::ship_battle_initiated_started_at(ship_battle_initiated);
        let first_round_mover = ship_battle::ship_battle_initiated_first_round_mover(ship_battle_initiated);
        let first_round_attacker_ship = ship_battle::ship_battle_initiated_first_round_attacker_ship(
            ship_battle_initiated
        );
        let first_round_defender_ship = ship_battle::ship_battle_initiated_first_round_defender_ship(
            ship_battle_initiated
        );

        let battle = ship_battle::new_ship_battle(
            initiator_obj_addr, responder_obj_addr,
            battle_status::in_progress(),
            started_at,
            first_round_mover, first_round_attacker_ship, first_round_defender_ship,
        );
        ship_battle::set_round_number(&mut battle, FIRST_ROUND_NUMBER);

        // update status and battle_id fields in the rosters
        let initiator_pass_obj = roster::get_roster(initiator_obj_addr);
        let responder_pass_obj = roster::get_roster(responder_obj_addr);

        let initiator = roster::borrow_mut(&mut initiator_pass_obj);
        let responder = roster::borrow_mut(&mut responder_pass_obj);
        roster::set_status(initiator, roster_status::in_battle());
        roster::set_ship_battle_id(initiator, option::some(ship_battle_id));
        roster::set_status(responder, roster_status::in_battle());
        roster::set_ship_battle_id(responder, option::some(ship_battle_id));
        roster::return_roster(initiator_pass_obj);
        roster::return_roster(responder_pass_obj);

        battle
    }
}
