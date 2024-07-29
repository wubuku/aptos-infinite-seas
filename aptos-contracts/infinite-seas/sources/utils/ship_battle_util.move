module infinite_seas::ship_battle_util {
    use std::option;
    use std::option::Option;
    use std::vector;
    use aptos_framework::object;

    use infinite_seas_common::direct_route_util;
    use infinite_seas_common::sorted_vector_util;
    use infinite_seas_common::ts_random_util;

    use infinite_seas::pass_object;
    use infinite_seas::permission_util;
    use infinite_seas::roster::{Self, Roster};
    use infinite_seas::ship;
    use infinite_seas::ship::Ship;
    use infinite_seas::ship_battle::{Self, ShipBattle};

    friend infinite_seas::ship_battle_initiate_battle_logic;
    // friend infinite_seas::ship_battle_make_move_logic;

    const EInitiatorBattleIdMismatch: u64 = 10;
    const EResponderBattleIdMismatch: u64 = 11;
    const EInitiatorIdMismatch: u64 = 12;
    const EResponderIdMismatch: u64 = 13;
    const EShipNotFoundById: u64 = 21;
    const ENoLivingShips: u64 = 22;
    const ERoundMoverNotSet: u64 = 23;
    const EInvalidSide: u64 = 24;

    const MIN_DISTANCE_TO_BATTLE: u64 = 250; //TODO: Is this MIN_DISTANCE_TO_BATTLE a good value?

    // const MAX_DODGE_CHANCE: u64 = 60;
    // /// TODO: Is this CRITICAL_MISS_CHANCE a good value?
    // const CRITICAL_MISS_CHANCE: u64 = 35;
    // /// TODO: Is this CRITICAL_HIT_CHANCE a good value?
    // const CRITICAL_HIT_CHANCE: u64 = 20;
    // /// TODO: Is this IS_FURY_MODE only for test?
    // const IS_FURY_MODE: bool = true;
    // const FURY_MODE_DAMAGE_MULTIPLIER: u64 = 2;

    public fun initiator(): u8 {
        1
    }

    public fun responder(): u8 {
        0
    }

    /// Get the "opposite" side.
    public fun opposite_side(side: u8): u8 {
        if (side == initiator()) {
            responder()
        } else if (side == responder()) {
            initiator()
        } else {
            abort EInvalidSide
        }
    }

    public fun assert_ids_are_consistent_and_player_is_current_round_mover(
        player_id: address, //player: &Player,
        ship_battle_id: address, ship_battle: &ShipBattle,
        initiator_obj_addr: address, initiator: &Roster,
        responder_obj_addr: address, responder: &Roster
    ) {
        assert_ids_are_consistent(
            ship_battle_id,
            ship_battle,
            initiator_obj_addr,
            initiator,
            responder_obj_addr,
            responder
        );
        assert_player_is_current_round_mover(player_id, ship_battle, initiator, responder);
    }

    public fun assert_player_is_current_round_mover(
        player_id: address, ship_battle: &ShipBattle, initiator: &Roster, responder: &Roster
    ) {
        let round_mover = ship_battle::round_mover(ship_battle);
        assert!(option::is_some(&round_mover), ERoundMoverNotSet);
        if (*option::borrow(&round_mover) == initiator()) {
            permission_util::assert_player_is_roster_owner(player_id, initiator);
        } else {
            permission_util::assert_player_is_roster_owner(player_id, responder);
        };
    }

    public fun assert_ids_are_consistent(
        ship_battle_id: address, ship_battle: &ShipBattle,
        initiator_obj_addr: address, initiator: &Roster,
        responder_obj_addr: address, responder: &Roster
    ) {
        //let battle_id = ship_battle::id(ship_battle);
        let i_battle_id = roster::ship_battle_id(initiator);
        assert!(ship_battle_id == *option::borrow(&i_battle_id), EInitiatorBattleIdMismatch);
        let r_battle_id = roster::ship_battle_id(responder);
        assert!(ship_battle_id == *option::borrow(&r_battle_id), EResponderBattleIdMismatch);

        let i = ship_battle::initiator(ship_battle);
        assert!(i == initiator_obj_addr, EInitiatorIdMismatch);

        let r = ship_battle::responder(ship_battle);
        assert!(r == responder_obj_addr, EResponderIdMismatch);
    }

    /// Check if the two rosters are close enough to initiate a battle.
    public fun are_rosters_close_enough(roster_1: &Roster, roster_2: &Roster): bool {
        let c_1 = roster::updated_coordinates(roster_1);
        let c_2 = roster::updated_coordinates(roster_2);
        let d = direct_route_util::get_distance(c_1, c_2);
        d <= MIN_DISTANCE_TO_BATTLE
    }

    /// Returns the address of the attacker ship that should go first in the battle round, the address of the defender ship,
    /// and the indicator (1 or 2) of the roster that the attacker belongs to.
    public(friend) fun determine_attacker_and_defender(
        roster_1_obj_addr: address, roster_1: &Roster,
        roster_2_obj_addr: address, roster_2: &Roster,
        salt: u32
    ): (address, address, u8) {
        let (attacker_ship_id, roster_indicator) = determine_ship_to_go_first(
            roster_1_obj_addr,
            roster_1,
            roster_2_obj_addr,
            roster_2,
            salt
        );
        let defender_ship_id = if (roster_indicator == 1) {
            let d_id = get_front_ship(roster_2);
            assert!(option::is_some(&d_id), ENoLivingShips);
            option::extract(&mut d_id)
        } else {
            let d_id = get_front_ship(roster_1);
            assert!(option::is_some(&d_id), ENoLivingShips);
            option::extract(&mut d_id)
        };
        (attacker_ship_id, defender_ship_id, roster_indicator)
    }

    /*
    def generate_turn_order(ships):
        turn_order = []
        for ship in ships:
            if ship.hp > 0:  # Only consider ships that are still active
                initiative = random.randint(1, 8) + ship.speed
                turn_order.append((ship, initiative))
        # Sort ships by their initiative score, highest first
        turn_order.sort(key=lambda x: x[1], reverse=True)
        return [ship[0] for ship in turn_order]
    */

    /// Determine which ship should go first in the battle round, based on the initiative score.
    /// Initiative score is calculated based on the ship's speed and a random number.
    /// Returns the address of the ship that should go first and the indicator (1 or 2) of the roster that the ship belongs to.
    public(friend) fun determine_ship_to_go_first(
        roster_1_obj_addr: address, roster_1: &Roster,
        roster_2_obj_addr: address, roster_2: &Roster,
        salt: u32
    ): (address, u8) {
        let seed_1 = sorted_vector_util::concat_ids_bytes(&vector[roster_1_obj_addr, roster_2_obj_addr]);
        vector::append(&mut seed_1, vector[((salt % 256) as u8)]);//bcs::to_bytes(&salt));
        let random_ints = ts_random_util::get_8_u32_vector(seed_1);
        let (candidate_1, initiative_1) = get_candidate_attacker_ship_id(roster_1, &random_ints);// clock, seed_1);
        //let seed_2 = vector[2];//vector::empty<u8>();
        //vector::append(&mut seed_2, bcs::to_bytes(&initiative_1));
        //vector::append(&mut seed_2, bcs::to_bytes(&vector::length(&roster::ship_ids(roster_1))));
        //vector::append(&mut seed_2, seed_1);
        vector::reverse(&mut random_ints);
        let (candidate_2, initiative_2) = get_candidate_attacker_ship_id(roster_2, &random_ints);// clock, seed_2);
        assert!(!(option::is_none(&candidate_1) && option::is_none(&candidate_2)), ENoLivingShips);
        if (option::is_none(&candidate_1)) {
            (option::extract(&mut candidate_2), 2)
        } else if (option::is_none(&candidate_2)) {
            (option::extract(&mut candidate_1), 1)
        } else if (initiative_1 >= initiative_2) {
            (option::extract(&mut candidate_1), 1)
        } else {
            //if (initiative_1 < initiative_2)
            (option::extract(&mut candidate_2), 2)
        }
    }

    fun get_candidate_attacker_ship_id(
        roster: &Roster,
        random_ints: &vector<u32>//, clock: &Clock, seed: vector<u8>
    ): (Option<address>, u32) {
        let ship_ids = roster::borrow_ship_ids(roster);
        //let ships = roster::borrow_ships(roster);
        //let turn_order = vector::empty<address>();
        let i = 0;
        let l = vector::length(ship_ids);
        let max_initiative = 0;
        let candidate = option::none<address>();
        //let (random_i_1, random_i_2, random_i_3, random_i_4) = ts_random_util::get_4_u64(clock, seed);
        //let random_ints = vector[random_i_1, random_i_2, random_i_3, random_i_4];
        let random_ints_len = vector::length(random_ints);
        while (i < l) {
            let ship_id = *vector::borrow(ship_ids, i);
            //assert!(object_table::contains(ships, ship_id), EShipNotFoundById);
            assert!(object::object_exists<Ship>(ship_id), EShipNotFoundById);
            //let ship = object_table::borrow(ships, ship_id);
            let ship_pass_obj = ship::get_ship(ship_id);
            let ship = pass_object::borrow(&ship_pass_obj);
            if (ship::health_points(ship) > 0) {
                //let s = bcs::to_bytes(&i);
                //vector::append(&mut s, seed);
                //let initiative = 1 + ts_random_util::get_int(clock, s, 8) + (ship::speed(ship) as u64);
                let initiative = 1 + *vector::borrow(random_ints, i % random_ints_len) % 8 + (ship::speed(ship));
                //vector::push_back(&mut turn_order, ship_id);
                if (initiative > max_initiative) {
                    max_initiative = initiative;
                    candidate = option::some(ship_id);
                };
            };
            ship::return_ship(ship_pass_obj);
            i = i + 1;
        };
        (candidate, max_initiative)
    }

    /*
    def get_front_ship(ships):
        return next((ship for ship in ships if ship.hp > 0), None)
    */

    public fun get_front_ship(roster: &Roster): Option<address> {
        let ship_ids = roster::borrow_ship_ids(roster);
        //let ships = roster::borrow_ships(roster);
        let i = 0;
        let l = vector::length(ship_ids);
        while (i < l) {
            let ship_id = *vector::borrow(ship_ids, i);
            //assert!(object_table::contains(ships, ship_id), EShipNotFoundById);
            assert!(object::object_exists<Ship>(ship_id), EShipNotFoundById);
            //let ship = object_table::borrow(ships, ship_id);
            let ship_pass_obj = ship::get_ship(ship_id);
            let ship = pass_object::borrow(&ship_pass_obj);
            let h = ship::health_points(ship);
            ship::return_ship(ship_pass_obj);
            if (h > 0) {
                return option::some(ship_id)
            };
            i = i + 1;
        };
        option::none()
    }

    // public fun perform_attack(seed: vector<u8>, clock: &Clock, self_attack: u32, opponent_protection: u32): u32 {
    //     //salt: u32,
    //     //self: &Ship, opponent: &Ship
    //     //let self_attack = ship::attack(self);
    //     //let opponent_protection = ship::protection(opponent);
    //     let (random_i_4, random_i_3, random_i_2, random_i_1) = ts_random_util::get_4_u64(clock, seed);
    //
    //     // Dodge check
    //     // dodge_chance = min(60, ((opponent.protection - self.attack) * 8 + 15)) if opponent.protection >= self.attack else 0
    //     let dodge_chance = if (opponent_protection > self_attack) {
    //         math::min(MAX_DODGE_CHANCE, ((opponent_protection - self_attack) as u64) * 8 + 15)
    //     } else {
    //         0
    //     };
    //     // let seed_1 = seed;//sorted_vector_util::concat_ids_bytes(&vector[ship::id(self), ship::id(opponent)]);
    //     // //vector::append(&mut seed_1, vector[(salt % 256 as u8)]); //bcs::to_bytes(&salt)
    //     if (1 + random_i_1 % 100 <= dodge_chance) {
    //         //if (1 + ts_random_util::get_int(clock, seed_1, 100) <= dodge_chance) {
    //         return 0
    //     };
    //
    //     // Damage calculation with base formula
    //     let damage = if (self_attack < opponent_protection) {
    //         // damage = max(2, self.attack - (opponent.protection - self.attack) * 0.3)
    //         let d = opponent_protection - self_attack;
    //         let d_2 = d * 3 / 10;
    //         if (self_attack >= d_2) {
    //             math::max(2, ((self_attack - d_2) as u64))
    //         } else {
    //             2
    //         }
    //     } else {
    //         /* self_attack >= opponent_protection */
    //         // damage = self.attack - opponent.protection * 0.8
    //         ((self_attack - opponent_protection * 4 / 5) as u64)
    //     };
    //
    //     // //let seed_2 = sorted_vector_util::concat_ids_bytes(&vector[ship::id(opponent), ship::id(self)]);
    //     // //vector::append(&mut seed_2, bcs::to_bytes(&salt));
    //     // vector::append(&mut seed_1, vector[2]);
    //     // let seed_2 = seed_1;
    //
    //     // Critical hit and miss logic
    //     if (random_i_2 % 100 < CRITICAL_MISS_CHANCE) {
    //         //if (ts_random_util::get_int(clock, seed_2, 100) < critical_miss_chance) {
    //         // Critical miss negates all damage
    //         //if (opponent_protection < self_attack) {
    //         return 0
    //         //}
    //     } else {
    //         // //let seed_3 = vector::empty<u8>();
    //         // //vector::append(&mut seed_3, bcs::to_bytes(&ship::health_points(opponent)));
    //         // //vector::append(&mut seed_3, bcs::to_bytes(&ship::health_points(self)));
    //         // //vector::append(&mut seed_3, seed_2);
    //         // vector::append(&mut seed_1, vector[3]);
    //         // let seed_3 = seed_1;
    //         if (random_i_3 % 100 < CRITICAL_HIT_CHANCE) {
    //             //if (ts_random_util::get_int(clock, seed_3, 100) < critical_hit_chance) {
    //             // Critical hit doubles the damage
    //             //damage *= 1.5;
    //             damage = damage * 3 / 2;
    //         }
    //     };
    //     if (IS_FURY_MODE && damage <= 2 && random_i_4 % 2 < 1) {
    //         //NOTE: This line is extra relative to the Python version!
    //         (damage * FURY_MODE_DAMAGE_MULTIPLIER as u32)
    //     } else {
    //         (damage as u32)
    //     }
    // }
}
