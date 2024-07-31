module infinite_seas_production::skill_process_util {
    use infinite_seas_common::item_creation::{Self, ItemCreation};
    use infinite_seas_common::item_production::{Self, ItemProduction};
    use infinite_seas_common::skill_process_id;
    use infinite_seas_common::skill_type;
    use infinite_seas_common::skill_type_item_id_pair;

    use infinite_seas_production::skill_process::{Self, SkillProcess};

    const EInvalidPlayerId: u64 = 11;
    const EIncorrectSkillType: u64 = 12;
    const EIncorrectItemId: u64 = 22;

    // public fun is_non_mutex_skill(skill_type: u8): bool {
    //     skill_type == skill_type::farming()
    //         || skill_type == skill_type::sailing()
    //         || skill_type == skill_type::township()
    // }

    // public fun is_mutex_skill(skill_type: u8): bool {
    //     !is_non_mutex_skill(skill_type)
    // }

    public fun skill_type_max_sequence_number(skill_type: u8): u8 {
        if (skill_type == skill_type::farming()) {
            1
        } else {
            0
        }
    }

    public fun assert_ids_are_consistent_for_starting_creation(
        player_id: address, //player: &Player,
        item_creation: &ItemCreation,
        skill_process: &SkillProcess,
    ): (address, u8, u32) {
        let skill_process_id = skill_process::skill_process_id(skill_process);
        let skill_process_id_player_id = infinite_seas_common::skill_process_id::player_id(&skill_process_id);
        assert!(skill_process_id_player_id == player_id, EInvalidPlayerId);

        let item_creation_id = item_creation::item_creation_id(item_creation);
        let skill_type = skill_type_item_id_pair::skill_type(&item_creation_id);
        assert!(skill_type == skill_process_id::skill_type(&skill_process_id), EIncorrectSkillType);
        let item_id = skill_type_item_id_pair::item_id(&item_creation_id);

        (player_id, skill_type, item_id)
    }

    public fun assert_ids_are_consistent_for_completing_creation(
        player_id: address, //player: &Player,
        item_creation: &ItemCreation,
        skill_process: &SkillProcess,
    ): (address, u8, u32) {
        let (_player_id, skill_type, item_id) = assert_ids_are_consistent_for_starting_creation(
            player_id, item_creation, skill_process
        );
        assert!(item_id == skill_process::item_id(skill_process), EIncorrectItemId);
        (player_id, skill_type, item_id)
    }


    public fun assert_ids_are_consistent_for_starting_production(
        player_id: address, //player: &Player,
        item_production: &ItemProduction,
        skill_process: &skill_process::SkillProcess,
    ): (address, u8, u32) {
        let skill_process_id = skill_process::skill_process_id(skill_process);
        let skill_process_id_player_id = infinite_seas_common::skill_process_id::player_id(&skill_process_id);
        assert!(skill_process_id_player_id == player_id, EInvalidPlayerId);

        let item_production_id = item_production::item_production_id(item_production);
        let skill_type = skill_type_item_id_pair::skill_type(&item_production_id);
        assert!(skill_type == skill_process_id::skill_type(&skill_process_id), EIncorrectSkillType);
        let item_id = skill_type_item_id_pair::item_id(&item_production_id);

        (player_id, skill_type, item_id)
    }

    public fun assert_ids_are_consistent_for_completing_production(
        player_id: address, //player: &Player,
        item_production: &ItemProduction,
        skill_process: &SkillProcess,
    ): (address, u8, u32) {
        let (_player_id, skill_type, item_id) = assert_ids_are_consistent_for_starting_production(
            player_id, item_production, skill_process
        );
        assert!(item_id == skill_process::item_id(skill_process), EIncorrectItemId);
        (player_id, skill_type, item_id)
    }
}
