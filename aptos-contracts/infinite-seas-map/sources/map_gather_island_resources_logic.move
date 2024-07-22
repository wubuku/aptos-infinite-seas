module infinite_seas_map::map_gather_island_resources_logic {
    use infinite_seas_map::map;
    use infinite_seas_map::map_location::{Self, MapLocation};
    use infinite_seas_common::item_id;
    use infinite_seas_common::item_id_quantity_pairs;
    use infinite_seas_common::coordinates;

    friend infinite_seas_map::map_aggregate;

    const EResourceNotRegeneratedYet: u64 = 10;

    public(friend) fun verify(
        account: &signer,
        store_address: address,      
        player_id: address,
    ): map::IslandResourcesGathered {
        // TODO: xxx
        // permission_util::assert_sender_is_player_owner(player, ctx);
        // permission_util::assert_player_is_island_owner(player, map);
        // let coordinates = option::extract(&mut player::claimed_island(player));
        // let now_time = clock::timestamp_ms(clock) / 1000;
        // let resources_quantity = map_util::get_island_resources_quantity_to_gather(map, coordinates, now_time);
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

}
