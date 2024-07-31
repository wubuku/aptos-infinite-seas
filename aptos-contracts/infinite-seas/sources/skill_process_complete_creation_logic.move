module infinite_seas::skill_process_complete_creation_logic {
    use aptos_framework::object::{Self, Object};
    use aptos_framework::timestamp;

    use infinite_seas_common::experience_table;
    use infinite_seas_common::item_creation;
    use infinite_seas_common::item_id;
    use infinite_seas_common::skill_type_item_id_pair::SkillTypeItemIdPair;

    use infinite_seas::experience_table_util;
    use infinite_seas::genesis_account;
    use infinite_seas::pass_object;
    use infinite_seas::player;
    use infinite_seas::player::Player;
    use infinite_seas::skill_process;
    use infinite_seas::skill_process_util;

    friend infinite_seas::skill_process_aggregate;

    const EProcessNotStarted: u64 = 10;
    //const EInvalidPlayerId: u64 = 11;
    //const EIncorrectSkillType: u64 = 12;
    //const ENotEnoughEnergy: u64 = 13;
    const EStillInProgress: u64 = 14;
    //const EIncorrectItemId: u64 = 22;
    // const EInvalidMutexPlayerId: u64 = 23;
    //const ELowerThanRequiredLevel: u64 = 24;
    //const ESenderHasNoPermission: u64 = 32;

    public(friend) fun verify(
        account: &signer,
        player_obj: Object<Player>,
        item_creation_id: SkillTypeItemIdPair,
        id: address,
        skill_process: &skill_process::SkillProcess,
    ): skill_process::CreationProcessCompleted {
        let player_obj_addr = object::object_address(&player_obj);
        let player_pass_obj = player::get_player(player_obj_addr);
        let player = pass_object::borrow(&player_pass_obj);
        let store_addr = genesis_account::resource_account_address();
        let item_creation_pass_obj = item_creation::get_item_creation(store_addr,
            item_creation_id,
        );
        //let item_production = infinite_seas_common_pass_object::borrow(&item_production_pass_obj);
        let item_creation = item_creation::borrow(&item_creation_pass_obj);

        let (_player_id, _skill_type, item_id) = skill_process_util::assert_ids_are_consistent_for_completing_creation(
            player_obj_addr, item_creation, skill_process
        );
        assert!(item_id != item_id::unused_item() && !skill_process::completed(skill_process), EProcessNotStarted);
        // assert!(skill_process_mutex::player_id(skill_process_mutex) == player_id, EInvalidMutexPlayerId);

        let started_at = skill_process::started_at(skill_process);
        let creation_time = skill_process::creation_time(skill_process);
        let ended_at = timestamp::now_seconds(); //clock::timestamp_ms(clock) / 1000;
        assert!(ended_at >= started_at + creation_time, EStillInProgress);

        let batch_size = skill_process::batch_size(skill_process);
        let successful = true; //todo always successful for now
        let quantity = item_creation::base_quantity(item_creation) * batch_size;
        let increased_experience = item_creation::base_experience(item_creation) * batch_size;
        let experience_table_pass_obj = experience_table::get_singleton_experience_table(
            store_addr);
        let experience_table = experience_table::borrow_singleton(&experience_table_pass_obj);
        let new_level = experience_table_util::calculate_new_level(player, experience_table, increased_experience);

        player::return_player(player_pass_obj);
        item_creation::return_item_creation(item_creation_pass_obj);
        experience_table::return_singleton_experience_table(&genesis_account::resource_account_signer(),
            experience_table_pass_obj);
        skill_process::new_creation_process_completed(id,
            skill_process,
            player_obj,
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
        creation_process_completed: &skill_process::CreationProcessCompleted,
        id: address,
        skill_process: skill_process::SkillProcess,
    ): skill_process::SkillProcess {
        let player_id = skill_process::creation_process_completed_player_id(creation_process_completed);
        let item_id = skill_process::creation_process_completed_item_id(creation_process_completed);
        let started_at = skill_process::creation_process_completed_started_at(creation_process_completed);
        let creation_time = skill_process::creation_process_completed_creation_time(creation_process_completed);
        let ended_at = skill_process::creation_process_completed_ended_at(creation_process_completed);
        let successful = skill_process::creation_process_completed_successful(creation_process_completed);
        let quantity = skill_process::creation_process_completed_quantity(creation_process_completed);
        let experience = skill_process::creation_process_completed_experience(creation_process_completed);
        let new_level = skill_process::creation_process_completed_new_level(creation_process_completed);
        // TODO ...

        skill_process
    }
}
