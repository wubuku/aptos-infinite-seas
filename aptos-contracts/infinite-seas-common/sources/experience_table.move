// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas_common::experience_table {
    use aptos_framework::account;
    use aptos_framework::event;
    use infinite_seas_common::experience_level::ExperienceLevel;
    use infinite_seas_common::infinite_seas_common_pass_object as pass_object;
    friend infinite_seas_common::experience_table_add_level_logic;
    friend infinite_seas_common::experience_table_update_level_logic;
    friend infinite_seas_common::experience_table_aggregate;

    const EDataTooLong: u64 = 102;
    const EInappropriateVersion: u64 = 103;
    const ENotInitialized: u64 = 110;

    struct Events has key {
        experience_level_added_handle: event::EventHandle<ExperienceLevelAdded>,
        experience_level_updated_handle: event::EventHandle<ExperienceLevelUpdated>,
    }

    public fun initialize(store_account: &signer) {
        move_to(store_account, Events {
            experience_level_added_handle: account::new_event_handle<ExperienceLevelAdded>(store_account),
            experience_level_updated_handle: account::new_event_handle<ExperienceLevelUpdated>(store_account),
        });

        let experience_table = new_experience_table();
        add_experience_table(store_account, experience_table);
    }

    struct ExperienceTable has key, store {
        version: u64,
        levels: vector<ExperienceLevel>,
    }

    public fun version(experience_table: &ExperienceTable): u64 {
        experience_table.version
    }

    public fun borrow_levels(experience_table: &ExperienceTable): &vector<ExperienceLevel> {
        &experience_table.levels
    }

    public(friend) fun borrow_mut_levels(experience_table: &mut ExperienceTable): &mut vector<ExperienceLevel> {
        &mut experience_table.levels
    }

    public fun levels(experience_table: &ExperienceTable): vector<ExperienceLevel> {
        experience_table.levels
    }

    public(friend) fun set_levels(experience_table: &mut ExperienceTable, levels: vector<ExperienceLevel>) {
        experience_table.levels = levels;
    }

    public(friend) fun new_experience_table(
    ): ExperienceTable {
        ExperienceTable {
            version: 0,
            levels: std::vector::empty(),
        }
    }

    struct ExperienceTableInitialized has store, drop {
    }

    public(friend) fun new_experience_table_initialized(
        experience_table: &ExperienceTable,
    ): ExperienceTableInitialized {
        ExperienceTableInitialized {
        }
    }

    struct ExperienceLevelAdded has store, drop {
        version: u64,
        level: u16,
        experience: u32,
        difference: u32,
    }

    public fun experience_level_added_level(experience_level_added: &ExperienceLevelAdded): u16 {
        experience_level_added.level
    }

    public fun experience_level_added_experience(experience_level_added: &ExperienceLevelAdded): u32 {
        experience_level_added.experience
    }

    public fun experience_level_added_difference(experience_level_added: &ExperienceLevelAdded): u32 {
        experience_level_added.difference
    }

    public(friend) fun new_experience_level_added(
        store_address: address,
        level: u16,
        experience: u32,
        difference: u32,
    ): ExperienceLevelAdded acquires ExperienceTable {
        ExperienceLevelAdded {
            version: singleton_version(store_address, ),
            level,
            experience,
            difference,
        }
    }

    struct ExperienceLevelUpdated has store, drop {
        version: u64,
        level: u16,
        experience: u32,
        difference: u32,
    }

    public fun experience_level_updated_level(experience_level_updated: &ExperienceLevelUpdated): u16 {
        experience_level_updated.level
    }

    public fun experience_level_updated_experience(experience_level_updated: &ExperienceLevelUpdated): u32 {
        experience_level_updated.experience
    }

    public fun experience_level_updated_difference(experience_level_updated: &ExperienceLevelUpdated): u32 {
        experience_level_updated.difference
    }

    public(friend) fun new_experience_level_updated(
        store_address: address,
        level: u16,
        experience: u32,
        difference: u32,
    ): ExperienceLevelUpdated acquires ExperienceTable {
        ExperienceLevelUpdated {
            version: singleton_version(store_address, ),
            level,
            experience,
            difference,
        }
    }


    public(friend) fun update_version_and_add(store_account: &signer, experience_table: ExperienceTable) {
        experience_table.version = experience_table.version + 1;
        //assert!(experience_table.version != 0, EInappropriateVersion);
        private_add_experience_table(store_account, experience_table);
    }

    public(friend) fun add_experience_table(store_account: &signer, experience_table: ExperienceTable) {
        assert!(experience_table.version == 0, EInappropriateVersion);
        private_add_experience_table(store_account, experience_table);
    }

    public(friend) fun remove_experience_table(store_address: address, ): ExperienceTable acquires ExperienceTable {
        assert!(exists<ExperienceTable>(store_address), ENotInitialized);
        move_from<ExperienceTable>(store_address)
    }

    fun private_add_experience_table(store_account: &signer, experience_table: ExperienceTable) {
        move_to(store_account, experience_table);
    }

    public fun singleton_version(store_address: address, ): u64 acquires ExperienceTable {
        let experience_table = borrow_global<ExperienceTable>(store_address);
        experience_table.version
    }

    public fun set_singleton_version(store_address: address, version: u64) acquires ExperienceTable {
        let experience_table = borrow_global_mut<ExperienceTable>(store_address);
        experience_table.version = version;
    }

    public fun singleton_levels_length(store_address: address, ): u64 acquires ExperienceTable {
        let experience_table = borrow_global<ExperienceTable>(store_address);
        std::vector::length(&experience_table.levels)
    }

    public fun singleton_levels_get(store_address: address, i: u64): ExperienceLevel acquires ExperienceTable {
        let experience_table = borrow_global<ExperienceTable>(store_address);
        *std::vector::borrow(&experience_table.levels, i)
    }

    public(friend) fun singleton_levels_set(store_address: address, i: u64, level :ExperienceLevel) acquires ExperienceTable {
        let experience_table = borrow_global_mut<ExperienceTable>(store_address);
        std::vector::remove(&mut experience_table.levels, i);
        std::vector::insert(&mut experience_table.levels, i, level)
    }

    public(friend) fun singleton_levels_push_back(store_address: address, level :ExperienceLevel) acquires ExperienceTable {
        let experience_table = borrow_global_mut<ExperienceTable>(store_address);
        std::vector::push_back(&mut experience_table.levels, level)
    }

    public fun singleton_levels(store_address: address, ): vector<ExperienceLevel> acquires ExperienceTable {
        let experience_table = borrow_global<ExperienceTable>(store_address);
        experience_table.levels
    }

    public fun set_singleton_levels(store_address: address, levels: vector<ExperienceLevel>) acquires ExperienceTable {
        let experience_table = borrow_global_mut<ExperienceTable>(store_address);
        experience_table.levels = levels;
    }

    public(friend) fun set_all_porperties(store_address: address, levels: vector<ExperienceLevel>) acquires ExperienceTable {
        assert!(exists<ExperienceTable>(store_address), ENotInitialized);
        let experience_table = borrow_global_mut<ExperienceTable>(store_address);
        experience_table.version = experience_table.version + 1;
        experience_table.levels = levels;
    }

    public(friend) fun drop_experience_table(experience_table: ExperienceTable) {
        let ExperienceTable {
            version: _version,
            levels: _levels,
        } = experience_table;
    }

    public fun experience_table_exists(store_address: address, ): bool {
        exists<ExperienceTable>(store_address)
    }

    public(friend) fun emit_experience_level_added(store_address: address, experience_level_added: ExperienceLevelAdded) acquires Events {
        assert!(exists<Events>(store_address), ENotInitialized);
        let events = borrow_global_mut<Events>(store_address);
        event::emit_event(&mut events.experience_level_added_handle, experience_level_added);
    }

    public(friend) fun emit_experience_level_updated(store_address: address, experience_level_updated: ExperienceLevelUpdated) acquires Events {
        assert!(exists<Events>(store_address), ENotInitialized);
        let events = borrow_global_mut<Events>(store_address);
        event::emit_event(&mut events.experience_level_updated_handle, experience_level_updated);
    }

}
