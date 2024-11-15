// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas_player::player {
    use aptos_framework::account;
    use aptos_framework::event;
    use aptos_framework::object;
    use infinite_seas_common::coordinates::Coordinates;
    use infinite_seas_common::inventory_entry::InventoryEntry;
    use infinite_seas_common::item_id_quantity_pair::ItemIdQuantityPair;
    use infinite_seas_player::infinite_seas_player_pass_object as pass_object;
    use std::option::{Self, Option};
    use std::string::String;
    friend infinite_seas_player::player_create_logic;
    friend infinite_seas_player::player_update_logic;
    friend infinite_seas_player::player_claim_island_logic;
    friend infinite_seas_player::player_airdrop_logic;
    friend infinite_seas_player::player_gather_island_resources_logic;
    friend infinite_seas_player::player_aggregate;

    friend infinite_seas_player::player_properties;
    const EDataTooLong: u64 = 102;
    const EInappropriateVersion: u64 = 103;
    const ENotInitialized: u64 = 110;

    struct Events has key {
        player_created_handle: event::EventHandle<PlayerCreated>,
        player_updated_handle: event::EventHandle<PlayerUpdated>,
        island_claimed_handle: event::EventHandle<IslandClaimed>,
        player_airdropped_handle: event::EventHandle<PlayerAirdropped>,
        player_island_resources_gathered_handle: event::EventHandle<PlayerIslandResourcesGathered>,
    }

    struct FriendWitness has drop {}

    public(friend) fun friend_witness(): FriendWitness {
        FriendWitness {}
    }

    public fun initialize(store_account: &signer) {
        move_to(store_account, Events {
            player_created_handle: account::new_event_handle<PlayerCreated>(store_account),
            player_updated_handle: account::new_event_handle<PlayerUpdated>(store_account),
            island_claimed_handle: account::new_event_handle<IslandClaimed>(store_account),
            player_airdropped_handle: account::new_event_handle<PlayerAirdropped>(store_account),
            player_island_resources_gathered_handle: account::new_event_handle<PlayerIslandResourcesGathered>(store_account),
        });

    }

    #[resource_group_member(group = aptos_framework::object::ObjectGroup)]
    struct Player has key {
        version: u64,
        owner: address,
        level: u16,
        experience: u32,
        name: String,
        claimed_island: Option<Coordinates>,
        inventory: vector<ItemIdQuantityPair>,
    }

    #[resource_group_member(group = aptos_framework::object::ObjectGroup)]
    struct ObjectController has key {
        extend_ref: object::ExtendRef,
    }


    public(friend) fun save_object_controller(
        object_signer: &signer,
        extend_ref: object::ExtendRef,
    ) {
        move_to(
            object_signer,
            ObjectController {
                extend_ref,
            }
        )
    }

    public fun version(player: &Player): u64 {
        player.version
    }

    public fun owner(player: &Player): address {
        player.owner
    }

    public(friend) fun set_owner(player: &mut Player, owner: address) {
        player.owner = owner;
    }

    public fun level(player: &Player): u16 {
        player.level
    }

    public(friend) fun set_level(player: &mut Player, level: u16) {
        player.level = level;
    }

    public fun experience(player: &Player): u32 {
        player.experience
    }

    public(friend) fun set_experience(player: &mut Player, experience: u32) {
        player.experience = experience;
    }

    public fun name(player: &Player): String {
        player.name
    }

    public(friend) fun set_name(player: &mut Player, name: String) {
        assert!(std::string::length(&name) <= 50, EDataTooLong);
        player.name = name;
    }

    public fun claimed_island(player: &Player): Option<Coordinates> {
        player.claimed_island
    }

    public(friend) fun set_claimed_island(player: &mut Player, claimed_island: Option<Coordinates>) {
        player.claimed_island = claimed_island;
    }

    public fun borrow_inventory(player: &Player): &vector<ItemIdQuantityPair> {
        &player.inventory
    }

    public(friend) fun borrow_mut_inventory(player: &mut Player): &mut vector<ItemIdQuantityPair> {
        &mut player.inventory
    }

    public fun inventory(player: &Player): vector<ItemIdQuantityPair> {
        player.inventory
    }

    public(friend) fun set_inventory(player: &mut Player, inventory: vector<ItemIdQuantityPair>) {
        player.inventory = inventory;
    }

    public(friend) fun new_player(
        owner: address,
        name: String,
        inventory: vector<ItemIdQuantityPair>,
    ): Player {
        assert!(std::string::length(&name) <= 50, EDataTooLong);
        Player {
            version: 0,
            owner,
            level: 1,
            experience: 0,
            name,
            claimed_island: std::option::none(),
            inventory,
        }
    }

    struct PlayerCreated has store, drop {
        id: option::Option<address>,
        name: String,
        owner: address,
    }

    public fun player_created_id(player_created: &PlayerCreated): option::Option<address> {
        player_created.id
    }

    public(friend) fun set_player_created_id(player_created: &mut PlayerCreated, id: address) {
        player_created.id = option::some(id);
    }

    public fun player_created_name(player_created: &PlayerCreated): String {
        player_created.name
    }

    public fun player_created_owner(player_created: &PlayerCreated): address {
        player_created.owner
    }

    public(friend) fun new_player_created(
        name: String,
        owner: address,
    ): PlayerCreated {
        PlayerCreated {
            id: option::none(),
            name,
            owner,
        }
    }

    struct PlayerUpdated has store, drop {
        id: address,
        version: u64,
        experience_gained: Option<u32>,
        new_level: Option<u16>,
        inventory_entries: vector<InventoryEntry>,
    }

    public fun player_updated_id(player_updated: &PlayerUpdated): address {
        player_updated.id
    }

    public fun player_updated_experience_gained(player_updated: &PlayerUpdated): Option<u32> {
        player_updated.experience_gained
    }

    public(friend) fun set_player_updated_experience_gained(player_updated: &mut PlayerUpdated, experience_gained: Option<u32>) {
        player_updated.experience_gained = experience_gained;
    }

    public fun player_updated_new_level(player_updated: &PlayerUpdated): Option<u16> {
        player_updated.new_level
    }

    public(friend) fun set_player_updated_new_level(player_updated: &mut PlayerUpdated, new_level: Option<u16>) {
        player_updated.new_level = new_level;
    }

    public fun player_updated_inventory_entries(player_updated: &PlayerUpdated): vector<InventoryEntry> {
        player_updated.inventory_entries
    }

    public(friend) fun new_player_updated(
        id: address,
        player: &Player,
        experience_gained: Option<u32>,
        new_level: Option<u16>,
        inventory_entries: vector<InventoryEntry>,
    ): PlayerUpdated {
        PlayerUpdated {
            id,
            version: version(player),
            experience_gained,
            new_level,
            inventory_entries,
        }
    }

    struct IslandClaimed has store, drop {
        id: address,
        version: u64,
        coordinates: Coordinates,
        claimed_at: u64,
    }

    public fun island_claimed_id(island_claimed: &IslandClaimed): address {
        island_claimed.id
    }

    public fun island_claimed_coordinates(island_claimed: &IslandClaimed): Coordinates {
        island_claimed.coordinates
    }

    public fun island_claimed_claimed_at(island_claimed: &IslandClaimed): u64 {
        island_claimed.claimed_at
    }

    public(friend) fun new_island_claimed(
        id: address,
        player: &Player,
        coordinates: Coordinates,
        claimed_at: u64,
    ): IslandClaimed {
        IslandClaimed {
            id,
            version: version(player),
            coordinates,
            claimed_at,
        }
    }

    struct PlayerAirdropped has store, drop {
        id: address,
        version: u64,
        item_id: u32,
        quantity: u32,
    }

    public fun player_airdropped_id(player_airdropped: &PlayerAirdropped): address {
        player_airdropped.id
    }

    public fun player_airdropped_item_id(player_airdropped: &PlayerAirdropped): u32 {
        player_airdropped.item_id
    }

    public fun player_airdropped_quantity(player_airdropped: &PlayerAirdropped): u32 {
        player_airdropped.quantity
    }

    public(friend) fun new_player_airdropped(
        id: address,
        player: &Player,
        item_id: u32,
        quantity: u32,
    ): PlayerAirdropped {
        PlayerAirdropped {
            id,
            version: version(player),
            item_id,
            quantity,
        }
    }

    struct PlayerIslandResourcesGathered has store, drop {
        id: address,
        version: u64,
    }

    public fun player_island_resources_gathered_id(player_island_resources_gathered: &PlayerIslandResourcesGathered): address {
        player_island_resources_gathered.id
    }

    public(friend) fun new_player_island_resources_gathered(
        id: address,
        player: &Player,
    ): PlayerIslandResourcesGathered {
        PlayerIslandResourcesGathered {
            id,
            version: version(player),
        }
    }


    public(friend) fun update_version_and_add(obj_addr: address, player: Player) acquires ObjectController {
        player.version = player.version + 1;
        let extend_ref = &borrow_global<ObjectController>(obj_addr).extend_ref;
        let object_signer = object::generate_signer_for_extending(extend_ref);
        private_add_player(&object_signer, player)
    }

    public(friend) fun add_player(object_signer: &signer, player: Player) {
        assert!(player.version == 0, EInappropriateVersion);
        private_add_player(object_signer, player);
    }

    public(friend) fun remove_player(obj_addr: address): Player acquires Player {
        move_from<Player>(obj_addr)
    }

    fun private_add_player(object_signer: &signer, player: Player) {
        move_to(object_signer, player);
    }

    public fun get_player(obj_addr: address): pass_object::PassObject<Player> acquires Player {
        let player = remove_player(obj_addr);
        pass_object::new_with_address(player, obj_addr)
    }

    public fun return_player(player_pass_obj: pass_object::PassObject<Player>) acquires ObjectController {
        let (player, obj_addr) = pass_object::extract_value_and_address(player_pass_obj);
        let extend_ref = &borrow_global<ObjectController>(obj_addr).extend_ref;
        let object_signer = object::generate_signer_for_extending(extend_ref);
        private_add_player(&object_signer, player);
    }

    public fun borrow(player_pass_obj: &pass_object::PassObject<Player>): &Player {
        pass_object::borrow(player_pass_obj)
    }

    public(friend) fun borrow_mut(player_pass_obj: &mut pass_object::PassObject<Player>): &mut Player {
        pass_object::borrow_mut(player_pass_obj)
    }

    public(friend) fun object_signer(obj_addr: address): signer acquires ObjectController {
        let extend_ref = &borrow_global<ObjectController>(obj_addr).extend_ref;
        object::generate_signer_for_extending(extend_ref)
    }

    public(friend) fun drop_player(player: Player) {
        let Player {
            version: _version,
            owner: _owner,
            level: _level,
            experience: _experience,
            name: _name,
            claimed_island: _claimed_island,
            inventory: _inventory,
        } = player;
    }

    public(friend) fun emit_player_created(store_address: address, player_created: PlayerCreated) acquires Events {
        assert!(exists<Events>(store_address), ENotInitialized);
        let events = borrow_global_mut<Events>(store_address);
        event::emit_event(&mut events.player_created_handle, player_created);
    }

    public(friend) fun emit_player_updated(store_address: address, player_updated: PlayerUpdated) acquires Events {
        assert!(exists<Events>(store_address), ENotInitialized);
        let events = borrow_global_mut<Events>(store_address);
        event::emit_event(&mut events.player_updated_handle, player_updated);
    }

    public(friend) fun emit_island_claimed(store_address: address, island_claimed: IslandClaimed) acquires Events {
        assert!(exists<Events>(store_address), ENotInitialized);
        let events = borrow_global_mut<Events>(store_address);
        event::emit_event(&mut events.island_claimed_handle, island_claimed);
    }

    public(friend) fun emit_player_airdropped(store_address: address, player_airdropped: PlayerAirdropped) acquires Events {
        assert!(exists<Events>(store_address), ENotInitialized);
        let events = borrow_global_mut<Events>(store_address);
        event::emit_event(&mut events.player_airdropped_handle, player_airdropped);
    }

    public(friend) fun emit_player_island_resources_gathered(store_address: address, player_island_resources_gathered: PlayerIslandResourcesGathered) acquires Events {
        assert!(exists<Events>(store_address), ENotInitialized);
        let events = borrow_global_mut<Events>(store_address);
        event::emit_event(&mut events.player_island_resources_gathered_handle, player_island_resources_gathered);
    }

}
