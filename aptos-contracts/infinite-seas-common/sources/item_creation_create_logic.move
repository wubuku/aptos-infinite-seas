module infinite_seas_common::item_creation_create_logic {
    use infinite_seas_common::item_creation;
    use infinite_seas_common::skill_type_item_id_pair::SkillTypeItemIdPair;

    friend infinite_seas_common::item_creation_aggregate;

    public(friend) fun verify(
        account: &signer,
        store_address: address,
        item_creation_id: SkillTypeItemIdPair,
        resource_cost: u32,
        requirements_level: u16,
        base_quantity: u32,
        base_experience: u32,
        base_creation_time: u64,
        energy_cost: u64,
        success_rate: u16,
    ): item_creation::ItemCreationCreated {
        let _ = account;
        item_creation::asset_item_creation_not_exists(store_address, item_creation_id);
        item_creation::new_item_creation_created(
            item_creation_id,
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
        store_address: address,
        item_creation_created: &item_creation::ItemCreationCreated,
    ): item_creation::ItemCreation {
        let item_creation_id = item_creation::item_creation_created_item_creation_id(item_creation_created);
        let resource_cost = item_creation::item_creation_created_resource_cost(item_creation_created);
        let requirements_level = item_creation::item_creation_created_requirements_level(item_creation_created);
        let base_quantity = item_creation::item_creation_created_base_quantity(item_creation_created);
        let base_experience = item_creation::item_creation_created_base_experience(item_creation_created);
        let base_creation_time = item_creation::item_creation_created_base_creation_time(item_creation_created);
        let energy_cost = item_creation::item_creation_created_energy_cost(item_creation_created);
        let success_rate = item_creation::item_creation_created_success_rate(item_creation_created);
        item_creation::create_item_creation(
            store_address,
            item_creation_id,
            resource_cost,
            requirements_level,
            base_quantity,
            base_experience,
            base_creation_time,
            energy_cost,
            success_rate,
        )
    }

}
