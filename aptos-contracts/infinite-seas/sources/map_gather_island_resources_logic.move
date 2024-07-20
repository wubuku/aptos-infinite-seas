module infinite_seas::map_gather_island_resources_logic {
    use aptos_framework::object::Object;
    use infinite_seas::map;
    use infinite_seas::player::Player;

    friend infinite_seas::map_aggregate;

    public(friend) fun verify(
        account: &signer,
        player: Object<Player>,
        map: &map::Map,
    ): map::IslandResourcesGathered {
        // ...
        //
    }

    public(friend) fun mutate(
        _account: &signer,
        island_resources_gathered: &map::IslandResourcesGathered,
        map: map::Map,
    ): map::Map {
        let player_id = map::island_resources_gathered_player_id(island_resources_gathered);
        let coordinates = map::island_resources_gathered_coordinates(island_resources_gathered);
        let resources = map::island_resources_gathered_resources(island_resources_gathered);
        let gathered_at = map::island_resources_gathered_gathered_at(island_resources_gathered);
        // ...
        //
    }

}
