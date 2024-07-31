module infinite_seas::skill_process_complete_ship_production_logic {
    use std::option;
    use aptos_framework::object::{Self, Object};
    use aptos_framework::timestamp;

    use infinite_seas_common::experience_table;
    use infinite_seas_common::item_id;
    use infinite_seas_common::item_id_quantity_pairs;
    use infinite_seas_common::item_production;
    use infinite_seas_common::roster_id;
    use infinite_seas_common::roster_sequence_number;
    use infinite_seas_common::ship_util;
    use infinite_seas_common::skill_type_item_id_pair::SkillTypeItemIdPair;

    use infinite_seas::experience_table_util;
    use infinite_seas::genesis_account;
    use infinite_seas::pass_object;
    use infinite_seas::player;
    use infinite_seas::player::Player;
    use infinite_seas::player_properties;
    use infinite_seas::roster;
    use infinite_seas::roster::Roster;
    use infinite_seas::roster_aggregate;
    use infinite_seas::ship_aggregate;
    use infinite_seas::skill_process;
    use infinite_seas::skill_process_util;

    friend infinite_seas::skill_process_aggregate;

    const EProcessNotStarted: u64 = 10;
    //const EInvalidPlayerId: u64 = 11;
    //const EIncorrectSkillType: u64 = 12;
    //const ENotEnoughEnergy: u64 = 13;
    const EStillInProgress: u64 = 14;
    //const EIncorrectItemId: u64 = 22;
    //const ELowerThanRequiredLevel: u64 = 24;
    const EItemIdIsNotShip: u64 = 24;
    const EBuidingExpencesNotSet: u64 = 25;
    const ERosterIsNotUnassignedShips: u64 = 26;
    const EInvalidRoasterPlayerId: u64 = 27;
    const EProcessFailed: u64 = 30;
    //const ESenderHasNoPermission: u64 = 32;

    public(friend) fun verify(
        account: &signer,
        unassigned_ships_roster_obj_addr: Object<Roster>,
        player_obj: Object<Player>,
        item_production_id: SkillTypeItemIdPair,
        id: address,
        skill_process: &skill_process::SkillProcess,
    ): skill_process::ShipProductionProcessCompleted {
        let player_obj_addr = object::object_address(&player_obj);
        let player_pass_obj = player::get_player(player_obj_addr);
        let player = pass_object::borrow(&player_pass_obj);
        let store_addr = genesis_account::resource_account_address();
        let item_production_pass_obj = item_production::get_item_production(store_addr,
            item_production_id,
        );
        //let item_production = infinite_seas_common_pass_object::borrow(&item_production_pass_obj);
        let item_production = item_production::borrow(&item_production_pass_obj);

        let (player_id, _skill_type, item_id) = skill_process_util::assert_ids_are_consistent_for_completing_production(
            player_obj_addr, item_production, skill_process
        );
        assert!(item_id != item_id::unused_item() && !skill_process::completed(skill_process), EProcessNotStarted);
        assert!(item_id::ship() == item_id, EItemIdIsNotShip);
        let unassigned_ships_pass_obj = roster::get_roster(object::object_address(&unassigned_ships_roster_obj_addr));
        let unassigned_ships = pass_object::borrow(&unassigned_ships_pass_obj);
        let roster_id = roster::roster_id(unassigned_ships);
        assert!(
            roster_sequence_number::unassigned_ships() == roster_id::sequence_number(&roster_id),
            ERosterIsNotUnassignedShips
        );
        roster::return_roster(unassigned_ships_pass_obj);
        // Assert the player is the owner of the roster
        assert!(player_id == roster_id::player_id(&roster_id), EInvalidRoasterPlayerId);
        let building_expenses_o = skill_process::production_materials(skill_process);
        assert!(option::is_some(&building_expenses_o), EBuidingExpencesNotSet);

        let started_at = skill_process::started_at(skill_process);
        let creation_time = skill_process::creation_time(skill_process);
        let ended_at = timestamp::now_seconds(); //clock::timestamp_ms(clock) / 1000;
        assert!(ended_at >= started_at + creation_time, EStillInProgress);

        let successful = true; //todo always successful for now
        let quantity = item_production::base_quantity(item_production);
        let increased_experience = item_production::base_experience(item_production);
        let experience_table_pass_obj = experience_table::get_singleton_experience_table(
            store_addr);
        let experience_table = experience_table::borrow_singleton(&experience_table_pass_obj);
        let new_level = experience_table_util::calculate_new_level(player, experience_table, increased_experience);

        player::return_player(player_pass_obj);
        item_production::return_item_production(item_production_pass_obj);
        experience_table::return_singleton_experience_table(&genesis_account::resource_account_signer(),
            experience_table_pass_obj);

        skill_process::new_ship_production_process_completed(id,
            skill_process,
            unassigned_ships_roster_obj_addr,
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
        ship_production_process_completed: &skill_process::ShipProductionProcessCompleted,
        id: address,
        skill_process: skill_process::SkillProcess,
    ): skill_process::SkillProcess {
        let unassigned_ships_roster_obj_addr = skill_process::ship_production_process_completed_roster_object_address(
            ship_production_process_completed
        );
        let player_id = skill_process::ship_production_process_completed_player_id(ship_production_process_completed);
        // let item_id = skill_process::ship_production_process_completed_item_id(ship_production_process_completed);
        // let started_at = skill_process::ship_production_process_completed_started_at(ship_production_process_completed);
        // let creation_time = skill_process::ship_production_process_completed_creation_time(
        //     ship_production_process_completed
        // );
        let ended_at = skill_process::ship_production_process_completed_ended_at(ship_production_process_completed);
        let successful = skill_process::ship_production_process_completed_successful(ship_production_process_completed);
        // let quantity = skill_process::ship_production_process_completed_quantity(ship_production_process_completed);
        let experience = skill_process::ship_production_process_completed_experience(ship_production_process_completed);
        let new_level = skill_process::ship_production_process_completed_new_level(ship_production_process_completed);

        skill_process::set_completed(&mut skill_process, true);
        skill_process::set_ended_at(&mut skill_process, ended_at);
        assert!(successful, EProcessFailed);
        let items = vector[];//vector[item_id_quantity_pair::new(item_id, quantity)];

        let player_pass_obj = player::get_player(object::object_address(&player_id));
        let player = player_properties::borrow_mut_player(&mut player_pass_obj);
        player_properties::increase_experience_and_inventory_and_set_level(player, experience, items, new_level);
        let building_expenses_o = skill_process::production_materials(&mut skill_process);
        let building_expenses = item_id_quantity_pairs::items(option::borrow(&building_expenses_o));
        let (health_points, attack, protection, speed) = ship_util::calculate_ship_attributes(&building_expenses);
        let ship = ship_aggregate::create(
            _account,
            object::object_address(&player_id),
            health_points,
            attack,
            protection,
            speed,
            option::extract(&mut building_expenses_o),
        );
        // add ship into "unassigned_ships"
        roster_aggregate::add_ship(_account, unassigned_ships_roster_obj_addr, ship, option::none());

        player::return_player(player_pass_obj);
        skill_process
    }
}
