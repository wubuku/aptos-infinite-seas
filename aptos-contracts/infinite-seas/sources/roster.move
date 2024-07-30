// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas::roster {
    use aptos_framework::account;
    use aptos_framework::event;
    use aptos_framework::object::{Self, Object};
    use infinite_seas::genesis_account;
    use infinite_seas::pass_object;
    use infinite_seas::player::Player;
    use infinite_seas::ship::Ship;
    use infinite_seas_common::coordinates::Coordinates;
    use infinite_seas_common::item_id_quantity_pairs::ItemIdQuantityPairs;
    use infinite_seas_common::roster_id::RosterId;
    use std::option::{Self, Option};
    friend infinite_seas::roster_create_logic;
    friend infinite_seas::roster_create_environment_roster_logic;
    friend infinite_seas::roster_add_ship_logic;
    friend infinite_seas::roster_set_sail_logic;
    friend infinite_seas::roster_adjust_ships_position_logic;
    friend infinite_seas::roster_transfer_ship_logic;
    friend infinite_seas::roster_take_out_ship_inventory_logic;
    friend infinite_seas::roster_put_in_ship_inventory_logic;
    friend infinite_seas::roster_aggregate;

    friend infinite_seas::ship_battle_initiate_battle_logic;

    const EDataTooLong: u64 = 102;
    const EInappropriateVersion: u64 = 103;
    const ENotInitialized: u64 = 110;

    struct Events has key {
        roster_created_handle: event::EventHandle<RosterCreated>,
        environment_roster_created_handle: event::EventHandle<EnvironmentRosterCreated>,
        roster_ship_added_handle: event::EventHandle<RosterShipAdded>,
        roster_set_sail_handle: event::EventHandle<RosterSetSail>,
        roster_ships_position_adjusted_handle: event::EventHandle<RosterShipsPositionAdjusted>,
        roster_ship_transferred_handle: event::EventHandle<RosterShipTransferred>,
        roster_ship_inventory_taken_out_handle: event::EventHandle<RosterShipInventoryTakenOut>,
        roster_ship_inventory_put_in_handle: event::EventHandle<RosterShipInventoryPutIn>,
    }

    public fun initialize(account: &signer) {
        genesis_account::assert_genesis_account(account);

        let res_account = genesis_account::resource_account_signer();
        move_to(&res_account, Events {
            roster_created_handle: account::new_event_handle<RosterCreated>(&res_account),
            environment_roster_created_handle: account::new_event_handle<EnvironmentRosterCreated>(&res_account),
            roster_ship_added_handle: account::new_event_handle<RosterShipAdded>(&res_account),
            roster_set_sail_handle: account::new_event_handle<RosterSetSail>(&res_account),
            roster_ships_position_adjusted_handle: account::new_event_handle<RosterShipsPositionAdjusted>(&res_account),
            roster_ship_transferred_handle: account::new_event_handle<RosterShipTransferred>(&res_account),
            roster_ship_inventory_taken_out_handle: account::new_event_handle<RosterShipInventoryTakenOut>(&res_account),
            roster_ship_inventory_put_in_handle: account::new_event_handle<RosterShipInventoryPutIn>(&res_account),
        });

    }

    #[resource_group_member(group = aptos_framework::object::ObjectGroup)]
    struct Roster has key {
        version: u64,
        roster_id: RosterId,
        status: u8,
        speed: u32,
        ship_ids: vector<address>,
        updated_coordinates: Coordinates,
        coordinates_updated_at: u64,
        target_coordinates: Option<Coordinates>,
        origin_coordinates: Option<Coordinates>,
        sail_duration: u64,
        ship_battle_id: Option<address>,
        environment_owned: bool,
        base_experience: Option<u32>,
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

    public fun version(roster: &Roster): u64 {
        roster.version
    }

    public fun roster_id(roster: &Roster): RosterId {
        roster.roster_id
    }

    public(friend) fun set_roster_id(roster: &mut Roster, roster_id: RosterId) {
        roster.roster_id = roster_id;
    }

    public fun status(roster: &Roster): u8 {
        roster.status
    }

    public(friend) fun set_status(roster: &mut Roster, status: u8) {
        roster.status = status;
    }

    public fun speed(roster: &Roster): u32 {
        roster.speed
    }

    public(friend) fun set_speed(roster: &mut Roster, speed: u32) {
        roster.speed = speed;
    }

    public fun borrow_ship_ids(roster: &Roster): &vector<address> {
        &roster.ship_ids
    }

    public(friend) fun borrow_mut_ship_ids(roster: &mut Roster): &mut vector<address> {
        &mut roster.ship_ids
    }

    public fun ship_ids(roster: &Roster): vector<address> {
        roster.ship_ids
    }

    public(friend) fun set_ship_ids(roster: &mut Roster, ship_ids: vector<address>) {
        roster.ship_ids = ship_ids;
    }

    public fun updated_coordinates(roster: &Roster): Coordinates {
        roster.updated_coordinates
    }

    public(friend) fun set_updated_coordinates(roster: &mut Roster, updated_coordinates: Coordinates) {
        roster.updated_coordinates = updated_coordinates;
    }

    public fun coordinates_updated_at(roster: &Roster): u64 {
        roster.coordinates_updated_at
    }

    public(friend) fun set_coordinates_updated_at(roster: &mut Roster, coordinates_updated_at: u64) {
        roster.coordinates_updated_at = coordinates_updated_at;
    }

    public fun target_coordinates(roster: &Roster): Option<Coordinates> {
        roster.target_coordinates
    }

    public(friend) fun set_target_coordinates(roster: &mut Roster, target_coordinates: Option<Coordinates>) {
        roster.target_coordinates = target_coordinates;
    }

    public fun origin_coordinates(roster: &Roster): Option<Coordinates> {
        roster.origin_coordinates
    }

    public(friend) fun set_origin_coordinates(roster: &mut Roster, origin_coordinates: Option<Coordinates>) {
        roster.origin_coordinates = origin_coordinates;
    }

    public fun sail_duration(roster: &Roster): u64 {
        roster.sail_duration
    }

    public(friend) fun set_sail_duration(roster: &mut Roster, sail_duration: u64) {
        roster.sail_duration = sail_duration;
    }

    public fun ship_battle_id(roster: &Roster): Option<address> {
        roster.ship_battle_id
    }

    public(friend) fun set_ship_battle_id(roster: &mut Roster, ship_battle_id: Option<address>) {
        roster.ship_battle_id = ship_battle_id;
    }

    public fun environment_owned(roster: &Roster): bool {
        roster.environment_owned
    }

    public(friend) fun set_environment_owned(roster: &mut Roster, environment_owned: bool) {
        roster.environment_owned = environment_owned;
    }

    public fun base_experience(roster: &Roster): Option<u32> {
        roster.base_experience
    }

    public(friend) fun set_base_experience(roster: &mut Roster, base_experience: Option<u32>) {
        roster.base_experience = base_experience;
    }

    public(friend) fun new_roster(
        roster_id: RosterId,
        status: u8,
        speed: u32,
        updated_coordinates: Coordinates,
        coordinates_updated_at: u64,
        target_coordinates: Option<Coordinates>,
        origin_coordinates: Option<Coordinates>,
        ship_battle_id: Option<address>,
    ): Roster {
        Roster {
            version: 0,
            roster_id,
            status,
            speed,
            ship_ids: std::vector::empty(),
            updated_coordinates,
            coordinates_updated_at,
            target_coordinates,
            origin_coordinates,
            sail_duration: 0,
            ship_battle_id,
            environment_owned: false,
            base_experience: std::option::none(),
        }
    }

    struct RosterCreated has store, drop {
        id: option::Option<address>,
        roster_id: RosterId,
        status: u8,
        speed: u32,
        updated_coordinates: Coordinates,
        coordinates_updated_at: u64,
        target_coordinates: Option<Coordinates>,
        origin_coordinates: Option<Coordinates>,
        ship_battle_id: Option<address>,
    }

    public fun roster_created_id(roster_created: &RosterCreated): option::Option<address> {
        roster_created.id
    }

    public(friend) fun set_roster_created_id(roster_created: &mut RosterCreated, id: address) {
        roster_created.id = option::some(id);
    }

    public fun roster_created_roster_id(roster_created: &RosterCreated): RosterId {
        roster_created.roster_id
    }

    public fun roster_created_status(roster_created: &RosterCreated): u8 {
        roster_created.status
    }

    public fun roster_created_speed(roster_created: &RosterCreated): u32 {
        roster_created.speed
    }

    public fun roster_created_updated_coordinates(roster_created: &RosterCreated): Coordinates {
        roster_created.updated_coordinates
    }

    public fun roster_created_coordinates_updated_at(roster_created: &RosterCreated): u64 {
        roster_created.coordinates_updated_at
    }

    public fun roster_created_target_coordinates(roster_created: &RosterCreated): Option<Coordinates> {
        roster_created.target_coordinates
    }

    public(friend) fun set_roster_created_target_coordinates(roster_created: &mut RosterCreated, target_coordinates: Option<Coordinates>) {
        roster_created.target_coordinates = target_coordinates;
    }

    public fun roster_created_origin_coordinates(roster_created: &RosterCreated): Option<Coordinates> {
        roster_created.origin_coordinates
    }

    public(friend) fun set_roster_created_origin_coordinates(roster_created: &mut RosterCreated, origin_coordinates: Option<Coordinates>) {
        roster_created.origin_coordinates = origin_coordinates;
    }

    public fun roster_created_ship_battle_id(roster_created: &RosterCreated): Option<address> {
        roster_created.ship_battle_id
    }

    public(friend) fun set_roster_created_ship_battle_id(roster_created: &mut RosterCreated, ship_battle_id: Option<address>) {
        roster_created.ship_battle_id = ship_battle_id;
    }

    public(friend) fun new_roster_created(
        roster_id: RosterId,
        status: u8,
        speed: u32,
        updated_coordinates: Coordinates,
        coordinates_updated_at: u64,
        target_coordinates: Option<Coordinates>,
        origin_coordinates: Option<Coordinates>,
        ship_battle_id: Option<address>,
    ): RosterCreated {
        RosterCreated {
            id: option::none(),
            roster_id,
            status,
            speed,
            updated_coordinates,
            coordinates_updated_at,
            target_coordinates,
            origin_coordinates,
            ship_battle_id,
        }
    }

    struct EnvironmentRosterCreated has store, drop {
        id: option::Option<address>,
        roster_id: RosterId,
        coordinates: Coordinates,
        ship_resource_quantity: u32,
        ship_base_resource_quantity: u32,
        base_experience: u32,
    }

    public fun environment_roster_created_id(environment_roster_created: &EnvironmentRosterCreated): option::Option<address> {
        environment_roster_created.id
    }

    public(friend) fun set_environment_roster_created_id(environment_roster_created: &mut EnvironmentRosterCreated, id: address) {
        environment_roster_created.id = option::some(id);
    }

    public fun environment_roster_created_roster_id(environment_roster_created: &EnvironmentRosterCreated): RosterId {
        environment_roster_created.roster_id
    }

    public fun environment_roster_created_coordinates(environment_roster_created: &EnvironmentRosterCreated): Coordinates {
        environment_roster_created.coordinates
    }

    public fun environment_roster_created_ship_resource_quantity(environment_roster_created: &EnvironmentRosterCreated): u32 {
        environment_roster_created.ship_resource_quantity
    }

    public fun environment_roster_created_ship_base_resource_quantity(environment_roster_created: &EnvironmentRosterCreated): u32 {
        environment_roster_created.ship_base_resource_quantity
    }

    public fun environment_roster_created_base_experience(environment_roster_created: &EnvironmentRosterCreated): u32 {
        environment_roster_created.base_experience
    }

    public(friend) fun new_environment_roster_created(
        roster_id: RosterId,
        coordinates: Coordinates,
        ship_resource_quantity: u32,
        ship_base_resource_quantity: u32,
        base_experience: u32,
    ): EnvironmentRosterCreated {
        EnvironmentRosterCreated {
            id: option::none(),
            roster_id,
            coordinates,
            ship_resource_quantity,
            ship_base_resource_quantity,
            base_experience,
        }
    }

    struct RosterShipAdded has store, drop {
        id: address,
        version: u64,
        ship: Object<Ship>,
        position: Option<u64>,
    }

    public fun roster_ship_added_id(roster_ship_added: &RosterShipAdded): address {
        roster_ship_added.id
    }

    public fun roster_ship_added_ship(roster_ship_added: &RosterShipAdded): Object<Ship> {
        roster_ship_added.ship
    }

    public fun roster_ship_added_position(roster_ship_added: &RosterShipAdded): Option<u64> {
        roster_ship_added.position
    }

    public(friend) fun set_roster_ship_added_position(roster_ship_added: &mut RosterShipAdded, position: Option<u64>) {
        roster_ship_added.position = position;
    }

    public(friend) fun new_roster_ship_added(
        id: address,
        roster: &Roster,
        ship: Object<Ship>,
        position: Option<u64>,
    ): RosterShipAdded {
        RosterShipAdded {
            id,
            version: version(roster),
            ship,
            position,
        }
    }

    struct RosterSetSail has store, drop {
        id: address,
        version: u64,
        player_id: Object<Player>,
        target_coordinates: Coordinates,
        sail_duration: u64,
        set_sail_at: u64,
        updated_coordinates: Coordinates,
        energy_cost: u64,
    }

    public fun roster_set_sail_id(roster_set_sail: &RosterSetSail): address {
        roster_set_sail.id
    }

    public fun roster_set_sail_player_id(roster_set_sail: &RosterSetSail): Object<Player> {
        roster_set_sail.player_id
    }

    public fun roster_set_sail_target_coordinates(roster_set_sail: &RosterSetSail): Coordinates {
        roster_set_sail.target_coordinates
    }

    public fun roster_set_sail_sail_duration(roster_set_sail: &RosterSetSail): u64 {
        roster_set_sail.sail_duration
    }

    public fun roster_set_sail_set_sail_at(roster_set_sail: &RosterSetSail): u64 {
        roster_set_sail.set_sail_at
    }

    public fun roster_set_sail_updated_coordinates(roster_set_sail: &RosterSetSail): Coordinates {
        roster_set_sail.updated_coordinates
    }

    public fun roster_set_sail_energy_cost(roster_set_sail: &RosterSetSail): u64 {
        roster_set_sail.energy_cost
    }

    public(friend) fun new_roster_set_sail(
        id: address,
        roster: &Roster,
        player_id: Object<Player>,
        target_coordinates: Coordinates,
        sail_duration: u64,
        set_sail_at: u64,
        updated_coordinates: Coordinates,
        energy_cost: u64,
    ): RosterSetSail {
        RosterSetSail {
            id,
            version: version(roster),
            player_id,
            target_coordinates,
            sail_duration,
            set_sail_at,
            updated_coordinates,
            energy_cost,
        }
    }

    struct RosterShipsPositionAdjusted has store, drop {
        id: address,
        version: u64,
        player_id: Object<Player>,
        positions: vector<u64>,
        ship_ids: vector<address>,
    }

    public fun roster_ships_position_adjusted_id(roster_ships_position_adjusted: &RosterShipsPositionAdjusted): address {
        roster_ships_position_adjusted.id
    }

    public fun roster_ships_position_adjusted_player_id(roster_ships_position_adjusted: &RosterShipsPositionAdjusted): Object<Player> {
        roster_ships_position_adjusted.player_id
    }

    public fun roster_ships_position_adjusted_positions(roster_ships_position_adjusted: &RosterShipsPositionAdjusted): vector<u64> {
        roster_ships_position_adjusted.positions
    }

    public fun roster_ships_position_adjusted_ship_ids(roster_ships_position_adjusted: &RosterShipsPositionAdjusted): vector<address> {
        roster_ships_position_adjusted.ship_ids
    }

    public(friend) fun new_roster_ships_position_adjusted(
        id: address,
        roster: &Roster,
        player_id: Object<Player>,
        positions: vector<u64>,
        ship_ids: vector<address>,
    ): RosterShipsPositionAdjusted {
        RosterShipsPositionAdjusted {
            id,
            version: version(roster),
            player_id,
            positions,
            ship_ids,
        }
    }

    struct RosterShipTransferred has store, drop {
        id: address,
        version: u64,
        player_id: Object<Player>,
        ship_id: address,
        to_roster: Object<Roster>,
        to_position: Option<u64>,
    }

    public fun roster_ship_transferred_id(roster_ship_transferred: &RosterShipTransferred): address {
        roster_ship_transferred.id
    }

    public fun roster_ship_transferred_player_id(roster_ship_transferred: &RosterShipTransferred): Object<Player> {
        roster_ship_transferred.player_id
    }

    public fun roster_ship_transferred_ship_id(roster_ship_transferred: &RosterShipTransferred): address {
        roster_ship_transferred.ship_id
    }

    public fun roster_ship_transferred_to_roster(roster_ship_transferred: &RosterShipTransferred): Object<Roster> {
        roster_ship_transferred.to_roster
    }

    public fun roster_ship_transferred_to_position(roster_ship_transferred: &RosterShipTransferred): Option<u64> {
        roster_ship_transferred.to_position
    }

    public(friend) fun set_roster_ship_transferred_to_position(roster_ship_transferred: &mut RosterShipTransferred, to_position: Option<u64>) {
        roster_ship_transferred.to_position = to_position;
    }

    public(friend) fun new_roster_ship_transferred(
        id: address,
        roster: &Roster,
        player_id: Object<Player>,
        ship_id: address,
        to_roster: Object<Roster>,
        to_position: Option<u64>,
    ): RosterShipTransferred {
        RosterShipTransferred {
            id,
            version: version(roster),
            player_id,
            ship_id,
            to_roster,
            to_position,
        }
    }

    struct RosterShipInventoryTakenOut has store, drop {
        id: address,
        version: u64,
        player_id: Object<Player>,
        ship_id: address,
        item_id_quantity_pairs: ItemIdQuantityPairs,
        updated_coordinates: Coordinates,
    }

    public fun roster_ship_inventory_taken_out_id(roster_ship_inventory_taken_out: &RosterShipInventoryTakenOut): address {
        roster_ship_inventory_taken_out.id
    }

    public fun roster_ship_inventory_taken_out_player_id(roster_ship_inventory_taken_out: &RosterShipInventoryTakenOut): Object<Player> {
        roster_ship_inventory_taken_out.player_id
    }

    public fun roster_ship_inventory_taken_out_ship_id(roster_ship_inventory_taken_out: &RosterShipInventoryTakenOut): address {
        roster_ship_inventory_taken_out.ship_id
    }

    public fun roster_ship_inventory_taken_out_item_id_quantity_pairs(roster_ship_inventory_taken_out: &RosterShipInventoryTakenOut): ItemIdQuantityPairs {
        roster_ship_inventory_taken_out.item_id_quantity_pairs
    }

    public fun roster_ship_inventory_taken_out_updated_coordinates(roster_ship_inventory_taken_out: &RosterShipInventoryTakenOut): Coordinates {
        roster_ship_inventory_taken_out.updated_coordinates
    }

    public(friend) fun new_roster_ship_inventory_taken_out(
        id: address,
        roster: &Roster,
        player_id: Object<Player>,
        ship_id: address,
        item_id_quantity_pairs: ItemIdQuantityPairs,
        updated_coordinates: Coordinates,
    ): RosterShipInventoryTakenOut {
        RosterShipInventoryTakenOut {
            id,
            version: version(roster),
            player_id,
            ship_id,
            item_id_quantity_pairs,
            updated_coordinates,
        }
    }

    struct RosterShipInventoryPutIn has store, drop {
        id: address,
        version: u64,
        player_id: Object<Player>,
        ship_id: address,
        item_id_quantity_pairs: ItemIdQuantityPairs,
        updated_coordinates: Coordinates,
    }

    public fun roster_ship_inventory_put_in_id(roster_ship_inventory_put_in: &RosterShipInventoryPutIn): address {
        roster_ship_inventory_put_in.id
    }

    public fun roster_ship_inventory_put_in_player_id(roster_ship_inventory_put_in: &RosterShipInventoryPutIn): Object<Player> {
        roster_ship_inventory_put_in.player_id
    }

    public fun roster_ship_inventory_put_in_ship_id(roster_ship_inventory_put_in: &RosterShipInventoryPutIn): address {
        roster_ship_inventory_put_in.ship_id
    }

    public fun roster_ship_inventory_put_in_item_id_quantity_pairs(roster_ship_inventory_put_in: &RosterShipInventoryPutIn): ItemIdQuantityPairs {
        roster_ship_inventory_put_in.item_id_quantity_pairs
    }

    public fun roster_ship_inventory_put_in_updated_coordinates(roster_ship_inventory_put_in: &RosterShipInventoryPutIn): Coordinates {
        roster_ship_inventory_put_in.updated_coordinates
    }

    public(friend) fun new_roster_ship_inventory_put_in(
        id: address,
        roster: &Roster,
        player_id: Object<Player>,
        ship_id: address,
        item_id_quantity_pairs: ItemIdQuantityPairs,
        updated_coordinates: Coordinates,
    ): RosterShipInventoryPutIn {
        RosterShipInventoryPutIn {
            id,
            version: version(roster),
            player_id,
            ship_id,
            item_id_quantity_pairs,
            updated_coordinates,
        }
    }


    public(friend) fun update_version_and_add(obj_addr: address, roster: Roster) acquires ObjectController {
        roster.version = roster.version + 1;
        let extend_ref = &borrow_global<ObjectController>(obj_addr).extend_ref;
        let object_signer = object::generate_signer_for_extending(extend_ref);
        private_add_roster(&object_signer, roster)
    }

    public(friend) fun add_roster(object_signer: &signer, roster: Roster) {
        assert!(roster.version == 0, EInappropriateVersion);
        private_add_roster(object_signer, roster);
    }

    public(friend) fun remove_roster(obj_addr: address): Roster acquires Roster {
        move_from<Roster>(obj_addr)
    }

    fun private_add_roster(object_signer: &signer, roster: Roster) {
        move_to(object_signer, roster);
    }

    public fun get_roster(obj_addr: address): pass_object::PassObject<Roster> acquires Roster {
        let roster = remove_roster(obj_addr);
        pass_object::new_with_address(roster, obj_addr)
    }

    public fun return_roster(roster_pass_obj: pass_object::PassObject<Roster>) acquires ObjectController {
        let (roster, obj_addr) = pass_object::extract_value_and_address(roster_pass_obj);
        let extend_ref = &borrow_global<ObjectController>(obj_addr).extend_ref;
        let object_signer = object::generate_signer_for_extending(extend_ref);
        private_add_roster(&object_signer, roster);
    }

    public(friend) fun borrow_mut(roster_pass_obj: &mut pass_object::PassObject<Roster>): &mut Roster {
        pass_object::borrow_mut(roster_pass_obj)
    }

    public(friend) fun drop_roster(roster: Roster) {
        let Roster {
            version: _version,
            roster_id: _roster_id,
            status: _status,
            speed: _speed,
            ship_ids: _ship_ids,
            updated_coordinates: _updated_coordinates,
            coordinates_updated_at: _coordinates_updated_at,
            target_coordinates: _target_coordinates,
            origin_coordinates: _origin_coordinates,
            sail_duration: _sail_duration,
            ship_battle_id: _ship_battle_id,
            environment_owned: _environment_owned,
            base_experience: _base_experience,
        } = roster;
    }

    public(friend) fun emit_roster_created(roster_created: RosterCreated) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.roster_created_handle, roster_created);
    }

    public(friend) fun emit_environment_roster_created(environment_roster_created: EnvironmentRosterCreated) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.environment_roster_created_handle, environment_roster_created);
    }

    public(friend) fun emit_roster_ship_added(roster_ship_added: RosterShipAdded) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.roster_ship_added_handle, roster_ship_added);
    }

    public(friend) fun emit_roster_set_sail(roster_set_sail: RosterSetSail) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.roster_set_sail_handle, roster_set_sail);
    }

    public(friend) fun emit_roster_ships_position_adjusted(roster_ships_position_adjusted: RosterShipsPositionAdjusted) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.roster_ships_position_adjusted_handle, roster_ships_position_adjusted);
    }

    public(friend) fun emit_roster_ship_transferred(roster_ship_transferred: RosterShipTransferred) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.roster_ship_transferred_handle, roster_ship_transferred);
    }

    public(friend) fun emit_roster_ship_inventory_taken_out(roster_ship_inventory_taken_out: RosterShipInventoryTakenOut) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.roster_ship_inventory_taken_out_handle, roster_ship_inventory_taken_out);
    }

    public(friend) fun emit_roster_ship_inventory_put_in(roster_ship_inventory_put_in: RosterShipInventoryPutIn) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.roster_ship_inventory_put_in_handle, roster_ship_inventory_put_in);
    }

}
