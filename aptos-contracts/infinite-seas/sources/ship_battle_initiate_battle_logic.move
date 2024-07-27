module infinite_seas::ship_battle_initiate_battle_logic {
    use std::option;
    use aptos_framework::object::{Self, Object};
    use infinite_seas::player::Player;
    use infinite_seas::roster::Roster;
    use infinite_seas::ship_battle;
    use infinite_seas_common::coordinates::Coordinates;

    friend infinite_seas::ship_battle_aggregate;

    public(friend) fun verify(
        account: &signer,
        player: Object<Player>,
        initiator: Object<Roster>,
        responder: Object<Roster>,
        initiator_coordinates: Coordinates,
        responder_coordinates: Coordinates,
    ): ship_battle::ShipBattleInitiated {
        ship_battle::new_ship_battle_initiated(
            object::object_address(&player),
            object::object_address(&initiator),
            object::object_address(&responder),
            initiator_coordinates,
            responder_coordinates,
            0, //todo
            option::none(), //todo
            option::none(), //todo
            option::none(), //todo
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        ship_battle_initiated: &ship_battle::ShipBattleInitiated,
        id: address,
    ): ship_battle::ShipBattle {
        let player_id = ship_battle::ship_battle_initiated_player_id(ship_battle_initiated);
        let initiator_id = ship_battle::ship_battle_initiated_initiator_id(ship_battle_initiated);
        let responder_id = ship_battle::ship_battle_initiated_responder_id(ship_battle_initiated);
        let initiator_coordinates = ship_battle::ship_battle_initiated_initiator_coordinates(ship_battle_initiated);
        let responder_coordinates = ship_battle::ship_battle_initiated_responder_coordinates(ship_battle_initiated);
        let started_at = ship_battle::ship_battle_initiated_started_at(ship_battle_initiated);
        let first_round_mover = ship_battle::ship_battle_initiated_first_round_mover(ship_battle_initiated);
        let first_round_attacker_ship = ship_battle::ship_battle_initiated_first_round_attacker_ship(ship_battle_initiated);
        let first_round_defender_ship = ship_battle::ship_battle_initiated_first_round_defender_ship(ship_battle_initiated);

        ship_battle::new_ship_battle(
            initiator_id,
            responder_id,
            0,//todo
            0,//todo
            first_round_mover,
            first_round_attacker_ship,
            first_round_defender_ship,
        )
    }

}
