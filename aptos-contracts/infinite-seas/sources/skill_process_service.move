module infinite_seas::skill_process_service {
    use aptos_framework::object::{Self, Object};

    use infinite_seas_common::item_id_quantity_pairs;
    use infinite_seas_common::skill_type_item_id_pair;
    use infinite_seas_production::skill_process::SkillProcess;
    use infinite_seas_production::skill_process_aggregate;

    use infinite_seas::genesis_account;
    use infinite_seas::player;
    use infinite_seas::player::Player;
    use infinite_seas::player_properties;

    const ENotInitialized: u64 = 110;
    const ESenderHasNoPermission: u64 = 111;

    struct FriendWitness has drop {}

    public fun initialize(account: &signer) {}

    public entry fun start_creation(
        account: &signer,
        skill_process_object: Object<SkillProcess>,
        batch_size: u32,
        player_object: Object<Player>,
        item_creation_id_skill_type: u8,
        item_creation_id_item_id: u32,
    ) {
        let item_creation_id = skill_type_item_id_pair::new(item_creation_id_skill_type, item_creation_id_item_id);
        let player_obj_addr = object::object_address(&player_object);
        let player_pass_obj = player::get_player(player_obj_addr);
        // TODO let player = player_properties::borrow_mut_player(&mut player_pass_obj);
        //
        // assert!(std::signer::address_of(account) == player::owner(player), ESenderHasNoPermission);
        // let required_items = skill_process_aggregate::start_creation(
        //     FriendWitness {},
        //     account,
        //     genesis_account::resource_account_address(),
        //     skill_process_object,
        //     batch_size,
        //     player_obj_addr,
        //     player::level(player),
        //     item_creation_id
        // );
        // player_properties::deduct_inventory(player, item_id_quantity_pairs::items(&required_items));

        player::return_player(player_pass_obj);
    }
}
