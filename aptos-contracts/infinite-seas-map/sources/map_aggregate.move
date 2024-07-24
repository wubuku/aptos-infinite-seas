// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas_map::map_aggregate {
    use infinite_seas_common::coordinates::{Self, Coordinates};
    use infinite_seas_common::item_id_quantity_pairs::{Self, ItemIdQuantityPairs};
    use infinite_seas_map::map_friend_config;
    use infinite_seas_map::map;
    use infinite_seas_map::map_add_island_logic;
    use infinite_seas_map::map_claim_island_logic;
    use infinite_seas_map::map_gather_island_resources_logic;

    const ENotPublisher: u64 = 50;

    public entry fun add_island(
        account: &signer,
        store_address: address,
        coordinates_x: u32,
        coordinates_y: u32,
        resources_item_id_list: vector<u32>,
        resources_item_quantity_list: vector<u32>,
    ) {
        assert!(std::signer::address_of(account) == @infinite_seas_map, ENotPublisher);
        let coordinates: Coordinates = coordinates::new(
            coordinates_x,
            coordinates_y,
        );
        let resources: ItemIdQuantityPairs = item_id_quantity_pairs::new(
            resources_item_id_list,
            resources_item_quantity_list,
        );
        let island_added = map_add_island_logic::verify(
            account,
            store_address,
            coordinates,
            resources,
        );
        map_add_island_logic::mutate(
            account,
            store_address,
            &island_added,
        );
        map::emit_island_added(store_address, island_added);
    }

    public fun claim_island<FWT: drop>(
        account: &signer,
        _friend_witness: FWT,
        store_address: address,
        coordinates: Coordinates,
        claimed_by: address,
        claimed_at: u64,
    ) {
        map_friend_config::assert_allowlisted(_friend_witness);
        let map_island_claimed = map_claim_island_logic::verify(
            account,
            store_address,
            coordinates,
            claimed_by,
            claimed_at,
        );
        map_claim_island_logic::mutate(
            account,
            store_address,
            &map_island_claimed,
        );
        map::emit_map_island_claimed(store_address, map_island_claimed);
    }

    public fun gather_island_resources<FWT: drop>(
        account: &signer,
        _friend_witness: FWT,
        store_address: address,
        player_id: address,
        coordinates: Coordinates,
    ): ItemIdQuantityPairs {
        map_friend_config::assert_allowlisted(_friend_witness);
        let island_resources_gathered = map_gather_island_resources_logic::verify(
            account,
            store_address,
            player_id,
            coordinates,
        );
        let gather_island_resources_return = map_gather_island_resources_logic::mutate(
            account,
            store_address,
            &island_resources_gathered,
        );
        map::emit_island_resources_gathered(store_address, island_resources_gathered);
        gather_island_resources_return
    }

}
