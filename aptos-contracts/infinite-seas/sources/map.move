// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas::map {
    use aptos_framework::account;
    use aptos_framework::event;
    use aptos_std::table_with_length::{Self, TableWithLength};
    use infinite_seas::genesis_account;
    use infinite_seas::map_location::{Self, MapLocation};
    use infinite_seas::pass_object;
    use infinite_seas_common::coordinates::Coordinates;
    use infinite_seas_common::item_id_quantity_pair::ItemIdQuantityPair;
    use infinite_seas_common::item_id_quantity_pairs::ItemIdQuantityPairs;
    friend infinite_seas::map_add_island_logic;
    friend infinite_seas::map_claim_island_logic;
    friend infinite_seas::map_gather_island_resources_logic;
    friend infinite_seas::map_aggregate;

    const EIdAlreadyExists: u64 = 101;
    const EDataTooLong: u64 = 102;
    const EInappropriateVersion: u64 = 103;
    const ENotInitialized: u64 = 110;
    const EIdNotFound: u64 = 111;

    struct Events has key {
        island_added_handle: event::EventHandle<IslandAdded>,
        map_island_claimed_handle: event::EventHandle<MapIslandClaimed>,
        island_resources_gathered_handle: event::EventHandle<IslandResourcesGathered>,
        map_location_table_item_added_handle: event::EventHandle<MapLocationTableItemAdded>,
    }

    struct MapLocationTableItemAdded has store, drop {
        coordinates: Coordinates,
    }

    fun emit_map_location_table_item_added(table_item_added: MapLocationTableItemAdded) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.map_location_table_item_added_handle, table_item_added);
    }

    public fun initialize(account: &signer) {
        genesis_account::assert_genesis_account(account);

        let res_account = genesis_account::resource_account_signer();
        move_to(&res_account, Events {
            island_added_handle: account::new_event_handle<IslandAdded>(&res_account),
            map_island_claimed_handle: account::new_event_handle<MapIslandClaimed>(&res_account),
            island_resources_gathered_handle: account::new_event_handle<IslandResourcesGathered>(&res_account),
            map_location_table_item_added_handle: account::new_event_handle<MapLocationTableItemAdded>(&res_account),
        });

    }

    struct Map has key, store {
        version: u64,
        locations: TableWithLength<Coordinates, MapLocation>,
    }

    public fun version(map: &Map): u64 {
        map.version
    }

    public(friend) fun add_location(map: &mut Map, location: MapLocation) acquires Events {
        let coordinates = map_location::coordinates(&location);
        assert!(!table_with_length::contains(&map.locations, coordinates), EIdAlreadyExists);
        table_with_length::add(&mut map.locations, coordinates, location);
        emit_map_location_table_item_added(MapLocationTableItemAdded {
            //Xxx entity.OuterEntity is SingletonObject
            coordinates,
        });
    }

    public(friend) fun remove_location(map: &mut Map, coordinates: Coordinates) {
        assert!(table_with_length::contains(&map.locations, coordinates), EIdNotFound);
        let location = table_with_length::remove(&mut map.locations, coordinates);
        map_location::drop_map_location(location);
    }

    public(friend) fun borrow_mut_location(map: &mut Map, coordinates: Coordinates): &mut MapLocation {
        table_with_length::borrow_mut(&mut map.locations, coordinates)
    }

    public fun borrow_location(map: &Map, coordinates: Coordinates): &MapLocation {
        table_with_length::borrow(&map.locations, coordinates)
    }

    public fun locations_contains(map: &Map, coordinates: Coordinates): bool {
        table_with_length::contains(&map.locations, coordinates)
    }

    public fun locations_length(map: &Map): u64 {
        table_with_length::length(&map.locations)
    }

    public(friend) fun new_map(
    ): Map {
        Map {
            version: 0,
            locations: table_with_length::new<Coordinates, MapLocation>(),
        }
    }

    struct IslandAdded has store, drop {
        version: u64,
        coordinates: Coordinates,
        resources: ItemIdQuantityPairs,
    }

    public fun island_added_coordinates(island_added: &IslandAdded): Coordinates {
        island_added.coordinates
    }

    public fun island_added_resources(island_added: &IslandAdded): ItemIdQuantityPairs {
        island_added.resources
    }

    public(friend) fun new_island_added(
        map: &Map,
        coordinates: Coordinates,
        resources: ItemIdQuantityPairs,
    ): IslandAdded {
        IslandAdded {
            version: version(map),
            coordinates,
            resources,
        }
    }

    struct MapIslandClaimed has store, drop {
        version: u64,
        coordinates: Coordinates,
        claimed_by: address,
        claimed_at: u64,
    }

    public fun map_island_claimed_coordinates(map_island_claimed: &MapIslandClaimed): Coordinates {
        map_island_claimed.coordinates
    }

    public fun map_island_claimed_claimed_by(map_island_claimed: &MapIslandClaimed): address {
        map_island_claimed.claimed_by
    }

    public fun map_island_claimed_claimed_at(map_island_claimed: &MapIslandClaimed): u64 {
        map_island_claimed.claimed_at
    }

    public(friend) fun new_map_island_claimed(
        map: &Map,
        coordinates: Coordinates,
        claimed_by: address,
        claimed_at: u64,
    ): MapIslandClaimed {
        MapIslandClaimed {
            version: version(map),
            coordinates,
            claimed_by,
            claimed_at,
        }
    }

    struct IslandResourcesGathered has store, drop {
        version: u64,
        player_id: address,
        coordinates: Coordinates,
        resources: vector<ItemIdQuantityPair>,
        gathered_at: u64,
    }

    public fun island_resources_gathered_player_id(island_resources_gathered: &IslandResourcesGathered): address {
        island_resources_gathered.player_id
    }

    public fun island_resources_gathered_coordinates(island_resources_gathered: &IslandResourcesGathered): Coordinates {
        island_resources_gathered.coordinates
    }

    public fun island_resources_gathered_resources(island_resources_gathered: &IslandResourcesGathered): vector<ItemIdQuantityPair> {
        island_resources_gathered.resources
    }

    public fun island_resources_gathered_gathered_at(island_resources_gathered: &IslandResourcesGathered): u64 {
        island_resources_gathered.gathered_at
    }

    public(friend) fun new_island_resources_gathered(
        map: &Map,
        player_id: address,
        coordinates: Coordinates,
        resources: vector<ItemIdQuantityPair>,
        gathered_at: u64,
    ): IslandResourcesGathered {
        IslandResourcesGathered {
            version: version(map),
            player_id,
            coordinates,
            resources,
            gathered_at,
        }
    }


    public(friend) fun update_version_and_add(map: Map) {
        map.version = map.version + 1;
        //assert!(map.version != 0, EInappropriateVersion);
        private_add_map(map);
    }

    public(friend) fun add_map(map: Map) {
        assert!(map.version == 0, EInappropriateVersion);
        private_add_map(map);
    }

    public(friend) fun remove_map(): Map acquires Map {
        assert!(exists<Map>(genesis_account::resource_account_address()), ENotInitialized);
        move_from<Map>(genesis_account::resource_account_address())
    }

    fun private_add_map(map: Map) {
        move_to(&genesis_account::resource_account_signer(), map);
    }

    public fun get_map(): pass_object::PassObject<Map> acquires Map {
        let map = remove_map();
        pass_object::new(map)
    }

    public fun return_map(map_pass_obj: pass_object::PassObject<Map>) {
        let map = pass_object::extract(map_pass_obj);
        private_add_map(map);
    }

    public(friend) fun drop_map(map: Map) {
        let Map {
            version: _version,
            locations,
        } = map;
        table_with_length::destroy_empty(locations);
    }

    public fun map_exists(): bool {
        exists<Map>(genesis_account::resource_account_address())
    }

    public(friend) fun emit_island_added(island_added: IslandAdded) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.island_added_handle, island_added);
    }

    public(friend) fun emit_map_island_claimed(map_island_claimed: MapIslandClaimed) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.map_island_claimed_handle, map_island_claimed);
    }

    public(friend) fun emit_island_resources_gathered(island_resources_gathered: IslandResourcesGathered) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.island_resources_gathered_handle, island_resources_gathered);
    }

}
