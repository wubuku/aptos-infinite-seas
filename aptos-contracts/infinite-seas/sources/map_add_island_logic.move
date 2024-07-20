module infinite_seas::map_add_island_logic {
    use infinite_seas::map;
    use infinite_seas_common::coordinates::Coordinates;
    use infinite_seas_common::item_id_quantity_pairs::ItemIdQuantityPairs;

    friend infinite_seas::map_aggregate;

    public(friend) fun verify(
        account: &signer,
        coordinates: Coordinates,
        resources: ItemIdQuantityPairs,
        map: &map::Map,
    ): map::IslandAdded {
        // ...
        //
    }

    public(friend) fun mutate(
        _account: &signer,
        island_added: &map::IslandAdded,
        map: map::Map,
    ): map::Map {
        let coordinates = map::island_added_coordinates(island_added);
        let resources = map::island_added_resources(island_added);
        // ...
        //
    }

}
