module infinite_seas_common::item_update_logic {
    use infinite_seas_common::item;
    use std::string::String;

    friend infinite_seas_common::item_aggregate;

    public(friend) fun verify(
        account: &signer,
        store_address: address,
        name: String,
        required_for_completion: bool,
        sells_for: u32,
        item: &item::Item,
    ): item::ItemUpdated {
        let _ = account;
        item::new_item_updated(
            item,
            name,
            required_for_completion,
            sells_for,
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        _store_address: address,
        item_updated: &item::ItemUpdated,
        item: item::Item,
    ): item::Item {
        let name = item::item_updated_name(item_updated);
        let required_for_completion = item::item_updated_required_for_completion(item_updated);
        let sells_for = item::item_updated_sells_for(item_updated);
        let item_id = item::item_id(&item);
        let _ = item_id;
        item::set_name(&mut item, name);
        item::set_required_for_completion(&mut item, required_for_completion);
        item::set_sells_for(&mut item, sells_for);
        item
    }

}
