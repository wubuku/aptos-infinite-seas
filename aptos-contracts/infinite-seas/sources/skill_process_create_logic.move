module infinite_seas::skill_process_create_logic {
    use infinite_seas::skill_process;
    use infinite_seas_common::skill_process_id::SkillProcessId;

    friend infinite_seas::skill_process_aggregate;

    const EInvalidPlayerId: u64 = 10;
    const ESenderHasNoPermission: u64 = 22;
    const EInvalidSequenceNumber: u64 = 23;

    public(friend) fun verify(
        account: &signer,
        skill_process_id: SkillProcessId,
    ): skill_process::SkillProcessCreated {
        let _ = account;
        let player_id = infinite_seas_common::skill_process_id::player_id(&skill_process_id);
        assert!(aptos_framework::object::object_exists<infinite_seas::player::Player>(player_id), EInvalidPlayerId);
        let player_pass_obj = infinite_seas::player::get_player(player_id);
        let player = infinite_seas::pass_object::borrow(&player_pass_obj);
        assert!(std::signer::address_of(account) == infinite_seas::player::owner(player), ESenderHasNoPermission);
        infinite_seas::player::return_player(player_pass_obj);
        assert!(
            infinite_seas_common::skill_process_id::sequence_number(
                &skill_process_id
            ) <= infinite_seas::skill_process_util::skill_type_max_sequence_number(
                infinite_seas_common::skill_process_id::skill_type(&skill_process_id)
            ),
            EInvalidSequenceNumber
        );

        skill_process::new_skill_process_created(
            skill_process_id,
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        skill_process_created: &skill_process::SkillProcessCreated,
        id: address,
    ): skill_process::SkillProcess {
        let skill_process_id = skill_process::skill_process_created_skill_process_id(skill_process_created);
        skill_process::new_skill_process(
            skill_process_id,
        )
    }

}
