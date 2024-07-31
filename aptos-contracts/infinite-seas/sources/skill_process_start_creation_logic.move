module infinite_seas::skill_process_start_creation_logic {
    use aptos_framework::object::{Self, Object};
    use aptos_framework::timestamp;

    use infinite_seas_common::item_creation;
    use infinite_seas_common::item_id;
    use infinite_seas_common::skill_type_item_id_pair::SkillTypeItemIdPair;

    use infinite_seas::genesis_account;
    use infinite_seas::pass_object;
    use infinite_seas::player;
    use infinite_seas::player::Player;
    use infinite_seas::skill_process;
    use infinite_seas::skill_process_util;

    friend infinite_seas::skill_process_aggregate;


    const EProcessAlreadyStarted: u64 = 10;
    const ENotEnoughEnergy: u64 = 13;
    const ELowerThanRequiredLevel: u64 = 14;
    // const EIsNonMutexSkillType: u64 = 15;
    const ESenderHasNoPermission: u64 = 22;
    // const EInvalidMutexPlayerId: u64 = 23;

    public(friend) fun verify(
        account: &signer,
        batch_size: u32,
        player_obj: Object<Player>,
        item_creation_id: SkillTypeItemIdPair,
        id: address,
        skill_process: &skill_process::SkillProcess,
    ): skill_process::CreationProcessStarted {
        let player_obj_addr = object::object_address(&player_obj);
        let player_pass_obj = player::get_player(player_obj_addr);
        let player = pass_object::borrow(&player_pass_obj);
        assert!(std::signer::address_of(account) == player::owner(player), ESenderHasNoPermission);
        assert!(
            skill_process::item_id(skill_process) == item_id::unused_item() || skill_process::completed(skill_process),
            EProcessAlreadyStarted
        );
        let item_creation_pass_obj = item_creation::get_item_creation(
            genesis_account::resource_account_address(),
            item_creation_id,
        );
        let item_creation = item_creation::borrow(&item_creation_pass_obj);
        let (_player_id, skill_type, item_id) = skill_process_util::assert_ids_are_consistent_for_starting_creation(
            player_obj_addr, item_creation, skill_process
        );
        // assert!(skill_process_mutex::player_id(skill_process_mutex) == player_id, EInvalidMutexPlayerId);
        // assert!(skill_process_util::is_mutex_skill(skill_type), EIsNonMutexSkillType);

        let requirements_level = item_creation::requirements_level(item_creation);
        assert!(player::level(player) >= requirements_level, ELowerThanRequiredLevel);
        player::return_player(player_pass_obj);

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
            player_obj,
            item_id,
            energy_cost,
            resource_cost,
            timestamp::now_seconds(), //clock::timestamp_ms(clock) / 1000,
            creation_time,
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        creation_process_started: &skill_process::CreationProcessStarted,
        id: address,
        skill_process: skill_process::SkillProcess,
    ): skill_process::SkillProcess {
        let batch_size = skill_process::creation_process_started_batch_size(creation_process_started);
        let player_id = skill_process::creation_process_started_player_id(creation_process_started);
        let item_id = skill_process::creation_process_started_item_id(creation_process_started);
        let energy_cost = skill_process::creation_process_started_energy_cost(creation_process_started);
        let resource_cost = skill_process::creation_process_started_resource_cost(creation_process_started);
        let started_at = skill_process::creation_process_started_started_at(creation_process_started);
        let creation_time = skill_process::creation_process_started_creation_time(creation_process_started);
        // TODO ...

        skill_process
    }
}