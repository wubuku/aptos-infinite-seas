module infinite_seas_common::item_creation_update_logic {
    use infinite_seas_common::item_creation;

    friend infinite_seas_common::item_creation_aggregate;

    public(friend) fun verify(
        account: &signer,
        store_address: address,
        resource_cost: u32,
        requirements_level: u16,
        base_quantity: u32,
        base_experience: u32,
        base_creation_time: u64,
        energy_cost: u64,
        success_rate: u16,
        item_creation: &item_creation::ItemCreation,
    ): item_creation::ItemCreationUpdated {
        let _ = account;
        item_creation::new_item_creation_updated(
            item_creation,
            resource_cost,
            requirements_level,
            base_quantity,
            base_experience,
            base_creation_time,
            energy_cost,
            success_rate,
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        _store_address: address,
        item_creation_updated: &item_creation::ItemCreationUpdated,
        item_creation: item_creation::ItemCreation,
    ): item_creation::ItemCreation {
        let resource_cost = item_creation::item_creation_updated_resource_cost(item_creation_updated);
        let requirements_level = item_creation::item_creation_updated_requirements_level(item_creation_updated);
        let base_quantity = item_creation::item_creation_updated_base_quantity(item_creation_updated);
        let base_experience = item_creation::item_creation_updated_base_experience(item_creation_updated);
        let base_creation_time = item_creation::item_creation_updated_base_creation_time(item_creation_updated);
        let energy_cost = item_creation::item_creation_updated_energy_cost(item_creation_updated);
        let success_rate = item_creation::item_creation_updated_success_rate(item_creation_updated);
        let item_creation_id = item_creation::item_creation_id(&item_creation);
        let _ = item_creation_id;
        item_creation::set_resource_cost(&mut item_creation, resource_cost);
        item_creation::set_requirements_level(&mut item_creation, requirements_level);
        item_creation::set_base_quantity(&mut item_creation, base_quantity);
        item_creation::set_base_experience(&mut item_creation, base_experience);
        item_creation::set_base_creation_time(&mut item_creation, base_creation_time);
        item_creation::set_energy_cost(&mut item_creation, energy_cost);
        item_creation::set_success_rate(&mut item_creation, success_rate);
        item_creation
    }

}
