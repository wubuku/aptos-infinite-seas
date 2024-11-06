// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas::ship_aggregate {
    use aptos_framework::object::{Self, Object};
    use infinite_seas::ship::{Self, Ship};
    use infinite_seas::ship_create_logic;
    use infinite_seas_common::item_id_quantity_pairs::ItemIdQuantityPairs;
    use std::signer;

    friend infinite_seas::roster_create_environment_roster_logic;
    friend infinite_seas::skill_process_service;

    public(friend) fun create(
        account: &signer,
        owner: address,
        health_points: u32,
        attack: u32,
        protection: u32,
        speed: u32,
        building_expenses: ItemIdQuantityPairs,
    ): Object<ship::Ship> {
        let account_address = signer::address_of(account);
        let constructor_ref = object::create_object(account_address);
        let object_signer = object::generate_signer(&constructor_ref);
        let extend_ref = object::generate_extend_ref(&constructor_ref);
        let delete_ref = object::generate_delete_ref(&constructor_ref);
        let transfer_ref = object::generate_transfer_ref(&constructor_ref);
        object::disable_ungated_transfer(&transfer_ref);
        let id = object::address_from_constructor_ref(&constructor_ref);
        let ship_created = ship_create_logic::verify(
            account,
            owner,
            health_points,
            attack,
            protection,
            speed,
            building_expenses,
            id,
        );
        let ship = ship_create_logic::mutate(
            account,
            &ship_created,
            id,
        );
        ship::add_ship(&object_signer, ship);
        ship::save_object_controller(&object_signer,
            extend_ref,
            delete_ref,
            transfer_ref,
        );
        ship::set_ship_created_id(&mut ship_created, id);
        ship::emit_ship_created(ship_created);
        object::address_to_object(id)
    }

}
