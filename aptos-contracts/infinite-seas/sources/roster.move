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
    use infinite_seas::ship::Ship;
    use infinite_seas_common::coordinates::Coordinates;
    use infinite_seas_common::roster_id::RosterId;
    use std::option::{Self, Option};
    friend infinite_seas::roster_create_logic;
    friend infinite_seas::roster_create_environment_roster_logic;
    friend infinite_seas::roster_add_ship_logic;
    friend infinite_seas::roster_aggregate;

    const EDataTooLong: u64 = 102;
    const EInappropriateVersion: u64 = 103;
    const ENotInitialized: u64 = 110;

    struct Events has key {
        roster_created_handle: event::EventHandle<RosterCreated>,
        environment_roster_created_handle: event::EventHandle<EnvironmentRosterCreated>,
        roster_ship_added_handle: event::EventHandle<RosterShipAdded>,
    }

    public fun initialize(account: &signer) {
        genesis_account::assert_genesis_account(account);

        let res_account = genesis_account::resource_account_signer();
        move_to(&res_account, Events {
            roster_created_handle: account::new_event_handle<RosterCreated>(&res_account),
            environment_roster_created_handle: account::new_event_handle<EnvironmentRosterCreated>(&res_account),
            roster_ship_added_handle: account::new_event_handle<RosterShipAdded>(&res_account),
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
        transfer_ref: object::TransferRef,
    }


    public(friend) fun save_object_controller(
        object_signer: &signer,
        extend_ref: object::ExtendRef,
        transfer_ref: object::TransferRef,
    ) {
        move_to(
            object_signer,
            ObjectController {
                extend_ref,
                transfer_ref
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

}
