module infinite_seas::player_claim_island_logic {
    use std::option;
    use std::vector;
    use aptos_framework::timestamp;
    use infinite_seas::genesis_account;
    use infinite_seas::player;
    use infinite_seas_common::coordinates::Coordinates;
    use infinite_seas_common::skill_type;
    use infinite_seas_common::sorted_vector_util;
    use infinite_seas_map::map;
    use infinite_seas_map::map_aggregate;
    use infinite_seas_map::map_location;

    friend infinite_seas::player_aggregate;

    const ESenderHasNoPermission: u64 = 22;
    const EPlayerAlreadyClaimedIsland: u64 = 23;

    public(friend) fun verify(
        account: &signer,
        coordinates: Coordinates,
        id: address,
        player: &player::Player,
    ): player::IslandClaimed {
        assert!(std::signer::address_of(account) == player::owner(player), ESenderHasNoPermission);
        assert!(option::is_none(&player::claimed_island(player)), EPlayerAlreadyClaimedIsland);
        let claimed_at = timestamp::now_seconds(); //clock::timestamp_ms(clock) / 1000;
        player::new_island_claimed(id, player, coordinates, claimed_at)
    }

    public(friend) fun mutate(
        _account: &signer,
        island_claimed: &player::IslandClaimed,
        id: address,
        player: player::Player,
    ): player::Player {
        let coordinates = player::island_claimed_coordinates(island_claimed);
        let claimed_at = player::island_claimed_claimed_at(island_claimed);

        let player_id = id;//player::id(player);

        player::set_claimed_island(&mut player, option::some(coordinates));

        let store_address = genesis_account::resource_account_address();
        // move resources from island to player inventory
        // TODO let island = map::borrow_location(map, coordinates);
        // let inv = player::borrow_mut_inventory(&mut player);
        // sorted_vector_util::merge_item_id_quantity_pairs(inv, map_location::borrow_resources(island));
        // // call map_aggregate::claim_island
        // map_aggregate::claim_island(_account, fwt, store_address, coordinates, player_id, claimed_at);

        // create rosters after claiming the island
        let roster_sequence_number: u32 = 0;
        while (roster_sequence_number < 5) {
            // 0-4
            //
            //TODO let r = roster_aggregate::create(player_id, roster_sequence_number, roster_status::at_anchor(), 0,
            //     coordinates, 0, option::none(), option::none(),
            //     option::none(), roster_table, ctx
            // );
            // roster::share_object(r);
            roster_sequence_number = roster_sequence_number + 1;
        };

        // create skill processes after claiming the island
        let skill_types = vector[
            skill_type::mining(), skill_type::woodcutting(), skill_type::farming(), skill_type::crafting()
        ];
        let i = 0;
        let l = vector::length(&skill_types);
        while (i < l) {
            let skill_type = *vector::borrow(&skill_types, i);
            //TODO let max_seq_number = infinite_seas::skill_process_util::skill_type_max_sequence_number(skill_type);
            let seq_number = 0;
            // while (seq_number <= max_seq_number) {
            //     //TODO skill_process_aggregate::create(skill_type, player_id, seq_number, player, skill_process_table, ctx);
            //     seq_number = seq_number + 1;
            // };
            i = i + 1;
        };

        player
    }

}
