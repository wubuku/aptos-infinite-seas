// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas_common::item {
    use aptos_framework::account;
    use aptos_framework::event;
    use aptos_std::table::{Self, Table};
    use infinite_seas_common::infinite_seas_common_pass_object as pass_object;
    use std::string::String;
    friend infinite_seas_common::item_create_logic;
    friend infinite_seas_common::item_update_logic;
    friend infinite_seas_common::item_aggregate;

    const EIdAlreadyExists: u64 = 101;
    const EDataTooLong: u64 = 102;
    const EInappropriateVersion: u64 = 103;
    const ENotInitialized: u64 = 110;

    struct Events has key {
        item_created_handle: event::EventHandle<ItemCreated>,
        item_updated_handle: event::EventHandle<ItemUpdated>,
    }

    struct Tables has key {
        item_table: Table<u32, Item>,
    }

    public fun initialize(store_account: &signer) {
        move_to(store_account, Events {
            item_created_handle: account::new_event_handle<ItemCreated>(store_account),
            item_updated_handle: account::new_event_handle<ItemUpdated>(store_account),
        });

        move_to(
            store_account,
            Tables {
                item_table: table::new(),
            },
        );

    }

    struct Item has store {
        item_id: u32,
        version: u64,
        name: String,
        required_for_completion: bool,
        sells_for: u32,
    }

    public fun item_id(item: &Item): u32 {
        item.item_id
    }

    public fun version(item: &Item): u64 {
        item.version
    }

    public fun name(item: &Item): String {
        item.name
    }

    public(friend) fun set_name(item: &mut Item, name: String) {
        assert!(std::string::length(&name) <= 100, EDataTooLong);
        item.name = name;
    }

    public fun required_for_completion(item: &Item): bool {
        item.required_for_completion
    }

    public(friend) fun set_required_for_completion(item: &mut Item, required_for_completion: bool) {
        item.required_for_completion = required_for_completion;
    }

    public fun sells_for(item: &Item): u32 {
        item.sells_for
    }

    public(friend) fun set_sells_for(item: &mut Item, sells_for: u32) {
        item.sells_for = sells_for;
    }

    fun new_item(
        item_id: u32,
        name: String,
        required_for_completion: bool,
        sells_for: u32,
    ): Item {
        assert!(std::string::length(&name) <= 100, EDataTooLong);
        Item {
            item_id,
            version: 0,
            name,
            required_for_completion,
            sells_for,
        }
    }

    struct ItemCreated has store, drop {
        item_id: u32,
        name: String,
        required_for_completion: bool,
        sells_for: u32,
    }

    public fun item_created_item_id(item_created: &ItemCreated): u32 {
        item_created.item_id
    }

    public fun item_created_name(item_created: &ItemCreated): String {
        item_created.name
    }

    public fun item_created_required_for_completion(item_created: &ItemCreated): bool {
        item_created.required_for_completion
    }

    public fun item_created_sells_for(item_created: &ItemCreated): u32 {
        item_created.sells_for
    }

    public(friend) fun new_item_created(
        item_id: u32,
        name: String,
        required_for_completion: bool,
        sells_for: u32,
    ): ItemCreated {
        ItemCreated {
            item_id,
            name,
            required_for_completion,
            sells_for,
        }
    }

    struct ItemUpdated has store, drop {
        item_id: u32,
        version: u64,
        name: String,
        required_for_completion: bool,
        sells_for: u32,
    }

    public fun item_updated_item_id(item_updated: &ItemUpdated): u32 {
        item_updated.item_id
    }

    public fun item_updated_name(item_updated: &ItemUpdated): String {
        item_updated.name
    }

    public fun item_updated_required_for_completion(item_updated: &ItemUpdated): bool {
        item_updated.required_for_completion
    }

    public fun item_updated_sells_for(item_updated: &ItemUpdated): u32 {
        item_updated.sells_for
    }

    public(friend) fun new_item_updated(
        item: &Item,
        name: String,
        required_for_completion: bool,
        sells_for: u32,
    ): ItemUpdated {
        ItemUpdated {
            item_id: item_id(item),
            version: version(item),
            name,
            required_for_completion,
            sells_for,
        }
    }


    public(friend) fun create_item(
        store_address: address,
        item_id: u32,
        name: String,
        required_for_completion: bool,
        sells_for: u32,
    ): Item acquires Tables {
        asset_item_not_exists(store_address, item_id);
        let item = new_item(
            item_id,
            name,
            required_for_completion,
            sells_for,
        );
        item
    }

    public(friend) fun asset_item_not_exists(
        store_address: address, item_id: u32,
    ) acquires Tables {
        assert!(exists<Tables>(store_address), ENotInitialized);
        let tables = borrow_global_mut<Tables>(store_address);
        assert!(!table::contains(&tables.item_table, item_id), EIdAlreadyExists);
    }

    public(friend) fun update_version_and_add(store_address: address, item: Item) acquires Tables {
        item.version = item.version + 1;
        //assert!(item.version != 0, EInappropriateVersion);
        private_add_item(store_address, item);
    }

    public(friend) fun add_item(store_address: address, item: Item) acquires Tables {
        assert!(item.version == 0, EInappropriateVersion);
        private_add_item(store_address, item);
    }

    public(friend) fun remove_item(store_address: address, item_id: u32): Item acquires Tables {
        assert!(exists<Tables>(store_address), ENotInitialized);
        let tables = borrow_global_mut<Tables>(store_address);
        table::remove(&mut tables.item_table, item_id)
    }

    fun private_add_item(store_address: address, item: Item) acquires Tables {
        assert!(exists<Tables>(store_address), ENotInitialized);
        let tables = borrow_global_mut<Tables>(store_address);
        table::add(&mut tables.item_table, item.item_id, item);
    }

    public fun get_item(store_address: address, item_id: u32): pass_object::PassObject<Item> acquires Tables {
        let item = remove_item(store_address, item_id);
        pass_object::new_with_address(item, store_address, )
    }

    public fun return_item(item_pass_obj: pass_object::PassObject<Item>) acquires Tables {
        let (item, store_address, ) = pass_object::extract_value_and_address(item_pass_obj);
        private_add_item(store_address, item);
    }

    public fun borrow(item_pass_obj: &pass_object::PassObject<Item>): &Item {
        pass_object::borrow(item_pass_obj)
    }

    public(friend) fun borrow_mut(item_pass_obj: &mut pass_object::PassObject<Item>): &mut Item {
        pass_object::borrow_mut(item_pass_obj)
    }

    public(friend) fun drop_item(item: Item) {
        let Item {
            version: _version,
            item_id: _item_id,
            name: _name,
            required_for_completion: _required_for_completion,
            sells_for: _sells_for,
        } = item;
    }

    public fun contains_item(store_address: address, item_id: u32): bool acquires Tables {
        let tables = borrow_global<Tables>(store_address);
        table::contains(&tables.item_table, item_id)
    }

    public(friend) fun emit_item_created(store_address: address, item_created: ItemCreated) acquires Events {
        assert!(exists<Events>(store_address), ENotInitialized);
        let events = borrow_global_mut<Events>(store_address);
        event::emit_event(&mut events.item_created_handle, item_created);
    }

    public(friend) fun emit_item_updated(store_address: address, item_updated: ItemUpdated) acquires Events {
        assert!(exists<Events>(store_address), ENotInitialized);
        let events = borrow_global_mut<Events>(store_address);
        event::emit_event(&mut events.item_updated_handle, item_updated);
    }

}
