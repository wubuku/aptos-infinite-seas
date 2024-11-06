// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas_production::skill_process_aggregate {
    use aptos_framework::object::{Self, Object};
    use infinite_seas_common::item_id_quantity_pairs::ItemIdQuantityPairs;
    use infinite_seas_common::skill_process_id::SkillProcessId;
    use infinite_seas_common::skill_type_item_id_pair::SkillTypeItemIdPair;
    use infinite_seas_production::production_friend_config;
    use infinite_seas_production::skill_process::{Self, SkillProcess};
    use infinite_seas_production::skill_process_complete_creation_logic;
    use infinite_seas_production::skill_process_complete_production_logic;
    use infinite_seas_production::skill_process_complete_ship_production_logic;
    use infinite_seas_production::skill_process_create_logic;
    use infinite_seas_production::skill_process_start_creation_logic;
    use infinite_seas_production::skill_process_start_production_logic;
    use infinite_seas_production::skill_process_start_ship_production_logic;
    use std::signer;


    const EMismatchedObjectSeed: u64 = 150;

    public fun create<FWT: drop>(
        _friend_witness: FWT,
        account: &signer,
        store_account: &signer,
        skill_process_id: SkillProcessId,
    ) {
        production_friend_config::assert_allowlisted(_friend_witness);
        let constructor_ref = object::create_named_object(store_account, std::bcs::to_bytes(&skill_process_id));
        let object_signer = object::generate_signer(&constructor_ref);
        let extend_ref = object::generate_extend_ref(&constructor_ref);
        let id = object::address_from_constructor_ref(&constructor_ref);
        let skill_process_created = skill_process_create_logic::verify(
            account,
            store_account,
            skill_process_id,
            id,
        );
        let skill_process = skill_process_create_logic::mutate(
            account,
            store_account,
            &skill_process_created,
            id,
        );
        assert!(skill_process_id == skill_process::skill_process_id(&skill_process), EMismatchedObjectSeed);
        skill_process::add_skill_process(&object_signer, skill_process);
        skill_process::save_object_controller(&object_signer,
            extend_ref,
        );
        skill_process::set_skill_process_created_id(&mut skill_process_created, id);
        skill_process::emit_skill_process_created(signer::address_of(store_account), skill_process_created);
    }

    public fun start_production<FWT: drop>(
        _friend_witness: FWT,
        account: &signer,
        store_address: address,
        skill_process_obj: Object<SkillProcess>,
        batch_size: u32,
        player_id: address,
        player_level: u16,
        item_production_id: SkillTypeItemIdPair,
    ): ItemIdQuantityPairs {
        production_friend_config::assert_allowlisted(_friend_witness);
        let id = object::object_address(&skill_process_obj);
        let skill_process = skill_process::remove_skill_process(id);
        let production_process_started = skill_process_start_production_logic::verify(
            account,
            store_address,
            batch_size,
            player_id,
            player_level,
            item_production_id,
            id,
            &skill_process,
        );
        let (updated_skill_process, required_item_input) = skill_process_start_production_logic::mutate(
            account,
            store_address,
            &production_process_started,
            id,
            skill_process,
        );
        skill_process::update_version_and_add(id, updated_skill_process);
        skill_process::emit_production_process_started(store_address, production_process_started);
        required_item_input
    }

    public fun complete_production<FWT: drop>(
        _friend_witness: FWT,
        account: &signer,
        store_address: address,
        skill_process_obj: Object<SkillProcess>,
        player_id: address,
        player_level: u16,
        player_experience: u32,
        item_production_id: SkillTypeItemIdPair,
    ): (u32, u16, ItemIdQuantityPairs) {
        production_friend_config::assert_allowlisted(_friend_witness);
        let id = object::object_address(&skill_process_obj);
        let skill_process = skill_process::remove_skill_process(id);
        let production_process_completed = skill_process_complete_production_logic::verify(
            account,
            store_address,
            player_id,
            player_level,
            player_experience,
            item_production_id,
            id,
            &skill_process,
        );
        let (updated_skill_process, experience_gained, new_level, item_output) = skill_process_complete_production_logic::mutate(
            account,
            store_address,
            &production_process_completed,
            id,
            skill_process,
        );
        skill_process::update_version_and_add(id, updated_skill_process);
        skill_process::emit_production_process_completed(store_address, production_process_completed);
        (experience_gained, new_level, item_output)
    }

    public fun start_ship_production<FWT: drop>(
        _friend_witness: FWT,
        account: &signer,
        store_address: address,
        skill_process_obj: Object<SkillProcess>,
        production_materials: ItemIdQuantityPairs,
        player_id: address,
        player_level: u16,
        item_production_id: SkillTypeItemIdPair,
    ): ItemIdQuantityPairs {
        production_friend_config::assert_allowlisted(_friend_witness);
        let id = object::object_address(&skill_process_obj);
        let skill_process = skill_process::remove_skill_process(id);
        let ship_production_process_started = skill_process_start_ship_production_logic::verify(
            account,
            store_address,
            production_materials,
            player_id,
            player_level,
            item_production_id,
            id,
            &skill_process,
        );
        let (updated_skill_process, required_item_input) = skill_process_start_ship_production_logic::mutate(
            account,
            store_address,
            &ship_production_process_started,
            id,
            skill_process,
        );
        skill_process::update_version_and_add(id, updated_skill_process);
        skill_process::emit_ship_production_process_started(store_address, ship_production_process_started);
        required_item_input
    }

    public fun complete_ship_production<FWT: drop>(
        _friend_witness: FWT,
        account: &signer,
        store_address: address,
        skill_process_obj: Object<SkillProcess>,
        unassigned_ships: address,
        player_id: address,
        player_level: u16,
        player_experience: u32,
        item_production_id: SkillTypeItemIdPair,
    ): (u32, u16, ItemIdQuantityPairs) {
        production_friend_config::assert_allowlisted(_friend_witness);
        let id = object::object_address(&skill_process_obj);
        let skill_process = skill_process::remove_skill_process(id);
        let ship_production_process_completed = skill_process_complete_ship_production_logic::verify(
            account,
            store_address,
            unassigned_ships,
            player_id,
            player_level,
            player_experience,
            item_production_id,
            id,
            &skill_process,
        );
        let (updated_skill_process, experience_gained, new_level, building_expenses) = skill_process_complete_ship_production_logic::mutate(
            account,
            store_address,
            &ship_production_process_completed,
            id,
            skill_process,
        );
        skill_process::update_version_and_add(id, updated_skill_process);
        skill_process::emit_ship_production_process_completed(store_address, ship_production_process_completed);
        (experience_gained, new_level, building_expenses)
    }

    public fun start_creation<FWT: drop>(
        _friend_witness: FWT,
        account: &signer,
        store_address: address,
        skill_process_obj: Object<SkillProcess>,
        batch_size: u32,
        player_id: address,
        player_level: u16,
        item_creation_id: SkillTypeItemIdPair,
    ): ItemIdQuantityPairs {
        production_friend_config::assert_allowlisted(_friend_witness);
        let id = object::object_address(&skill_process_obj);
        let skill_process = skill_process::remove_skill_process(id);
        let creation_process_started = skill_process_start_creation_logic::verify(
            account,
            store_address,
            batch_size,
            player_id,
            player_level,
            item_creation_id,
            id,
            &skill_process,
        );
        let (updated_skill_process, required_item_input) = skill_process_start_creation_logic::mutate(
            account,
            store_address,
            &creation_process_started,
            id,
            skill_process,
        );
        skill_process::update_version_and_add(id, updated_skill_process);
        skill_process::emit_creation_process_started(store_address, creation_process_started);
        required_item_input
    }

    public fun complete_creation<FWT: drop>(
        _friend_witness: FWT,
        account: &signer,
        store_address: address,
        skill_process_obj: Object<SkillProcess>,
        player_id: address,
        player_level: u16,
        player_experience: u32,
        item_creation_id: SkillTypeItemIdPair,
    ): (u32, u16, ItemIdQuantityPairs) {
        production_friend_config::assert_allowlisted(_friend_witness);
        let id = object::object_address(&skill_process_obj);
        let skill_process = skill_process::remove_skill_process(id);
        let creation_process_completed = skill_process_complete_creation_logic::verify(
            account,
            store_address,
            player_id,
            player_level,
            player_experience,
            item_creation_id,
            id,
            &skill_process,
        );
        let (updated_skill_process, experience_gained, new_level, item_output) = skill_process_complete_creation_logic::mutate(
            account,
            store_address,
            &creation_process_completed,
            id,
            skill_process,
        );
        skill_process::update_version_and_add(id, updated_skill_process);
        skill_process::emit_creation_process_completed(store_address, creation_process_completed);
        (experience_gained, new_level, item_output)
    }

}
