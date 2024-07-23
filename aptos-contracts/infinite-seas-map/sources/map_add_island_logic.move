module infinite_seas_map::map_add_island_logic {
    use infinite_seas_common::coordinates::Coordinates;
    use infinite_seas_common::item_id_quantity_pairs::ItemIdQuantityPairs;
    use infinite_seas_map::map;
    use infinite_seas_map::map_location::{Self, MapLocation};

    friend infinite_seas_map::map_aggregate;

    const ELocationAlreadyExists: u64 = 1;

    public(friend) fun verify(
        account: &signer,
        store_address: address,      
        coordinates: Coordinates,
        resources: ItemIdQuantityPairs,
    ): map::IslandAdded {
        assert!(!map::singleton_locations_contains(store_address, coordinates), ELocationAlreadyExists);
        map::new_island_added(store_address, coordinates, resources)
    }

    public(friend) fun mutate(
        _account: &signer,
        store_address: address,
        island_added: &map::IslandAdded,
    ) {
        let coordinates = map::island_added_coordinates(island_added);
        let resources = map::island_added_resources(island_added);
        // ...
        //
    }

}
