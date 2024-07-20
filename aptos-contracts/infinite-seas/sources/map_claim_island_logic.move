module infinite_seas::map_claim_island_logic {
    use infinite_seas::map;
    use infinite_seas_common::coordinates::Coordinates;

    friend infinite_seas::map_aggregate;

    public(friend) fun verify(
        account: &signer,
        coordinates: Coordinates,
        claimed_by: address,
        claimed_at: u64,
        map: &map::Map,
    ): map::MapIslandClaimed {
        // ...
        //
    }

    public(friend) fun mutate(
        _account: &signer,
        map_island_claimed: &map::MapIslandClaimed,
        map: map::Map,
    ): map::Map {
        let coordinates = map::map_island_claimed_coordinates(map_island_claimed);
        let claimed_by = map::map_island_claimed_claimed_by(map_island_claimed);
        let claimed_at = map::map_island_claimed_claimed_at(map_island_claimed);
        // ...
        //
    }

}
