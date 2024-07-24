module infinite_seas_map::map_gather_island_resources_logic {
    use std::bcs;
    use std::option;
    use std::vector;
    use infinite_seas_map::map;
    use infinite_seas_map::map_location::{Self, MapLocation};
    use infinite_seas_common::item_id;
    use infinite_seas_common::item_id_quantity_pairs;
    use infinite_seas_common::coordinates::Coordinates;
    use infinite_seas_common::map_location_type;
    use aptos_framework::timestamp;
    use infinite_seas_common::item_id_quantity_pairs::ItemIdQuantityPairs;
    use infinite_seas_common::ts_random_util;

    friend infinite_seas_map::map_aggregate;

    const EResourceNotRegeneratedYet: u64 = 10;

    const ELocationNotFound: u64 = 101;
    const ELocationNotAnIsland: u64 = 102;
    const EIslandNotOccupied: u64 = 103;
    const EPlayerIsNotIslandOwner: u64 = 104;

    /// Island resource regeneration time in seconds.
    const ISLAND_RESOURCE_REGENERATION_TIME: u64 = 60 * 60 * 24; // todo 1 day is a good value?

    /// Quantity of island resources regenerated.
    const ISLAND_RESOURCE_REGENERATION_QUANTITY: u32 = 600; // todo Is this a good value?

    public(friend) fun verify(
        account: &signer,
        store_address: address,      
        player_id: address,
        coordinates: Coordinates,
    ): map::IslandResourcesGathered {
        // permission_util::assert_sender_is_player_owner(player, ctx);
        let island = assert_player_is_island_owner(store_address, player_id, coordinates);
        let now_time = timestamp::now_seconds(); //clock::timestamp_ms(clock) / 1000;
        let resources_quantity = get_island_resources_quantity_to_gather(&island, //store_address, coordinates,
            now_time
        );
        map::singleton_add_location(store_address, island); // return the MapLocation back to the map.
        assert!(resources_quantity > 0, EResourceNotRegeneratedYet);

        let resource_item_ids = vector[item_id::resource_type_mining(), item_id::resource_type_woodcutting(), item_id::cotton_seeds()];
        let rand_seed = bcs::to_bytes(&coordinates);
        vector::append(&mut rand_seed, bcs::to_bytes(&player_id));
        vector::append(&mut rand_seed, bcs::to_bytes(&now_time));
        let random_resource_quantities = ts_random_util::divide_int(
            rand_seed,
            (resources_quantity as u64),
            3
        );
        let resource_item_quantities = vector[
            (*vector::borrow(&random_resource_quantities, 0) as u32),
            (*vector::borrow(&random_resource_quantities, 1) as u32),
            (*vector::borrow(&random_resource_quantities, 2) as u32),
        ];
        let resources = item_id_quantity_pairs::new(resource_item_ids, resource_item_quantities);

        map::new_island_resources_gathered(store_address,
            player_id,
            coordinates,
            item_id_quantity_pairs::items(&resources),
            now_time
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        store_address: address,
        island_resources_gathered: &map::IslandResourcesGathered,
    ): ItemIdQuantityPairs {
        let player_id = map::island_resources_gathered_player_id(island_resources_gathered);
        let coordinates = map::island_resources_gathered_coordinates(island_resources_gathered);
        let resources = map::island_resources_gathered_resources(island_resources_gathered);
        let gathered_at = map::island_resources_gathered_gathered_at(island_resources_gathered);

        let island = map::singleton_remove_location(store_address, coordinates);
        map_location::set_resources(&mut island, vector::empty());
        map_location::set_gathered_at(&mut island, gathered_at);
        map::singleton_add_location(store_address, island); // return the MapLocation back to the map.

        item_id_quantity_pairs::new_by_vector(resources)
    }


    fun assert_player_is_island_owner(store_address: address, player_id: address, coordinates: Coordinates): MapLocation {
        assert!(map::singleton_locations_contains(store_address, coordinates), ELocationNotFound);
        let island = map::singleton_remove_location(store_address, coordinates);
        assert!(map_location_type::island() == map_location::type(&island), ELocationNotAnIsland);
        let occupied_by = map_location::occupied_by(&island);
        assert!(option::is_some(&occupied_by), EIslandNotOccupied);
        assert!(option::extract(&mut occupied_by) == player_id, EPlayerIsNotIslandOwner);
        island
    }

    /// Get the quantity of resources of the island to be gathered.
    fun get_island_resources_quantity_to_gather(
        island: &MapLocation, //store_address: address, coordinates: Coordinates,
        now_time: u64
    ): u32 {
        // assert!(map::singleton_locations_contains(store_address, coordinates), ELocationNotFound);
        //let island = map::singleton_remove_location(store_address, coordinates);
        // assert!(map_location_type::island() == map_location::type(&island), ELocationNotAnIsland);
        let last_gathered_at = map_location::gathered_at(island);
        let elapsed_time = now_time - last_gathered_at;
        if (elapsed_time >= ISLAND_RESOURCE_REGENERATION_TIME) {
            ISLAND_RESOURCE_REGENERATION_QUANTITY
        } else {
            0
        }
    }
}
