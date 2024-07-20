module infinite_seas_common::item_create_logic {
    use infinite_seas_common::item;
    use std::string::String;

    friend infinite_seas_common::item_aggregate;

    public(friend) fun verify(
        account: &signer,
        store_address: address,      
        item_id: u32,
        name: String,
        required_for_completion: bool,
        sells_for: u32,
    ): item::ItemCreated {
        let _ = account;
        item::asset_item_not_exists(store_address, item_id);
        item::new_item_created(
            item_id,
            name,
            required_for_completion,
            sells_for,
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        store_address: address,
        item_created: &item::ItemCreated,
    ): item::Item {
        let item_id = item::item_created_item_id(item_created);
        let name = item::item_created_name(item_created);
        let required_for_completion = item::item_created_required_for_completion(item_created);
        let sells_for = item::item_created_sells_for(item_created);
        item::create_item(
            store_address,
            item_id,
            name,
            required_for_completion,
            sells_for,
        )
    }

}
