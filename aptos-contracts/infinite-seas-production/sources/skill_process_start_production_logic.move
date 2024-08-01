module infinite_seas_production::skill_process_start_production_logic {
    use std::signer;
    use aptos_framework::timestamp;

    use infinite_seas_common::item_id;
    use infinite_seas_common::item_id_quantity_pairs;
    use infinite_seas_common::item_production;
    use infinite_seas_common::skill_type_item_id_pair::SkillTypeItemIdPair;
    use infinite_seas_common::sorted_vector_util;

    use infinite_seas_production::skill_process;
    use infinite_seas_production::skill_process_util;

    friend infinite_seas_production::skill_process_aggregate;

    const EProcessAlreadyStarted: u64 = 10;
    //const EInvalidPlayerId: u64 = 11;
    //const EIncorrectSkillType: u64 = 12;
    const ENotEnoughEnergy: u64 = 13;
    const ELowerThanRequiredLevel: u64 = 14;
    //const EIsMutexSkillType: u64 = 15;
    const ESenderHasNoPermission: u64 = 22;
    const EItemProduceIndividuals: u64 = 24;

    public(friend) fun verify(
        account: &signer,
        store_account: &signer,
        batch_size: u32,
        player_id: address, //player_obj: Object<Player>,
        player_level: u16,
        item_production_id: SkillTypeItemIdPair,
        id: address,
        skill_process: &skill_process::SkillProcess,
    ): skill_process::ProductionProcessStarted {
        let store_address = signer::address_of(store_account);
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
        assert!(!item_id::should_produce_individuals(item_id), EItemProduceIndividuals);

        let requirements_level = item_production::requirements_level(item_production);
        assert!(player_level >= requirements_level, ELowerThanRequiredLevel);
        //player::return_player(player_pass_obj);

        let base_creation_time = item_production::base_creation_time(item_production);
        let energy_cost = 0; //TODO = balance::value(energy);
        //TODO assert!(energy_cost >= item_production::energy_cost(item_production) * (batch_size as u64), ENotEnoughEnergy);
        let creation_time = base_creation_time * (batch_size as u64); // todo level-based or XXX-based creation time calculation?
        let production_materials = sorted_vector_util::item_id_quantity_pairs_multiply(
            item_id_quantity_pairs::borrow_items(&item_production::production_materials(item_production)), batch_size);
        item_production::return_item_production(item_production_pass_obj);

        skill_process::new_production_process_started(
            id,
            skill_process,
            batch_size,
            player_id,
            player_level,
            item_id,
            energy_cost,
            timestamp::now_seconds(), //clock::timestamp_ms(clock) / 1000,
            creation_time,
            item_id_quantity_pairs::new_by_vector(production_materials),
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        store_account: &signer,
        production_process_started: &skill_process::ProductionProcessStarted,
        id: address,
        skill_process: skill_process::SkillProcess,
    ): skill_process::SkillProcess {
        let batch_size = skill_process::production_process_started_batch_size(production_process_started);
        let player_id = skill_process::production_process_started_player_id(production_process_started);
        let item_id = skill_process::production_process_started_item_id(production_process_started);
        let energy_cost = skill_process::production_process_started_energy_cost(production_process_started);
        let started_at = skill_process::production_process_started_started_at(production_process_started);
        let creation_time = skill_process::production_process_started_creation_time(production_process_started);
        let production_materials = skill_process::production_process_started_production_materials(
            production_process_started
        );

        skill_process::set_item_id(&mut skill_process, item_id);
        skill_process::set_started_at(&mut skill_process, started_at);
        skill_process::set_creation_time(&mut skill_process, creation_time);
        skill_process::set_completed(&mut skill_process, false);
        skill_process::set_ended_at(&mut skill_process, 0);
        skill_process::set_batch_size(&mut skill_process, batch_size);

        //TODO let energy_vault = skill_process::borrow_mut_energy_vault(skill_process);
        //TODO balance::join(energy_vault, energy);

        // let player_pass_obj = player::get_player(object::object_address(&player_id));
        // let player = player_properties::borrow_mut_player(&mut player_pass_obj);
        // player_properties::deduct_inventory(player, item_id_quantity_pairs::items(&production_materials));
        // player::return_player(player_pass_obj);
        skill_process
    }
}
