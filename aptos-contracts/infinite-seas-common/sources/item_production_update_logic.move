module infinite_seas_common::item_production_update_logic {
    use infinite_seas_common::item_id_quantity_pairs::ItemIdQuantityPairs;
    use infinite_seas_common::item_production;

    friend infinite_seas_common::item_production_aggregate;

    public(friend) fun verify(
        account: &signer,
        store_address: address,
        production_materials: ItemIdQuantityPairs,
        requirements_level: u16,
        base_quantity: u32,
        base_experience: u32,
        base_creation_time: u64,
        energy_cost: u64,
        success_rate: u16,
        item_production: &item_production::ItemProduction,
    ): item_production::ItemProductionUpdated {
        let _ = account;
        item_production::new_item_production_updated(
            item_production,
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
        item_production_updated: &item_production::ItemProductionUpdated,
        item_production: item_production::ItemProduction,
    ): item_production::ItemProduction {
        let production_materials = item_production::item_production_updated_production_materials(item_production_updated);
        let requirements_level = item_production::item_production_updated_requirements_level(item_production_updated);
        let base_quantity = item_production::item_production_updated_base_quantity(item_production_updated);
        let base_experience = item_production::item_production_updated_base_experience(item_production_updated);
        let base_creation_time = item_production::item_production_updated_base_creation_time(item_production_updated);
        let energy_cost = item_production::item_production_updated_energy_cost(item_production_updated);
        let success_rate = item_production::item_production_updated_success_rate(item_production_updated);
        let item_production_id = item_production::item_production_id(&item_production);
        let _ = item_production_id;
        item_production::set_production_materials(&mut item_production, production_materials);
        item_production::set_requirements_level(&mut item_production, requirements_level);
        item_production::set_base_quantity(&mut item_production, base_quantity);
        item_production::set_base_experience(&mut item_production, base_experience);
        item_production::set_base_creation_time(&mut item_production, base_creation_time);
        item_production::set_energy_cost(&mut item_production, energy_cost);
        item_production::set_success_rate(&mut item_production, success_rate);
        item_production
    }

}
