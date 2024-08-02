module infinite_seas::ship_battle_take_loot_logic {
    use std::option;
    use std::vector;
    use aptos_framework::object::{Self, Object};

    use infinite_seas_common::sorted_vector_util;

    use infinite_seas_player::player::Player;
    use infinite_seas::roster;
    use infinite_seas::roster::Roster;
    use infinite_seas::ship_battle;

    friend infinite_seas::ship_battle_aggregate;

    public(friend) fun verify(
        account: &signer,
        player_obj: Object<Player>,
        loser_player_obj: Object<Player>,
        initiator_obj: Object<Roster>,
        responder_obj: Object<Roster>,
        choice: u8,
        id: address,
        ship_battle: &ship_battle::ShipBattle,
    ): ship_battle::ShipBattleLootTaken {
        let player_obj_addr = object::object_address(&player_obj);
        let loser_player_obj_addr = object::object_address(&loser_player_obj);

        let initiator_obj_addr = object::object_address(&initiator_obj);
        let responder_obj_addr = object::object_address(&responder_obj);
        let initiator_pass_obj = roster::get_roster(initiator_obj_addr);
        let responder_pass_obj = roster::get_roster(responder_obj_addr);

        let initiator = roster::borrow_mut(&mut initiator_pass_obj);
        let responder = roster::borrow_mut(&mut responder_pass_obj);

        // TODO ship_battle_take_loot_logic verify ...

        let loot_item_ids = vector::empty<u32>(); // TODO ...
        let loot_item_quantities = vector::empty<u32>(); // TODO ...

        roster::return_roster(initiator_pass_obj);
        roster::return_roster(responder_pass_obj);
        ship_battle::new_ship_battle_loot_taken(id,
            ship_battle, player_obj_addr, loser_player_obj_addr, initiator_obj_addr, responder_obj_addr,
            choice,
            sorted_vector_util::new_item_id_quantity_pairs(loot_item_ids, loot_item_quantities),
            0, //todo now_time,
            0, 0, 0, 0 //todo winner_increased_experience, new_level, loser_increased_experience, loser_new_level,
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        ship_battle_loot_taken: &ship_battle::ShipBattleLootTaken,
        id: address,
        ship_battle: ship_battle::ShipBattle,
    ): ship_battle::ShipBattle {
        let player_id = ship_battle::ship_battle_loot_taken_player_id(ship_battle_loot_taken);
        let loser_player_id = ship_battle::ship_battle_loot_taken_loser_player_id(ship_battle_loot_taken);
        let initiator_id = ship_battle::ship_battle_loot_taken_initiator_id(ship_battle_loot_taken);
        let responder_id = ship_battle::ship_battle_loot_taken_responder_id(ship_battle_loot_taken);
        let choice = ship_battle::ship_battle_loot_taken_choice(ship_battle_loot_taken);
        let loot = ship_battle::ship_battle_loot_taken_loot(ship_battle_loot_taken);
        let looted_at = ship_battle::ship_battle_loot_taken_looted_at(ship_battle_loot_taken);
        let increased_experience = ship_battle::ship_battle_loot_taken_increased_experience(ship_battle_loot_taken);
        let new_level = ship_battle::ship_battle_loot_taken_new_level(ship_battle_loot_taken);
        let loser_increased_experience = ship_battle::ship_battle_loot_taken_loser_increased_experience(
            ship_battle_loot_taken
        );
        let loser_new_level = ship_battle::ship_battle_loot_taken_loser_new_level(ship_battle_loot_taken);
        // TODO ship_battle_take_loot_logic.mutate ...

        ship_battle
    }
}
