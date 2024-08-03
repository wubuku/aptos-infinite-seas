module infinite_seas_player::player_util {

    use std::signer;

    use infinite_seas_common::skill_type;

    use infinite_seas_player::player;
    use infinite_seas_player::player::Player;

    const ESenderIsNotPlayerOwner: u64 = 1;

    public fun assert_sender_is_player_owner(player: &Player, sender: &signer) {
        assert!(player::owner(player) == signer::address_of(sender), ESenderIsNotPlayerOwner);
    }

    public fun skill_type_max_sequence_number(skill_type: u8): u8 {
        if (skill_type == skill_type::farming()) {
            1
        } else {
            0
        }
    }
}
