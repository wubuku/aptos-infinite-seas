module infinite_seas::roster_create_logic {
    use infinite_seas::roster;
    use infinite_seas_common::coordinates::Coordinates;
    use infinite_seas_common::roster_id::RosterId;
    use std::option::{Self, Option};

    friend infinite_seas::roster_aggregate;

    public(friend) fun verify(
        account: &signer,
        roster_id: RosterId,
        status: u8,
        speed: u32,
        updated_coordinates: Coordinates,
        coordinates_updated_at: u64,
        target_coordinates: Option<Coordinates>,
        origin_coordinates: Option<Coordinates>,
        ship_battle_id: Option<address>,
        id: address,
    ): roster::RosterCreated {
        let _ = account;
        roster::new_roster_created(
            roster_id,
            status,
            speed,
            updated_coordinates,
            coordinates_updated_at,
            target_coordinates,
            origin_coordinates,
            ship_battle_id,
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        roster_created: &roster::RosterCreated,
        id: address,
    ): roster::Roster {
        let roster_id = roster::roster_created_roster_id(roster_created);
        let status = roster::roster_created_status(roster_created);
        let speed = roster::roster_created_speed(roster_created);
        let updated_coordinates = roster::roster_created_updated_coordinates(roster_created);
        let coordinates_updated_at = roster::roster_created_coordinates_updated_at(roster_created);
        let target_coordinates = roster::roster_created_target_coordinates(roster_created);
        let origin_coordinates = roster::roster_created_origin_coordinates(roster_created);
        let ship_battle_id = roster::roster_created_ship_battle_id(roster_created);
        roster::new_roster(
            roster_id,
            status,
            speed,
            updated_coordinates,
            coordinates_updated_at,
            target_coordinates,
            origin_coordinates,
            ship_battle_id,
        )
    }

}
