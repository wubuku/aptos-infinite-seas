module infinite_seas_common::experience_table_update_level_logic {
    use infinite_seas_common::experience_level;
    use infinite_seas_common::experience_table;
    use std::vector;

    friend infinite_seas_common::experience_table_aggregate;

    const EInvalidLevel: u64 = 10;

    public(friend) fun verify(
        account: &signer,
        store_address: address,      
        level: u16,
        experience: u32,
        difference: u32,
    ): experience_table::ExperienceLevelUpdated {
        let levels = experience_table::singleton_levels(store_address);//borrow_levels(experience_table);
        assert!((level as u64) < vector::length(&levels), EInvalidLevel);
        //let o_xp_level = vector::borrow(levels, (level as u64));
        //assert!(experience_level::level(o_xp_level) == level, EInvalidInternalState); // ignore?
        experience_table::new_experience_level_updated(//experience_table, level, experience, difference)
            store_address, level, experience, difference
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        store_address: address,
        experience_level_updated: &experience_table::ExperienceLevelUpdated,
    ) {
        let level = experience_table::experience_level_updated_level(experience_level_updated);
        let experience = experience_table::experience_level_updated_experience(experience_level_updated);
        let difference = experience_table::experience_level_updated_difference(experience_level_updated);
        let xp_level = experience_level::new(level, experience, difference);
        let levels = experience_table::singleton_levels(store_address);//borrow_mut_levels(experience_table);
        vector::remove(&mut levels, (level as u64));
        vector::insert(&mut levels, (level as u64), xp_level);
        experience_table::set_singleton_levels(store_address, levels);
    }

}
