module infinite_seas_production::skill_process_start_creation_logic {
    use std::signer;
    use aptos_framework::timestamp;

    use infinite_seas_common::item_creation;
    use infinite_seas_common::item_id;
    use infinite_seas_common::item_id_quantity_pair;
    use infinite_seas_common::skill_process_id;
    use infinite_seas_common::skill_type_item_id_pair::SkillTypeItemIdPair;

    use infinite_seas_production::skill_process;
    use infinite_seas_production::skill_process_util;

    friend infinite_seas_production::skill_process_aggregate;


    const EProcessAlreadyStarted: u64 = 10;
    const ENotEnoughEnergy: u64 = 13;
    const ELowerThanRequiredLevel: u64 = 14;
    // const EIsNonMutexSkillType: u64 = 15;
    const ESenderHasNoPermission: u64 = 22;
    // const EInvalidMutexPlayerId: u64 = 23;

    public(friend) fun verify(
        account: &signer,
        store_address: address, //store_account: &signer,
        batch_size: u32,
        player_id: address, //player_obj: Object<Player>,
        player_level: u16,
        item_creation_id: SkillTypeItemIdPair,
        id: address,
        skill_process: &skill_process::SkillProcess,
    ): skill_process::CreationProcessStarted {
        // let store_address = signer::address_of(store_account);
        // let player_obj_addr = object::object_address(&player_obj);
        // let player_pass_obj = player::get_player(player_obj_addr);
        // let player = pass_object::borrow(&player_pass_obj);
        // assert!(std::signer::address_of(account) == player::owner(player), ESenderHasNoPermission);
        assert!(
            skill_process::item_id(skill_process) == item_id::unused_item() || skill_process::completed(skill_process),
            EProcessAlreadyStarted
        );
        let item_creation_pass_obj = item_creation::get_item_creation(
            store_address,
            item_creation_id,
        );
        let item_creation = item_creation::borrow(&item_creation_pass_obj);
        let (_player_id, skill_type, item_id) = skill_process_util::assert_ids_are_consistent_for_starting_creation(
            player_id, item_creation, skill_process
        );
        // assert!(skill_process_mutex::player_id(skill_process_mutex) == player_id, EInvalidMutexPlayerId);
        // assert!(skill_process_util::is_mutex_skill(skill_type), EIsNonMutexSkillType);

        let requirements_level = item_creation::requirements_level(item_creation);
        assert!(player_level >= requirements_level, ELowerThanRequiredLevel);
        //player::return_player(player_pass_obj);

        let base_creation_time = item_creation::base_creation_time(item_creation);
        let energy_cost = 0; //TODO balance::value(energy);
        assert!(energy_cost >= item_creation::energy_cost(item_creation) * (batch_size as u64), ENotEnoughEnergy);
        let creation_time = base_creation_time * (batch_size as u64); // todo level-based or XXX-based creation time calculation?
        let resource_cost = item_creation::resource_cost(item_creation) * batch_size;

        item_creation::return_item_creation(item_creation_pass_obj);
        skill_process::new_creation_process_started(
            id,
            skill_process,
            batch_size,
            player_id,
            player_level,
            item_id,
            energy_cost,
            resource_cost,
            timestamp::now_seconds(), //clock::timestamp_ms(clock) / 1000,
            creation_time,
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        //store_account: &signer,
        creation_process_started: &skill_process::CreationProcessStarted,
        id: address,
        skill_process: skill_process::SkillProcess,
    ): skill_process::SkillProcess {
        let player_id = skill_process::creation_process_started_player_id(creation_process_started);
        let item_id = skill_process::creation_process_started_item_id(creation_process_started);
        //let energy_cost = skill_process::creation_process_started_energy_cost(creation_process_started);
        let resource_cost = skill_process::creation_process_started_resource_cost(creation_process_started);
        let started_at = skill_process::creation_process_started_started_at(creation_process_started);
        let creation_time = skill_process::creation_process_started_creation_time(creation_process_started);
        let skill_process_id = skill_process::skill_process_id(&skill_process);
        let skill_type = skill_process_id::skill_type(&skill_process_id);
        let resource_type = item_id::resource_type_required_for_skill(skill_type);
        let batch_size = skill_process::creation_process_started_batch_size(creation_process_started);

        // skill_process_mutex_aggregate::lock(skill_process_mutex, skill_type, ctx);

        skill_process::set_item_id(&mut skill_process, item_id);
        skill_process::set_started_at(&mut skill_process, started_at);
        skill_process::set_creation_time(&mut skill_process, creation_time);
        skill_process::set_completed(&mut skill_process, false);
        skill_process::set_ended_at(&mut skill_process, 0);
        skill_process::set_batch_size(&mut skill_process, batch_size);

        //todo let energy_vault = skill_process::borrow_mut_energy_vault(skill_process);
        //balance::join(energy_vault, energy);

        let required_resource_items = vector[item_id_quantity_pair::new(resource_type, resource_cost)];

        // let player_pass_obj = player::get_player(object::object_address(&player_id));
        // let player = player_properties::borrow_mut_player(&mut player_pass_obj);
        // player_properties::deduct_inventory(player, required_resource_items);
        // player::return_player(player_pass_obj);

        skill_process
    }
}
