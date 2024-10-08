// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas_common::item_creation_aggregate {
    use infinite_seas_common::item_creation;
    use infinite_seas_common::item_creation_create_logic;
    use infinite_seas_common::item_creation_update_logic;
    use infinite_seas_common::skill_type_item_id_pair::{Self, SkillTypeItemIdPair};

    const ENotPublisher: u64 = 50;

    public entry fun create(
        account: &signer,
        store_address: address,
        item_creation_id_skill_type: u8,
        item_creation_id_item_id: u32,
        resource_cost: u32,
        requirements_level: u16,
        base_quantity: u32,
        base_experience: u32,
        base_creation_time: u64,
        energy_cost: u64,
        success_rate: u16,
    ) {
        assert!(std::signer::address_of(account) == @infinite_seas_common, ENotPublisher);
        let item_creation_id: SkillTypeItemIdPair = skill_type_item_id_pair::new(
            item_creation_id_skill_type,
            item_creation_id_item_id,
        );

        let item_creation_created = item_creation_create_logic::verify(
            account,
            store_address,
            item_creation_id,
            resource_cost,
            requirements_level,
            base_quantity,
            base_experience,
            base_creation_time,
            energy_cost,
            success_rate,
        );
        let item_creation = item_creation_create_logic::mutate(
            account,
            store_address,
            &item_creation_created,
        );
        item_creation::add_item_creation(store_address, item_creation);
        item_creation::emit_item_creation_created(store_address, item_creation_created);
    }

    public entry fun update(
        account: &signer,
        store_address: address,
        item_creation_id_skill_type: u8,
        item_creation_id_item_id: u32,
        resource_cost: u32,
        requirements_level: u16,
        base_quantity: u32,
        base_experience: u32,
        base_creation_time: u64,
        energy_cost: u64,
        success_rate: u16,
    ) {
        assert!(std::signer::address_of(account) == @infinite_seas_common, ENotPublisher);
        let item_creation_id: SkillTypeItemIdPair = skill_type_item_id_pair::new(
            item_creation_id_skill_type,
            item_creation_id_item_id,
        );

        let item_creation = item_creation::remove_item_creation(store_address, item_creation_id);
        let item_creation_updated = item_creation_update_logic::verify(
            account,
            store_address,
            resource_cost,
            requirements_level,
            base_quantity,
            base_experience,
            base_creation_time,
            energy_cost,
            success_rate,
            &item_creation,
        );
        let updated_item_creation = item_creation_update_logic::mutate(
            account,
            store_address,
            &item_creation_updated,
            item_creation,
        );
        item_creation::update_version_and_add(store_address, updated_item_creation);
        item_creation::emit_item_creation_updated(store_address, item_creation_updated);
    }

}
