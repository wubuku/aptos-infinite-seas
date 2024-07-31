// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas::ship {
    use aptos_framework::account;
    use aptos_framework::event;
    use aptos_framework::object;
    use infinite_seas::genesis_account;
    use infinite_seas::pass_object;
    use infinite_seas_common::item_id_quantity_pair::ItemIdQuantityPair;
    use infinite_seas_common::item_id_quantity_pairs::ItemIdQuantityPairs;
    use std::option;
    friend infinite_seas::ship_create_logic;
    friend infinite_seas::ship_aggregate;

    friend infinite_seas::ship_battle_make_move_logic;
    friend infinite_seas::ship_battle_take_loot_logic;
    friend infinite_seas::roster_add_ship_logic;
    friend infinite_seas::roster_create_environment_roster_logic;
    friend infinite_seas::roster_transfer_ship_logic;
    friend infinite_seas::roster_put_in_ship_inventory_logic;
    friend infinite_seas::roster_take_out_ship_inventory_logic;
    friend infinite_seas::roster_transfer_ship_inventory_logic;

    const EDataTooLong: u64 = 102;
    const EInappropriateVersion: u64 = 103;
    const ENotInitialized: u64 = 110;

    struct Events has key {
        ship_created_handle: event::EventHandle<ShipCreated>,
    }

    public fun initialize(account: &signer) {
        genesis_account::assert_genesis_account(account);

        let res_account = genesis_account::resource_account_signer();
        move_to(&res_account, Events {
            ship_created_handle: account::new_event_handle<ShipCreated>(&res_account),
        });

    }

    #[resource_group_member(group = aptos_framework::object::ObjectGroup)]
    struct Ship has key {
        version: u64,
        owner: address,
        health_points: u32,
        attack: u32,
        protection: u32,
        speed: u32,
        building_expenses: ItemIdQuantityPairs,
        inventory: vector<ItemIdQuantityPair>,
    }

    #[resource_group_member(group = aptos_framework::object::ObjectGroup)]
    struct ObjectController has key {
        extend_ref: object::ExtendRef,
        delete_ref: object::DeleteRef,
        transfer_ref: object::TransferRef,
    }


    public(friend) fun save_object_controller(
        object_signer: &signer,
        extend_ref: object::ExtendRef,
        delete_ref: object::DeleteRef,
        transfer_ref: object::TransferRef,
    ) {
        move_to(
            object_signer,
            ObjectController {
                extend_ref,
                delete_ref,
                transfer_ref
            }
        )
    }

    public fun version(ship: &Ship): u64 {
        ship.version
    }

    public fun owner(ship: &Ship): address {
        ship.owner
    }

    public(friend) fun set_owner(ship: &mut Ship, owner: address) {
        ship.owner = owner;
    }

    public fun health_points(ship: &Ship): u32 {
        ship.health_points
    }

    public(friend) fun set_health_points(ship: &mut Ship, health_points: u32) {
        ship.health_points = health_points;
    }

    public fun attack(ship: &Ship): u32 {
        ship.attack
    }

    public(friend) fun set_attack(ship: &mut Ship, attack: u32) {
        ship.attack = attack;
    }

    public fun protection(ship: &Ship): u32 {
        ship.protection
    }

    public(friend) fun set_protection(ship: &mut Ship, protection: u32) {
        ship.protection = protection;
    }

    public fun speed(ship: &Ship): u32 {
        ship.speed
    }

    public(friend) fun set_speed(ship: &mut Ship, speed: u32) {
        ship.speed = speed;
    }

    public fun building_expenses(ship: &Ship): ItemIdQuantityPairs {
        ship.building_expenses
    }

    public(friend) fun set_building_expenses(ship: &mut Ship, building_expenses: ItemIdQuantityPairs) {
        ship.building_expenses = building_expenses;
    }

    public fun borrow_inventory(ship: &Ship): &vector<ItemIdQuantityPair> {
        &ship.inventory
    }

    public(friend) fun borrow_mut_inventory(ship: &mut Ship): &mut vector<ItemIdQuantityPair> {
        &mut ship.inventory
    }

    public fun inventory(ship: &Ship): vector<ItemIdQuantityPair> {
        ship.inventory
    }

    public(friend) fun set_inventory(ship: &mut Ship, inventory: vector<ItemIdQuantityPair>) {
        ship.inventory = inventory;
    }

    public(friend) fun new_ship(
        owner: address,
        health_points: u32,
        attack: u32,
        protection: u32,
        speed: u32,
        building_expenses: ItemIdQuantityPairs,
    ): Ship {
        Ship {
            version: 0,
            owner,
            health_points,
            attack,
            protection,
            speed,
            building_expenses,
            inventory: std::vector::empty(),
        }
    }

    struct ShipCreated has store, drop {
        id: option::Option<address>,
        owner: address,
        health_points: u32,
        attack: u32,
        protection: u32,
        speed: u32,
        building_expenses: ItemIdQuantityPairs,
    }

    public fun ship_created_id(ship_created: &ShipCreated): option::Option<address> {
        ship_created.id
    }

    public(friend) fun set_ship_created_id(ship_created: &mut ShipCreated, id: address) {
        ship_created.id = option::some(id);
    }

    public fun ship_created_owner(ship_created: &ShipCreated): address {
        ship_created.owner
    }

    public fun ship_created_health_points(ship_created: &ShipCreated): u32 {
        ship_created.health_points
    }

    public fun ship_created_attack(ship_created: &ShipCreated): u32 {
        ship_created.attack
    }

    public fun ship_created_protection(ship_created: &ShipCreated): u32 {
        ship_created.protection
    }

    public fun ship_created_speed(ship_created: &ShipCreated): u32 {
        ship_created.speed
    }

    public fun ship_created_building_expenses(ship_created: &ShipCreated): ItemIdQuantityPairs {
        ship_created.building_expenses
    }

    public(friend) fun new_ship_created(
        owner: address,
        health_points: u32,
        attack: u32,
        protection: u32,
        speed: u32,
        building_expenses: ItemIdQuantityPairs,
    ): ShipCreated {
        ShipCreated {
            id: option::none(),
            owner,
            health_points,
            attack,
            protection,
            speed,
            building_expenses,
        }
    }


    public(friend) fun update_version_and_add(obj_addr: address, ship: Ship) acquires ObjectController {
        ship.version = ship.version + 1;
        let extend_ref = &borrow_global<ObjectController>(obj_addr).extend_ref;
        let object_signer = object::generate_signer_for_extending(extend_ref);
        private_add_ship(&object_signer, ship)
    }

    public(friend) fun add_ship(object_signer: &signer, ship: Ship) {
        assert!(ship.version == 0, EInappropriateVersion);
        private_add_ship(object_signer, ship);
    }

    public(friend) fun remove_ship(obj_addr: address): Ship acquires Ship {
        move_from<Ship>(obj_addr)
    }

    fun private_add_ship(object_signer: &signer, ship: Ship) {
        move_to(object_signer, ship);
    }

    public(friend) fun delete_ship(obj_addr: address) acquires ObjectController {
        let ObjectController {
            extend_ref: _extend_ref,
            delete_ref,
            transfer_ref: _transfer_ref,
        } = move_from<ObjectController>(
            obj_addr
        );
        object::delete(delete_ref)
    }

    public(friend) fun transfer_ship(obj_addr: address, to: address) acquires ObjectController {
        let transfer_ref = &borrow_global<ObjectController>(obj_addr).transfer_ref;
        let linear_transfer_ref = object::generate_linear_transfer_ref(transfer_ref);
        object::transfer_with_ref(linear_transfer_ref, to)
    }

    public fun get_ship(obj_addr: address): pass_object::PassObject<Ship> acquires Ship {
        let ship = remove_ship(obj_addr);
        pass_object::new_with_address(ship, obj_addr)
    }

    public fun return_ship(ship_pass_obj: pass_object::PassObject<Ship>) acquires ObjectController {
        let (ship, obj_addr) = pass_object::extract_value_and_address(ship_pass_obj);
        let extend_ref = &borrow_global<ObjectController>(obj_addr).extend_ref;
        let object_signer = object::generate_signer_for_extending(extend_ref);
        private_add_ship(&object_signer, ship);
    }

    public(friend) fun borrow_mut(ship_pass_obj: &mut pass_object::PassObject<Ship>): &mut Ship {
        pass_object::borrow_mut(ship_pass_obj)
    }

    public(friend) fun drop_ship(ship: Ship) {
        let Ship {
            version: _version,
            owner: _owner,
            health_points: _health_points,
            attack: _attack,
            protection: _protection,
            speed: _speed,
            building_expenses: _building_expenses,
            inventory: _inventory,
        } = ship;
    }

    public(friend) fun emit_ship_created(ship_created: ShipCreated) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.ship_created_handle, ship_created);
    }

}
