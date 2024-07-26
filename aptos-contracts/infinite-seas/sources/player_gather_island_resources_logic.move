module infinite_seas::player_gather_island_resources_logic {
    use std::option;
    use infinite_seas_common::item_id_quantity_pairs;
    use infinite_seas::player_properties;
    use infinite_seas::genesis_account;
    use infinite_seas_map::map_aggregate;
    use infinite_seas::permission_util;
    use infinite_seas::player;

    friend infinite_seas::player_aggregate;

    public(friend) fun verify(
        account: &signer,
        id: address,
        player: &player::Player,
    ): player::PlayerIslandResourcesGathered {
        permission_util::assert_sender_is_player_owner(player, account);
        player::new_player_island_resources_gathered(
            id,
            player,
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        player_island_resources_gathered: &player::PlayerIslandResourcesGathered,
        id: address,
        player: player::Player,
    ): player::Player {
        let coordinates_o = player::claimed_island(&player);
        let resources = map_aggregate::gather_island_resources(
            player::friend_witness(),
            _account,
            genesis_account::resource_account_address(),
            id,
            option::extract(&mut coordinates_o),
        );
        player_properties::increase_inventory(&mut player, item_id_quantity_pairs::items(&resources));
        player
    }

}
