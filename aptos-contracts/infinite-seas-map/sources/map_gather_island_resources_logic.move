module infinite_seas_map::map_gather_island_resources_logic {
    use infinite_seas_map::map;
    use infinite_seas_map::map_location::{Self, MapLocation};
    use infinite_seas_common::item_id;
    use infinite_seas_common::item_id_quantity_pairs;
    use infinite_seas_common::coordinates;
    use infinite_seas_common::coordinates::Coordinates;
    use infinite_seas_common::map_location_type;

    friend infinite_seas_map::map_aggregate;

    const EResourceNotRegeneratedYet: u64 = 10;

    const ELocationNotFound: u64 = 101;
    const ELocationNotAnIsland: u64 = 101;

    /// Island resource regeneration time in seconds.
    const ISLAND_RESOURCE_REGENERATION_TIME: u64 = 60 * 60 * 24; // todo 1 day is a good value?

    /// Quantity of island resources regenerated.
    const ISLAND_RESOURCE_REGENERATION_QUANTITY: u32 = 600; // todo Is this a good value?

    public(friend) fun verify(
        account: &signer,
        store_address: address,      
        player_id: address,
    ): map::IslandResourcesGathered {
        // permission_util::assert_sender_is_player_owner(player, ctx);
        // permission_util::assert_player_is_island_owner(player, map);
        // let coordinates = option::extract(&mut player::claimed_island(player));
        // let now_time = clock::timestamp_ms(clock) / 1000;
        // todo let (island, resources_quantity) = get_island_resources_quantity_to_gather(store_address, coordinates, now_time);
        // assert!(resources_quantity > 0, EResourceNotRegeneratedYet);

        let resource_item_ids = vector[item_id::resource_type_mining(), item_id::resource_type_woodcutting(), item_id::cotton_seeds()];
        // let rand_seed = bcs::to_bytes(&coordinates);
        // vector::append(&mut rand_seed, object::id_to_bytes(&player::id(player)));
        // vector::append(&mut rand_seed, bcs::to_bytes(&now_time));
        // let random_resource_quantities = ts_random_util::divide_int(
        //     clock,
        //     rand_seed,
        //     (resources_quantity as u64),
        //     3
        // );
        let resource_item_quantities = vector[
            1, // (*vector::borrow(&random_resource_quantities, 0) as u32),
            1, // (*vector::borrow(&random_resource_quantities, 1) as u32),
            1, // (*vector::borrow(&random_resource_quantities, 2) as u32),
        ];
        let resources = item_id_quantity_pairs::new(resource_item_ids, resource_item_quantities);

        let coordinates = coordinates::new(0, 0);// TODO: remove this
        map::new_island_resources_gathered(store_address, //map,
            player_id, //
            coordinates, item_id_quantity_pairs::items(&resources),
            0, //now_time
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        store_address: address,
        island_resources_gathered: &map::IslandResourcesGathered,
    ) {
        let player_id = map::island_resources_gathered_player_id(island_resources_gathered);
        let coordinates = map::island_resources_gathered_coordinates(island_resources_gathered);
        let resources = map::island_resources_gathered_resources(island_resources_gathered);
        let gathered_at = map::island_resources_gathered_gathered_at(island_resources_gathered);
        // ...
        //
    }


    /// Get the quantity of resources of the island to be gathered.
    public fun get_island_resources_quantity_to_gather(store_address: address, coordinates: Coordinates, now_time: u64): (MapLocation, u32) {
        //map: &Map,
        assert!(map::singleton_locations_contains(store_address, coordinates), ELocationNotFound);
        let island = map::singleton_remove_location(store_address, coordinates);
        assert!(map_location_type::island() == map_location::type(&island), ELocationNotAnIsland);
        let last_gathered_at = map_location::gathered_at(&island);
        let elapsed_time = now_time - last_gathered_at;
        if (elapsed_time >= ISLAND_RESOURCE_REGENERATION_TIME) {
            (island, ISLAND_RESOURCE_REGENERATION_QUANTITY)
        } else {
            (island, 0)
        }
    }
}
