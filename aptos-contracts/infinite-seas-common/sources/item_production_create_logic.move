module infinite_seas_common::item_production_create_logic {
    use infinite_seas_common::item_id_quantity_pairs::ItemIdQuantityPairs;
    use infinite_seas_common::item_production;
    use infinite_seas_common::skill_type_item_id_pair::SkillTypeItemIdPair;

    friend infinite_seas_common::item_production_aggregate;

    public(friend) fun verify(
        account: &signer,
        store_address: address,      
        item_production_id: SkillTypeItemIdPair,
        production_materials: ItemIdQuantityPairs,
        requirements_level: u16,
        base_quantity: u32,
        base_experience: u32,
        base_creation_time: u64,
        energy_cost: u64,
        success_rate: u16,
    ): item_production::ItemProductionCreated {
        let _ = account;
        item_production::asset_item_production_not_exists(store_address, item_production_id);
        item_production::new_item_production_created(
            item_production_id,
            production_materials,
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
        item_production_created: &item_production::ItemProductionCreated,
    ): item_production::ItemProduction {
        let item_production_id = item_production::item_production_created_item_production_id(item_production_created);
        let production_materials = item_production::item_production_created_production_materials(item_production_created);
        let requirements_level = item_production::item_production_created_requirements_level(item_production_created);
        let base_quantity = item_production::item_production_created_base_quantity(item_production_created);
        let base_experience = item_production::item_production_created_base_experience(item_production_created);
        let base_creation_time = item_production::item_production_created_base_creation_time(item_production_created);
        let energy_cost = item_production::item_production_created_energy_cost(item_production_created);
        let success_rate = item_production::item_production_created_success_rate(item_production_created);
        item_production::create_item_production(
            store_address,
            item_production_id,
            production_materials,
            requirements_level,
            base_quantity,
            base_experience,
            base_creation_time,
            energy_cost,
            success_rate,
        )
    }

}
