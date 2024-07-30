// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas::skill_process {
    use aptos_framework::account;
    use aptos_framework::event;
    use aptos_framework::object::{Self, Object};
    use infinite_seas::genesis_account;
    use infinite_seas::pass_object;
    use infinite_seas::player::Player;
    use infinite_seas::roster::Roster;
    use infinite_seas_common::item_id_quantity_pairs::ItemIdQuantityPairs;
    use infinite_seas_common::skill_process_id::SkillProcessId;
    use std::option::{Self, Option};
    friend infinite_seas::skill_process_create_logic;
    friend infinite_seas::skill_process_start_production_logic;
    friend infinite_seas::skill_process_complete_production_logic;
    friend infinite_seas::skill_process_start_ship_production_logic;
    friend infinite_seas::skill_process_complete_ship_production_logic;
    friend infinite_seas::skill_process_aggregate;

    const EDataTooLong: u64 = 102;
    const EInappropriateVersion: u64 = 103;
    const ENotInitialized: u64 = 110;

    struct Events has key {
        skill_process_created_handle: event::EventHandle<SkillProcessCreated>,
        production_process_started_handle: event::EventHandle<ProductionProcessStarted>,
        production_process_completed_handle: event::EventHandle<ProductionProcessCompleted>,
        ship_production_process_started_handle: event::EventHandle<ShipProductionProcessStarted>,
        ship_production_process_completed_handle: event::EventHandle<ShipProductionProcessCompleted>,
    }

    public fun initialize(account: &signer) {
        genesis_account::assert_genesis_account(account);

        let res_account = genesis_account::resource_account_signer();
        move_to(&res_account, Events {
            skill_process_created_handle: account::new_event_handle<SkillProcessCreated>(&res_account),
            production_process_started_handle: account::new_event_handle<ProductionProcessStarted>(&res_account),
            production_process_completed_handle: account::new_event_handle<ProductionProcessCompleted>(&res_account),
            ship_production_process_started_handle: account::new_event_handle<ShipProductionProcessStarted>(&res_account),
            ship_production_process_completed_handle: account::new_event_handle<ShipProductionProcessCompleted>(&res_account),
        });

    }

    #[resource_group_member(group = aptos_framework::object::ObjectGroup)]
    struct SkillProcess has key {
        version: u64,
        skill_process_id: SkillProcessId,
        item_id: u32,
        started_at: u64,
        creation_time: u64,
        completed: bool,
        ended_at: u64,
        production_materials: Option<ItemIdQuantityPairs>,
        batch_size: u32,
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

    public fun version(skill_process: &SkillProcess): u64 {
        skill_process.version
    }

    public fun skill_process_id(skill_process: &SkillProcess): SkillProcessId {
        skill_process.skill_process_id
    }

    public(friend) fun set_skill_process_id(skill_process: &mut SkillProcess, skill_process_id: SkillProcessId) {
        skill_process.skill_process_id = skill_process_id;
    }

    public fun item_id(skill_process: &SkillProcess): u32 {
        skill_process.item_id
    }

    public(friend) fun set_item_id(skill_process: &mut SkillProcess, item_id: u32) {
        skill_process.item_id = item_id;
    }

    public fun started_at(skill_process: &SkillProcess): u64 {
        skill_process.started_at
    }

    public(friend) fun set_started_at(skill_process: &mut SkillProcess, started_at: u64) {
        skill_process.started_at = started_at;
    }

    public fun creation_time(skill_process: &SkillProcess): u64 {
        skill_process.creation_time
    }

    public(friend) fun set_creation_time(skill_process: &mut SkillProcess, creation_time: u64) {
        skill_process.creation_time = creation_time;
    }

    public fun completed(skill_process: &SkillProcess): bool {
        skill_process.completed
    }

    public(friend) fun set_completed(skill_process: &mut SkillProcess, completed: bool) {
        skill_process.completed = completed;
    }

    public fun ended_at(skill_process: &SkillProcess): u64 {
        skill_process.ended_at
    }

    public(friend) fun set_ended_at(skill_process: &mut SkillProcess, ended_at: u64) {
        skill_process.ended_at = ended_at;
    }

    public fun production_materials(skill_process: &SkillProcess): Option<ItemIdQuantityPairs> {
        skill_process.production_materials
    }

    public(friend) fun set_production_materials(skill_process: &mut SkillProcess, production_materials: Option<ItemIdQuantityPairs>) {
        skill_process.production_materials = production_materials;
    }

    public fun batch_size(skill_process: &SkillProcess): u32 {
        skill_process.batch_size
    }

    public(friend) fun set_batch_size(skill_process: &mut SkillProcess, batch_size: u32) {
        skill_process.batch_size = batch_size;
    }

    public(friend) fun new_skill_process(
        skill_process_id: SkillProcessId,
    ): SkillProcess {
        SkillProcess {
            version: 0,
            skill_process_id,
            item_id: infinite_seas_common::item_id::unused_item(),
            started_at: 0,
            creation_time: 0,
            completed: true,
            ended_at: 0,
            production_materials: std::option::none(),
            batch_size: 1,
        }
    }

    struct SkillProcessCreated has store, drop {
        id: option::Option<address>,
        skill_process_id: SkillProcessId,
    }

    public fun skill_process_created_id(skill_process_created: &SkillProcessCreated): option::Option<address> {
        skill_process_created.id
    }

    public(friend) fun set_skill_process_created_id(skill_process_created: &mut SkillProcessCreated, id: address) {
        skill_process_created.id = option::some(id);
    }

    public fun skill_process_created_skill_process_id(skill_process_created: &SkillProcessCreated): SkillProcessId {
        skill_process_created.skill_process_id
    }

    public(friend) fun new_skill_process_created(
        skill_process_id: SkillProcessId,
    ): SkillProcessCreated {
        SkillProcessCreated {
            id: option::none(),
            skill_process_id,
        }
    }

    struct ProductionProcessStarted has store, drop {
        id: address,
        version: u64,
        batch_size: u32,
        player_id: Object<Player>,
        item_id: u32,
        energy_cost: u64,
        started_at: u64,
        creation_time: u64,
        production_materials: ItemIdQuantityPairs,
    }

    public fun production_process_started_id(production_process_started: &ProductionProcessStarted): address {
        production_process_started.id
    }

    public fun production_process_started_batch_size(production_process_started: &ProductionProcessStarted): u32 {
        production_process_started.batch_size
    }

    public fun production_process_started_player_id(production_process_started: &ProductionProcessStarted): Object<Player> {
        production_process_started.player_id
    }

    public fun production_process_started_item_id(production_process_started: &ProductionProcessStarted): u32 {
        production_process_started.item_id
    }

    public fun production_process_started_energy_cost(production_process_started: &ProductionProcessStarted): u64 {
        production_process_started.energy_cost
    }

    public fun production_process_started_started_at(production_process_started: &ProductionProcessStarted): u64 {
        production_process_started.started_at
    }

    public fun production_process_started_creation_time(production_process_started: &ProductionProcessStarted): u64 {
        production_process_started.creation_time
    }

    public fun production_process_started_production_materials(production_process_started: &ProductionProcessStarted): ItemIdQuantityPairs {
        production_process_started.production_materials
    }

    public(friend) fun new_production_process_started(
        id: address,
        skill_process: &SkillProcess,
        batch_size: u32,
        player_id: Object<Player>,
        item_id: u32,
        energy_cost: u64,
        started_at: u64,
        creation_time: u64,
        production_materials: ItemIdQuantityPairs,
    ): ProductionProcessStarted {
        ProductionProcessStarted {
            id,
            version: version(skill_process),
            batch_size,
            player_id,
            item_id,
            energy_cost,
            started_at,
            creation_time,
            production_materials,
        }
    }

    struct ProductionProcessCompleted has store, drop {
        id: address,
        version: u64,
        player_id: Object<Player>,
        item_id: u32,
        started_at: u64,
        creation_time: u64,
        ended_at: u64,
        successful: bool,
        quantity: u32,
        experience: u32,
        new_level: u16,
    }

    public fun production_process_completed_id(production_process_completed: &ProductionProcessCompleted): address {
        production_process_completed.id
    }

    public fun production_process_completed_player_id(production_process_completed: &ProductionProcessCompleted): Object<Player> {
        production_process_completed.player_id
    }

    public fun production_process_completed_item_id(production_process_completed: &ProductionProcessCompleted): u32 {
        production_process_completed.item_id
    }

    public fun production_process_completed_started_at(production_process_completed: &ProductionProcessCompleted): u64 {
        production_process_completed.started_at
    }

    public fun production_process_completed_creation_time(production_process_completed: &ProductionProcessCompleted): u64 {
        production_process_completed.creation_time
    }

    public fun production_process_completed_ended_at(production_process_completed: &ProductionProcessCompleted): u64 {
        production_process_completed.ended_at
    }

    public fun production_process_completed_successful(production_process_completed: &ProductionProcessCompleted): bool {
        production_process_completed.successful
    }

    public fun production_process_completed_quantity(production_process_completed: &ProductionProcessCompleted): u32 {
        production_process_completed.quantity
    }

    public fun production_process_completed_experience(production_process_completed: &ProductionProcessCompleted): u32 {
        production_process_completed.experience
    }

    public fun production_process_completed_new_level(production_process_completed: &ProductionProcessCompleted): u16 {
        production_process_completed.new_level
    }

    public(friend) fun new_production_process_completed(
        id: address,
        skill_process: &SkillProcess,
        player_id: Object<Player>,
        item_id: u32,
        started_at: u64,
        creation_time: u64,
        ended_at: u64,
        successful: bool,
        quantity: u32,
        experience: u32,
        new_level: u16,
    ): ProductionProcessCompleted {
        ProductionProcessCompleted {
            id,
            version: version(skill_process),
            player_id,
            item_id,
            started_at,
            creation_time,
            ended_at,
            successful,
            quantity,
            experience,
            new_level,
        }
    }

    struct ShipProductionProcessStarted has store, drop {
        id: address,
        version: u64,
        player_id: Object<Player>,
        item_id: u32,
        energy_cost: u64,
        started_at: u64,
        creation_time: u64,
        production_materials: ItemIdQuantityPairs,
    }

    public fun ship_production_process_started_id(ship_production_process_started: &ShipProductionProcessStarted): address {
        ship_production_process_started.id
    }

    public fun ship_production_process_started_player_id(ship_production_process_started: &ShipProductionProcessStarted): Object<Player> {
        ship_production_process_started.player_id
    }

    public fun ship_production_process_started_item_id(ship_production_process_started: &ShipProductionProcessStarted): u32 {
        ship_production_process_started.item_id
    }

    public fun ship_production_process_started_energy_cost(ship_production_process_started: &ShipProductionProcessStarted): u64 {
        ship_production_process_started.energy_cost
    }

    public fun ship_production_process_started_started_at(ship_production_process_started: &ShipProductionProcessStarted): u64 {
        ship_production_process_started.started_at
    }

    public fun ship_production_process_started_creation_time(ship_production_process_started: &ShipProductionProcessStarted): u64 {
        ship_production_process_started.creation_time
    }

    public fun ship_production_process_started_production_materials(ship_production_process_started: &ShipProductionProcessStarted): ItemIdQuantityPairs {
        ship_production_process_started.production_materials
    }

    public(friend) fun new_ship_production_process_started(
        id: address,
        skill_process: &SkillProcess,
        player_id: Object<Player>,
        item_id: u32,
        energy_cost: u64,
        started_at: u64,
        creation_time: u64,
        production_materials: ItemIdQuantityPairs,
    ): ShipProductionProcessStarted {
        ShipProductionProcessStarted {
            id,
            version: version(skill_process),
            player_id,
            item_id,
            energy_cost,
            started_at,
            creation_time,
            production_materials,
        }
    }

    struct ShipProductionProcessCompleted has store, drop {
        id: address,
        version: u64,
        roster_object_address: Object<Roster>,
        player_id: Object<Player>,
        item_id: u32,
        started_at: u64,
        creation_time: u64,
        ended_at: u64,
        successful: bool,
        quantity: u32,
        experience: u32,
        new_level: u16,
    }

    public fun ship_production_process_completed_id(ship_production_process_completed: &ShipProductionProcessCompleted): address {
        ship_production_process_completed.id
    }

    public fun ship_production_process_completed_roster_object_address(ship_production_process_completed: &ShipProductionProcessCompleted): Object<Roster> {
        ship_production_process_completed.roster_object_address
    }

    public fun ship_production_process_completed_player_id(ship_production_process_completed: &ShipProductionProcessCompleted): Object<Player> {
        ship_production_process_completed.player_id
    }

    public fun ship_production_process_completed_item_id(ship_production_process_completed: &ShipProductionProcessCompleted): u32 {
        ship_production_process_completed.item_id
    }

    public fun ship_production_process_completed_started_at(ship_production_process_completed: &ShipProductionProcessCompleted): u64 {
        ship_production_process_completed.started_at
    }

    public fun ship_production_process_completed_creation_time(ship_production_process_completed: &ShipProductionProcessCompleted): u64 {
        ship_production_process_completed.creation_time
    }

    public fun ship_production_process_completed_ended_at(ship_production_process_completed: &ShipProductionProcessCompleted): u64 {
        ship_production_process_completed.ended_at
    }

    public fun ship_production_process_completed_successful(ship_production_process_completed: &ShipProductionProcessCompleted): bool {
        ship_production_process_completed.successful
    }

    public fun ship_production_process_completed_quantity(ship_production_process_completed: &ShipProductionProcessCompleted): u32 {
        ship_production_process_completed.quantity
    }

    public fun ship_production_process_completed_experience(ship_production_process_completed: &ShipProductionProcessCompleted): u32 {
        ship_production_process_completed.experience
    }

    public fun ship_production_process_completed_new_level(ship_production_process_completed: &ShipProductionProcessCompleted): u16 {
        ship_production_process_completed.new_level
    }

    public(friend) fun new_ship_production_process_completed(
        id: address,
        skill_process: &SkillProcess,
        roster_object_address: Object<Roster>,
        player_id: Object<Player>,
        item_id: u32,
        started_at: u64,
        creation_time: u64,
        ended_at: u64,
        successful: bool,
        quantity: u32,
        experience: u32,
        new_level: u16,
    ): ShipProductionProcessCompleted {
        ShipProductionProcessCompleted {
            id,
            version: version(skill_process),
            roster_object_address,
            player_id,
            item_id,
            started_at,
            creation_time,
            ended_at,
            successful,
            quantity,
            experience,
            new_level,
        }
    }


    public(friend) fun update_version_and_add(obj_addr: address, skill_process: SkillProcess) acquires ObjectController {
        skill_process.version = skill_process.version + 1;
        let extend_ref = &borrow_global<ObjectController>(obj_addr).extend_ref;
        let object_signer = object::generate_signer_for_extending(extend_ref);
        private_add_skill_process(&object_signer, skill_process)
    }

    public(friend) fun add_skill_process(object_signer: &signer, skill_process: SkillProcess) {
        assert!(skill_process.version == 0, EInappropriateVersion);
        private_add_skill_process(object_signer, skill_process);
    }

    public(friend) fun remove_skill_process(obj_addr: address): SkillProcess acquires SkillProcess {
        move_from<SkillProcess>(obj_addr)
    }

    fun private_add_skill_process(object_signer: &signer, skill_process: SkillProcess) {
        move_to(object_signer, skill_process);
    }

    public(friend) fun transfer_skill_process(obj_addr: address, to: address) acquires ObjectController {
        let transfer_ref = &borrow_global<ObjectController>(obj_addr).transfer_ref;
        let linear_transfer_ref = object::generate_linear_transfer_ref(transfer_ref);
        object::transfer_with_ref(linear_transfer_ref, to)
    }

    public fun get_skill_process(obj_addr: address): pass_object::PassObject<SkillProcess> acquires SkillProcess {
        let skill_process = remove_skill_process(obj_addr);
        pass_object::new_with_address(skill_process, obj_addr)
    }

    public fun return_skill_process(skill_process_pass_obj: pass_object::PassObject<SkillProcess>) acquires ObjectController {
        let (skill_process, obj_addr) = pass_object::extract_value_and_address(skill_process_pass_obj);
        let extend_ref = &borrow_global<ObjectController>(obj_addr).extend_ref;
        let object_signer = object::generate_signer_for_extending(extend_ref);
        private_add_skill_process(&object_signer, skill_process);
    }

    public(friend) fun borrow_mut(skill_process_pass_obj: &mut pass_object::PassObject<SkillProcess>): &mut SkillProcess {
        pass_object::borrow_mut(skill_process_pass_obj)
    }

    public(friend) fun drop_skill_process(skill_process: SkillProcess) {
        let SkillProcess {
            version: _version,
            skill_process_id: _skill_process_id,
            item_id: _item_id,
            started_at: _started_at,
            creation_time: _creation_time,
            completed: _completed,
            ended_at: _ended_at,
            production_materials: _production_materials,
            batch_size: _batch_size,
        } = skill_process;
    }

    public(friend) fun emit_skill_process_created(skill_process_created: SkillProcessCreated) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.skill_process_created_handle, skill_process_created);
    }

    public(friend) fun emit_production_process_started(production_process_started: ProductionProcessStarted) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.production_process_started_handle, production_process_started);
    }

    public(friend) fun emit_production_process_completed(production_process_completed: ProductionProcessCompleted) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.production_process_completed_handle, production_process_completed);
    }

    public(friend) fun emit_ship_production_process_started(ship_production_process_started: ShipProductionProcessStarted) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.ship_production_process_started_handle, ship_production_process_started);
    }

    public(friend) fun emit_ship_production_process_completed(ship_production_process_completed: ShipProductionProcessCompleted) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.ship_production_process_completed_handle, ship_production_process_completed);
    }

}
