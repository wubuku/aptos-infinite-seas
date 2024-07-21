module infinite_seas_common::experience_table_add_level_logic {
    use infinite_seas_common::experience_level;
    use infinite_seas_common::experience_table;
    use std::vector;

    friend infinite_seas_common::experience_table_aggregate;

    const ELevelNotEqualToIndex: u64 = 10;

    public(friend) fun verify(
        account: &signer,
        store_address: address,      
        level: u16,
        experience: u32,
        difference: u32,
    ): experience_table::ExperienceLevelAdded {
        assert!((level as u64) == experience_table::singleton_levels_length(store_address), ELevelNotEqualToIndex);
        experience_table::new_experience_level_added(
            store_address, level, experience, difference
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        store_address: address,
        experience_level_added: &experience_table::ExperienceLevelAdded,
    ) {
        let level = experience_table::experience_level_added_level(experience_level_added);
        let experience = experience_table::experience_level_added_experience(experience_level_added);
        let difference = experience_table::experience_level_added_difference(experience_level_added);

        let xp_level = experience_level::new(level, experience, difference);
        //let levels = experience_table::singleton_levels(store_address);
        //vector::push_back(&mut levels, xp_level);
        //experience_table::set_singleton_levels(store_address, levels);
        experience_table::singleton_levels_push_back(store_address, xp_level);
    }

}
