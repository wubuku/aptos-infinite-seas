// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas::roster_aggregate {
    use aptos_framework::object::{Self, Object};
    use infinite_seas::genesis_account;
    use infinite_seas::player::Player;
    use infinite_seas::roster::{Self, Roster};
    use infinite_seas::roster_add_ship_logic;
    use infinite_seas::roster_create_environment_roster_logic;
    use infinite_seas::roster_create_logic;
    use infinite_seas::roster_set_sail_logic;
    use infinite_seas::ship::Ship;
    use infinite_seas_common::coordinates::{Self, Coordinates};
    use infinite_seas_common::roster_id::{Self, RosterId};
    use std::option::{Self, Option};
    use std::vector;

    friend infinite_seas::player_create_logic;
    friend infinite_seas::player_claim_island_logic;
    friend infinite_seas::skill_process_complete_ship_production_logic;

    const EMismatchedObjectSeed: u64 = 150;

    const ENotPublisher: u64 = 50;

    public(friend) fun create(
        account: &signer,
        roster_id: RosterId,
        status: u8,
        speed: u32,
        updated_coordinates: Coordinates,
        coordinates_updated_at: u64,
        target_coordinates: Option<Coordinates>,
        origin_coordinates: Option<Coordinates>,
        ship_battle_id: Option<address>,
    ): Object<roster::Roster> {
        let roster_created = roster_create_logic::verify(
            account,
            roster_id,
            status,
            speed,
            updated_coordinates,
            coordinates_updated_at,
            target_coordinates,
            origin_coordinates,
            ship_battle_id,
        );
        let constructor_ref = object::create_named_object(&genesis_account::resource_account_signer(), std::bcs::to_bytes(&roster_id));
        let object_signer = object::generate_signer(&constructor_ref);
        let extend_ref = object::generate_extend_ref(&constructor_ref);
        let transfer_ref = object::generate_transfer_ref(&constructor_ref);
        object::disable_ungated_transfer(&transfer_ref);
        let id = object::address_from_constructor_ref(&constructor_ref);
        let roster = roster_create_logic::mutate(
            account,
            &mut roster_created,
            id,
        );
        assert!(roster_id == roster::roster_id(&roster), EMismatchedObjectSeed);
        roster::add_roster(&object_signer, roster);
        roster::save_object_controller(&object_signer,
            extend_ref,
            transfer_ref,
        );
        roster::set_roster_created_id(&mut roster_created, id);
        roster::emit_roster_created(roster_created);
        object::address_to_object(id)
    }

    public entry fun create_environment_roster(
        account: &signer,
        roster_id_player_id: address,
        roster_id_sequence_number: u32,
        coordinates_x: u32,
        coordinates_y: u32,
        ship_resource_quantity: u32,
        ship_base_resource_quantity: u32,
        base_experience: u32,
    ) {
        assert!(std::signer::address_of(account) == @infinite_seas, ENotPublisher);
        let roster_id: RosterId = roster_id::new(
            roster_id_player_id,
            roster_id_sequence_number,
        );
        let coordinates: Coordinates = coordinates::new(
            coordinates_x,
            coordinates_y,
        );
        let environment_roster_created = roster_create_environment_roster_logic::verify(
            account,
            roster_id,
            coordinates,
            ship_resource_quantity,
            ship_base_resource_quantity,
            base_experience,
        );
        let constructor_ref = object::create_named_object(&genesis_account::resource_account_signer(), std::bcs::to_bytes(&roster_id));
        let object_signer = object::generate_signer(&constructor_ref);
        let extend_ref = object::generate_extend_ref(&constructor_ref);
        let transfer_ref = object::generate_transfer_ref(&constructor_ref);
        object::disable_ungated_transfer(&transfer_ref);
        let id = object::address_from_constructor_ref(&constructor_ref);
        let roster = roster_create_environment_roster_logic::mutate(
            account,
            &environment_roster_created,
            id,
        );
        assert!(roster_id == roster::roster_id(&roster), EMismatchedObjectSeed);
        roster::add_roster(&object_signer, roster);
        roster::save_object_controller(&object_signer,
            extend_ref,
            transfer_ref,
        );
        roster::set_environment_roster_created_id(&mut environment_roster_created, id);
        roster::emit_environment_roster_created(environment_roster_created);
    }

    public(friend) fun add_ship(
        account: &signer,
        roster_obj: Object<Roster>,
        ship: Object<Ship>,
        position: Option<u64>,
    ) {
        let id = object::object_address(&roster_obj);
        let roster = roster::remove_roster(id);
        let roster_ship_added = roster_add_ship_logic::verify(
            account,
            ship,
            position,
            id,
            &roster,
        );
        let updated_roster = roster_add_ship_logic::mutate(
            account,
            &mut roster_ship_added,
            id,
            roster,
        );
        roster::update_version_and_add(id, updated_roster);
        roster::emit_roster_ship_added(roster_ship_added);
    }

    public entry fun set_sail(
        account: &signer,
        roster_obj: Object<Roster>,
        player: Object<Player>,
        target_coordinates_x: u32,
        target_coordinates_y: u32,
        sail_duration: u64,
        updated_coordinates_x: u32,
        updated_coordinates_y: u32,
    ) {
        let target_coordinates: Coordinates = coordinates::new(
            target_coordinates_x,
            target_coordinates_y,
        );
        let updated_coordinates: Coordinates = coordinates::new(
            updated_coordinates_x,
            updated_coordinates_y,
        );
        let id = object::object_address(&roster_obj);
        let roster = roster::remove_roster(id);
        let roster_set_sail = roster_set_sail_logic::verify(
            account,
            player,
            target_coordinates,
            sail_duration,
            updated_coordinates,
            id,
            &roster,
        );
        let updated_roster = roster_set_sail_logic::mutate(
            account,
            &roster_set_sail,
            id,
            roster,
        );
        roster::update_version_and_add(id, updated_roster);
        roster::emit_roster_set_sail(roster_set_sail);
    }

    fun vector_to_option<V : drop>(v: vector<V>): Option<V> {
        if (vector::length(&v) == 0) { option::none() } else {
            option::some(
                vector::pop_back(&mut v)
            )
        }
    }

}
