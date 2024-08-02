module infinite_seas_production::skill_process_complete_production_logic {
    use std::vector;
    use aptos_framework::timestamp;

    use infinite_seas_common::experience_table;
    use infinite_seas_common::experience_table_util;
    use infinite_seas_common::item_id;
    use infinite_seas_common::item_id_quantity_pair;
    use infinite_seas_common::item_id_quantity_pair::ItemIdQuantityPair;
    use infinite_seas_common::item_id_quantity_pairs;
    use infinite_seas_common::item_id_quantity_pairs::ItemIdQuantityPairs;
    use infinite_seas_common::item_production;
    use infinite_seas_common::skill_type_item_id_pair::SkillTypeItemIdPair;

    use infinite_seas_production::skill_process;
    use infinite_seas_production::skill_process_util;

    friend infinite_seas_production::skill_process_aggregate;

    const EProcessNotStarted: u64 = 10;
    //const EInvalidPlayerId: u64 = 11;
    //const EIncorrectSkillType: u64 = 12;
    //const ENotEnoughEnergy: u64 = 13;
    const EStillInProgress: u64 = 14;
    //const EIncorrectItemId: u64 = 21;
    //const ELowerThanRequiredLevel: u64 = 22;
    //const ESenderHasNoPermission: u64 = 23;
    const EItemProduceIndividuals: u64 = 24;

    public(friend) fun verify(
        account: &signer,
        store_address: address, //store_account: &signer,
        player_id: address, //player_obj: Object<Player>,
        player_level: u16,
        player_experience: u32,
        item_production_id: SkillTypeItemIdPair,
        id: address,
        skill_process: &skill_process::SkillProcess,
    ): skill_process::ProductionProcessCompleted {
        // let player_obj_addr = object::object_address(&player_obj);
        // let player_pass_obj = player::get_player(player_obj_addr);
        // let player = pass_object::borrow(&player_pass_obj);
        // let store_addr = genesis_account::resource_account_address();
        // let store_address = signer::address_of(store_account);
        let item_production_pass_obj = item_production::get_item_production(store_address,
            item_production_id,
        );
        //let item_production = infinite_seas_common_pass_object::borrow(&item_production_pass_obj);
        let item_production = item_production::borrow(&item_production_pass_obj);

        let (_player_id, _skill_type, item_id) = skill_process_util::assert_ids_are_consistent_for_completing_production(
            player_id, item_production, skill_process
        );
        assert!(item_id != item_id::unused_item() && !skill_process::completed(skill_process), EProcessNotStarted);
        assert!(!item_id::should_produce_individuals(item_id), EItemProduceIndividuals);

        let started_at = skill_process::started_at(skill_process);
        let creation_time = skill_process::creation_time(skill_process);
        let ended_at = timestamp::now_seconds(); //clock::timestamp_ms(clock) / 1000;
        assert!(ended_at >= started_at + creation_time, EStillInProgress);

        let batch_size = skill_process::batch_size(skill_process);
        let successful = true; //todo always successful for now
        let quantity = item_production::base_quantity(item_production) * batch_size;
        let increased_experience = item_production::base_experience(item_production) * batch_size;
        // let experience_table_pass_obj = experience_table::get_singleton_experience_table(
        //     store_address);
        // let experience_table = experience_table::borrow_singleton(&experience_table_pass_obj);
        let new_level = experience_table_util::calculate_new_level(
            player_level, //player::level(player),
            player_experience, //player::experience(player),
            &experience_table::singleton_levels(store_address),
            increased_experience
        );

        //player::return_player(player_pass_obj);
        item_production::return_item_production(item_production_pass_obj);
        // experience_table::return_singleton_experience_table(
        //     store_account, //&genesis_account::resource_account_signer(),
        //     experience_table_pass_obj
        // );
        skill_process::new_production_process_completed(
            id,
            skill_process,
            player_id, player_level, player_experience, //todo ?
            item_id,
            started_at,
            creation_time,
            ended_at,
            successful,
            quantity,
            increased_experience,
            new_level,
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        _store_address: address,
        production_process_completed: &skill_process::ProductionProcessCompleted,
        id: address,
        skill_process: skill_process::SkillProcess,
    ): (skill_process::SkillProcess, u32, u16, ItemIdQuantityPairs) {
        let player_id = skill_process::production_process_completed_player_id(production_process_completed);

        let item_id = skill_process::production_process_completed_item_id(production_process_completed);
        //let started_at = skill_process::production_process_completed_started_at(production_process_completed);
        //let creation_time = skill_process::production_process_completed_creation_time(production_process_completed);
        let ended_at = skill_process::production_process_completed_ended_at(production_process_completed);
        let successful = skill_process::production_process_completed_successful(production_process_completed);
        //let skill_process_id = skill_process::skill_process_id(skill_process);
        let quantity = skill_process::production_process_completed_quantity(production_process_completed);
        let experience = skill_process::production_process_completed_experience(production_process_completed);
        let new_level = skill_process::production_process_completed_new_level(production_process_completed);

        //skill_process::set_item_id(skill_process, item_id);
        //skill_process::set_started_at(skill_process, started_at);
        skill_process::set_completed(&mut skill_process, true);
        skill_process::set_ended_at(&mut skill_process, ended_at);

        // let player_pass_obj = player::get_player(object::object_address(&player_id));
        // let player = player_properties::borrow_mut_player(&mut player_pass_obj);
        // if (successful) {
        //     let items = vector[item_id_quantity_pair::new(item_id, quantity)];
        //     player_properties::increase_experience_and_inventory_and_set_level(player, experience, items, new_level);
        // };
        // player::return_player(player_pass_obj);
        let items =
            if (successful) {
                vector[item_id_quantity_pair::new(item_id, quantity)]
                //player_properties::increase_experience_and_inventory_and_set_level(player, experience, items, new_level);
            } else {
                vector::empty<ItemIdQuantityPair>()
            };
        (skill_process, experience, new_level, item_id_quantity_pairs::new_by_vector(items))
    }
}
