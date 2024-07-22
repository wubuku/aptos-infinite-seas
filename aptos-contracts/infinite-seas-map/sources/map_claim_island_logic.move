module infinite_seas_map::map_claim_island_logic {
    use infinite_seas_common::coordinates::Coordinates;
    use infinite_seas_common::map_location_type;
    use infinite_seas_map::map;
    use infinite_seas_map::map_location::{Self, MapLocation};

    friend infinite_seas_map::map_aggregate;

    const ELocationTypeMismatch: u64 = 1;
    const EIslandAlreadyClaimed: u64 = 2;
    const ELocationNotFound: u64 = 3;

    public(friend) fun verify(
        account: &signer,
        store_address: address,      
        coordinates: Coordinates,
        claimed_by: address,
        claimed_at: u64,
    ): map::MapIslandClaimed {
        //todo assert!(map::locations_contains(map, coordinates), ELocationNotFound);
        // let island = map::borrow_location(map, coordinates);
        // assert!(map_location::type(island) == map_location_type::island(), ELocationTypeMismatch);
        // assert!(option::is_none(&map_location::occupied_by(island)), EIslandAlreadyClaimed);
        map::new_map_island_claimed(
            store_address,//map,
            coordinates,
            claimed_by,
            claimed_at
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        store_address: address,
        map_island_claimed: &map::MapIslandClaimed,
    ) {
        let coordinates = map::map_island_claimed_coordinates(map_island_claimed);
        let claimed_by = map::map_island_claimed_claimed_by(map_island_claimed);
        let claimed_at = map::map_island_claimed_claimed_at(map_island_claimed);
        // ...
        //
    }

}
