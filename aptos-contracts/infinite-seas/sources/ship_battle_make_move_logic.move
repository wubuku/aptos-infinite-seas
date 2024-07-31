module infinite_seas::ship_battle_make_move_logic {
    use std::bcs;
    use std::option;
    use std::vector;
    use aptos_framework::object::{Self, Object};
    use aptos_framework::timestamp;

    use infinite_seas_common::fight_to_death;
    use infinite_seas_common::ship_battle_command;

    use infinite_seas::player::Player;
    use infinite_seas::roster;
    use infinite_seas::roster::Roster;
    use infinite_seas::roster_util;
    use infinite_seas::ship;
    use infinite_seas::ship::Ship;
    use infinite_seas::ship_battle;
    use infinite_seas::ship_battle_util;

    friend infinite_seas::ship_battle_aggregate;

    const ERoundMoverNotSet: u64 = 11;
    const EAttackerShipNotSet: u64 = 12;
    const EDefenderShipNotSet: u64 = 13;
    const EWinnerNotSet: u64 = 14;
    const EWinnerSetButBattleNotEnded: u64 = 15;
    const EInvalidWinner: u64 = 16;

    /// The experience points gained by defeating a "player-owned" ship.
    const PLAYER_SHIP_EXPERIENCE: u32 = 8;

    public(friend) fun verify(
        account: &signer,
        player_obj: Object<Player>,
        initiator_obj: Object<Roster>,
        responder_obj: Object<Roster>,
        attacker_command: u8,
        id: address,
        ship_battle: &ship_battle::ShipBattle,
    ): ship_battle::ShipBattleMoveMade {
        let initiator_obj_addr = object::object_address(&initiator_obj);
        let responder_obj_addr = object::object_address(&responder_obj);
        let initiator_pass_obj = roster::get_roster(initiator_obj_addr);
        let responder_pass_obj = roster::get_roster(responder_obj_addr);

        let initiator = roster::borrow_mut(&mut initiator_pass_obj);
        let responder = roster::borrow_mut(&mut responder_pass_obj);
        ship_battle_util::assert_ids_are_consistent(
            id,
            ship_battle,
            initiator_obj_addr,
            responder,
            responder_obj_addr,
            responder
        );

        let defender_command: u8 = ship_battle_command::attack();//Unused for now
        let player_obj_addr = object::object_address(&player_obj);
        //let player = pass_object::borrow(&player_pass_obj);

        let now_time = timestamp::now_seconds(); //clock::timestamp_ms(clock) / 1000;
        let current_round_number = ship_battle::round_number(ship_battle);

        let attacker_ship_id = ship_battle::round_attacker_ship(ship_battle);
        assert!(option::is_some(&attacker_ship_id), EAttackerShipNotSet);
        let defender_ship_id = ship_battle::round_defender_ship(ship_battle);
        assert!(option::is_some(&defender_ship_id), EDefenderShipNotSet);

        let round_mover = ship_battle::round_mover(ship_battle);
        assert!(option::is_some(&round_mover), ERoundMoverNotSet);
        let attacker_roster: &mut Roster;
        let defender_roster: &mut Roster;
        if (*option::borrow(&round_mover) == ship_battle_util::initiator()) {
            attacker_roster = initiator;
            defender_roster = responder;
        } else {
            attacker_roster = responder;
            defender_roster = initiator;
        };
        //let attacker_ships = roster::borrow_ships(attacker_roster);
        //let defender_ships = roster::borrow_ships(defender_roster);
        //let attacker_ship = object_table::borrow(attacker_ships, *option::borrow(&attacker_ship_id));
        //let defender_ship = object_table::borrow(defender_ships, *option::borrow(&defender_ship_id));
        let attacker_ship_pass_obj = ship::get_ship(*option::borrow(&attacker_ship_id));
        let defender_ship_pass_obj = ship::get_ship(*option::borrow(&defender_ship_id));
        let attacker_ship = ship::borrow_mut(&mut attacker_ship_pass_obj);
        let defender_ship = ship::borrow_mut(&mut defender_ship_pass_obj);
        let seed_1 = bcs::to_bytes(&id); //object::id_to_bytes(&ship_battle::id(ship_battle));
        vector::append(&mut seed_1, vector[(current_round_number % 256 as u8)]);

        // let defender_damage_taken = ship_battle_util::perform_attack(
        //     seed_1, clock,
        //     ship::attack(attacker_ship), ship::protection(defender_ship), //attacker_ship, defender_ship,
        // );
        let defender_ship_hp = ship::health_points(defender_ship);
        let attacker_ship_hp = ship::health_points(attacker_ship);
        let (attacker_damage_taken, defender_damage_taken) = fight_to_death::perform(//clock,
            seed_1,
            ship::attack(attacker_ship), ship::protection(defender_ship), attacker_ship_hp,
            ship::attack(defender_ship), ship::protection(attacker_ship), defender_ship_hp,
        );
        if (defender_damage_taken >= defender_ship_hp) {
            defender_damage_taken = defender_ship_hp;
            defender_ship_hp = 0;
        } else {
            defender_ship_hp = defender_ship_hp - defender_damage_taken;
        };

        let is_batlle_ended = false;
        let winner = option::none<u8>();

        if (defender_ship_hp == 0
            && roster_util::is_destroyed_except_ship(defender_roster, *option::borrow(&defender_ship_id))
        ) {
            is_batlle_ended = true;
            winner = option::some(*option::borrow(&round_mover));
        };
        // let attacker_damage_taken = 0;
        // let seed_2 = seed_1;
        // vector::append(&mut seed_2, vector[2]);
        if (attacker_damage_taken > 0) {
            //if (!is_batlle_ended) {
            // attacker_damage_taken = ship_battle_util::perform_attack(
            //     seed_2, clock,
            //     ship::attack(defender_ship), ship::protection(attacker_ship),
            // );
            // let attacker_ship_hp = ship::health_points(attacker_ship);
            if (attacker_damage_taken >= attacker_ship_hp) {
                attacker_damage_taken = attacker_ship_hp;
                attacker_ship_hp = 0;
            } else {
                attacker_ship_hp = attacker_ship_hp - attacker_damage_taken;
            };

            if (attacker_ship_hp == 0
                && roster_util::is_destroyed_except_ship(attacker_roster, *option::borrow(&attacker_ship_id))
            ) {
                is_batlle_ended = true;
                winner = option::some(ship_battle_util::opposite_side(*option::borrow(&round_mover)));
            };
        };
        let next_round_mover = option::none<u8>();
        let next_round_attacker_ship = option::none<address>();
        let next_round_defender_ship = option::none<address>();
        let next_round_started_at = now_time;

        //
        // NOTE: Update the ships' health_points first!
        // That way you won't pick a ship that has already been destroyed.
        //
        let (_attacker_ship_hp, _defender_ship_hp) = update_ship_health_points(
            //attacker_roster, defender_roster,
            attacker_ship, defender_ship, //*option::borrow(&attacker_ship_id), *option::borrow(&defender_ship_id),
            attacker_damage_taken, defender_damage_taken
        );

        if (!is_batlle_ended) {
            let next_round_number = current_round_number + 1;
            let (attacker_ship_id, defender_ship_id, roster_indicator) = ship_battle_util::determine_attacker_and_defender(
                initiator_obj_addr, initiator, responder_obj_addr, responder, //clock,
                next_round_number
            );
            next_round_attacker_ship = option::some(attacker_ship_id);
            next_round_defender_ship = option::some(defender_ship_id);
            next_round_mover = option::some(if (roster_indicator == 1) {
                ship_battle_util::initiator()
            } else {
                ship_battle_util::responder()
            });
        };

        ship::return_ship(attacker_ship_pass_obj);
        ship::return_ship(defender_ship_pass_obj);
        roster::return_roster(initiator_pass_obj);
        roster::return_roster(responder_pass_obj);
        ship_battle::new_ship_battle_move_made(id, ship_battle, player_obj_addr,
            initiator_obj_addr, responder_obj_addr, attacker_command, defender_command,
            current_round_number,
            defender_damage_taken, attacker_damage_taken, is_batlle_ended, winner,
            next_round_started_at, next_round_mover, next_round_attacker_ship, next_round_defender_ship,
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        ship_battle_move_made: &ship_battle::ShipBattleMoveMade,
        id: address,
        ship_battle: ship_battle::ShipBattle,
    ): ship_battle::ShipBattle {
        let player_id = ship_battle::ship_battle_move_made_player_id(ship_battle_move_made);
        let initiator_id = ship_battle::ship_battle_move_made_initiator_id(ship_battle_move_made);
        let responder_id = ship_battle::ship_battle_move_made_responder_id(ship_battle_move_made);
        let attacker_command = ship_battle::ship_battle_move_made_attacker_command(ship_battle_move_made);
        let defender_command = ship_battle::ship_battle_move_made_defender_command(ship_battle_move_made);
        let round_number = ship_battle::ship_battle_move_made_round_number(ship_battle_move_made);
        let defender_damage_taken = ship_battle::ship_battle_move_made_defender_damage_taken(ship_battle_move_made);
        let attacker_damage_taken = ship_battle::ship_battle_move_made_attacker_damage_taken(ship_battle_move_made);
        let is_battle_ended = ship_battle::ship_battle_move_made_is_battle_ended(ship_battle_move_made);
        let winner = ship_battle::ship_battle_move_made_winner(ship_battle_move_made);
        let next_round_started_at = ship_battle::ship_battle_move_made_next_round_started_at(ship_battle_move_made);
        let next_round_mover = ship_battle::ship_battle_move_made_next_round_mover(ship_battle_move_made);
        let next_round_attacker_ship = ship_battle::ship_battle_move_made_next_round_attacker_ship(
            ship_battle_move_made
        );
        let next_round_defender_ship = ship_battle::ship_battle_move_made_next_round_defender_ship(
            ship_battle_move_made
        );
        // TODO...
        //
        ship_battle
    }

    fun update_ship_health_points(
        //attacker_roster: &mut Roster,
        //defender_roster: &mut Roster,
        attacker_ship: &mut Ship, //_id: address,
        defender_ship: &mut Ship, //_id: address,
        attacker_damage_taken: u32,
        defender_damage_taken: u32
    ): (u32, u32) {
        //let attacker_ships = roster::borrow_mut_ships(attacker_roster);
        //let defender_ships = roster::borrow_mut_ships(defender_roster);
        //let attacker_ship = object_table::borrow_mut(attacker_ships, attacker_ship_id);
        //let defender_ship = object_table::borrow_mut(defender_ships, defender_ship_id);
        let attacker_ship_hp = ship::health_points(attacker_ship) - attacker_damage_taken;
        let defender_ship_hp = ship::health_points(defender_ship) - defender_damage_taken;
        ship::set_health_points(defender_ship, defender_ship_hp);
        ship::set_health_points(attacker_ship, attacker_ship_hp);
        (attacker_ship_hp, defender_ship_hp)
    }
}
