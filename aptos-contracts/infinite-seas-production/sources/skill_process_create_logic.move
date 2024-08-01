module infinite_seas_production::skill_process_create_logic {
    use infinite_seas_common::skill_process_id::SkillProcessId;
    use infinite_seas_production::skill_process;

    friend infinite_seas_production::skill_process_aggregate;

    const EInvalidPlayerId: u64 = 10;
    const ESenderHasNoPermission: u64 = 22;
    const EInvalidSequenceNumber: u64 = 23;

    public(friend) fun verify(
        account: &signer,
        store_account: &signer,
        skill_process_id: SkillProcessId,
    ): skill_process::SkillProcessCreated {
        let _ = account;
        // TODO: verification logic ...

        skill_process::new_skill_process_created(
            skill_process_id,
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        store_account: &signer,
        skill_process_created: &skill_process::SkillProcessCreated,
        id: address,
    ): skill_process::SkillProcess {
        let skill_process_id = skill_process::skill_process_created_skill_process_id(skill_process_created);
        skill_process::new_skill_process(
            skill_process_id,
        )
    }

}
