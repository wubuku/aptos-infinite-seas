module infinite_seas_production::skill_process_start_ship_production_logic {
    use std::option;
    use std::signer;
    use std::vector;
    use aptos_framework::timestamp;

    use infinite_seas_common::item_id;
    use infinite_seas_common::item_id_quantity_pair;
    use infinite_seas_common::item_id_quantity_pairs;
    use infinite_seas_common::item_id_quantity_pairs::ItemIdQuantityPairs;
    use infinite_seas_common::item_production;
    use infinite_seas_common::skill_type_item_id_pair::SkillTypeItemIdPair;
    use infinite_seas_common::sorted_vector_util;

    use infinite_seas_production::skill_process;
    use infinite_seas_production::skill_process_util;

    friend infinite_seas_production::skill_process_aggregate;

    const EProcessAlreadyStarted: u64 = 10;
    const ENotEnoughEnergy: u64 = 13;
    const ELowerThanRequiredLevel: u64 = 14;
    const ESenderHasNoPermission: u64 = 22;
    const EItemIdIsNotShip: u64 = 24;
    const EMaterialsMismatch: u64 = 25;
    const ENotEnoughMaterials: u64 = 26;

    public(friend) fun verify(
        account: &signer,
        store_address: address, //store_account: &signer,
        production_materials: ItemIdQuantityPairs,
        player_id: address, //player_obj: Object<Player>,
        player_level: u16,
        item_production_id: SkillTypeItemIdPair,
        id: address,
        skill_process: &skill_process::SkillProcess,
    ): skill_process::ShipProductionProcessStarted {
        //let store_address = signer::address_of(store_account);
        // let player_obj_addr = object::object_address(&player_obj);
        // let player_pass_obj = player::get_player(player_obj_addr);
        // let player = pass_object::borrow(&player_pass_obj);
        // assert!(std::signer::address_of(account) == player::owner(player), ESenderHasNoPermission);
        assert!(
            skill_process::item_id(skill_process) == item_id::unused_item() || skill_process::completed(skill_process),
            EProcessAlreadyStarted
        );
        let item_production_pass_obj = item_production::get_item_production(
            store_address,
            item_production_id,
        );
        //let item_production = infinite_seas_common_pass_object::borrow(&item_production_pass_obj);
        let item_production = item_production::borrow(&item_production_pass_obj);
        let (_player_id, skill_type, item_id) = skill_process_util::assert_ids_are_consistent_for_starting_production(
            player_id, item_production, skill_process
        );
        //assert!(skill_process_util::is_non_mutex_skill(skill_type), EIsMutexSkillType);
        assert!(item_id::ship() == item_id, EItemIdIsNotShip);

        let requirements_level = item_production::requirements_level(item_production);
        assert!(player_level >= requirements_level, ELowerThanRequiredLevel);
        // player::return_player(player_pass_obj);

        let base_creation_time = item_production::base_creation_time(item_production);
        let energy_cost = 0; //TODO balance::value(energy);
        assert!(energy_cost >= item_production::energy_cost(item_production), ENotEnoughEnergy);
        let creation_time = base_creation_time; // todo level-based or XXX-based creation time calculation?
        let basic_production_materials = item_id_quantity_pairs::items(
            &item_production::production_materials(item_production)
        );
        item_production::return_item_production(item_production_pass_obj);

        let actual_production_materials = item_id_quantity_pairs::items(&production_materials);
        let i = 0;
        let l = vector::length(&basic_production_materials);
        while (i < l) {
            let p = vector::borrow(&basic_production_materials, i);
            let item_id = item_id_quantity_pair::item_id(p);
            let basic_quantity = item_id_quantity_pair::quantity(p);
            let actual_p_idx = sorted_vector_util::find_item_id_quantity_pair_by_item_id(
                &actual_production_materials,
                item_id
            );
            assert!(option::is_some(&actual_p_idx), EMaterialsMismatch);
            let actual_p = vector::borrow(&actual_production_materials, *option::borrow(&actual_p_idx));
            let actual_quantity = item_id_quantity_pair::quantity(actual_p);
            assert!(actual_quantity >= basic_quantity, ENotEnoughMaterials);
            i = i + 1;
        };
        skill_process::new_ship_production_process_started(id,
            skill_process,
            player_id,
            player_level,
            item_id,
            energy_cost,
            timestamp::now_seconds(), //clock::timestamp_ms(clock) / 1000,
            creation_time,
            production_materials,
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        //store_account: &signer,
        ship_production_process_started: &skill_process::ShipProductionProcessStarted,
        id: address,
        skill_process: skill_process::SkillProcess,
    ): skill_process::SkillProcess {
        let player_id = skill_process::ship_production_process_started_player_id(ship_production_process_started);
        let item_id = skill_process::ship_production_process_started_item_id(ship_production_process_started);
        let started_at = skill_process::ship_production_process_started_started_at(ship_production_process_started);
        //let skill_process_id = skill_process::skill_process_id(skill_process);
        //let energy_cost = skill_process::ship_production_process_started_energy_cost(ship_production_process_started);
        let creation_time = skill_process::ship_production_process_started_creation_time(
            ship_production_process_started
        );
        let production_materials = skill_process::ship_production_process_started_production_materials(
            ship_production_process_started
        );
        skill_process::set_item_id(&mut skill_process, item_id);
        skill_process::set_started_at(&mut skill_process, started_at);
        skill_process::set_creation_time(&mut skill_process, creation_time);
        skill_process::set_completed(&mut skill_process, false);
        skill_process::set_ended_at(&mut skill_process, 0);
        skill_process::set_production_materials(&mut skill_process, option::some(production_materials));

        // TODO let energy_vault = skill_process::borrow_mut_energy_vault(skill_process);
        // balance::join(energy_vault, energy);

        // let player_pass_obj = player::get_player(object::object_address(&player_id));
        // let player = player_properties::borrow_mut_player(&mut player_pass_obj);
        // player_properties::deduct_inventory(player, item_id_quantity_pairs::items(&production_materials));
        // player::return_player(player_pass_obj);
        skill_process
    }
}
