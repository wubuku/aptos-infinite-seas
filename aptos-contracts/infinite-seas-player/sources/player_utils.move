module infinite_seas_player::player_utils {

    use infinite_seas_common::skill_type;

    public fun skill_type_max_sequence_number(skill_type: u8): u8 {
        if (skill_type == skill_type::farming()) {
            1
        } else {
            0
        }
    }
}
