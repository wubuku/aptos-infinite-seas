// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

#[allow(unused_mut_parameter, unused_use)]
module infinite_seas::player_aggregate {
    use aptos_framework::object::{Self, Object};
    use infinite_seas::genesis_account;
    use infinite_seas::player::{Self, Player};
    use infinite_seas::player_airdrop_logic;
    use infinite_seas::player_claim_island_logic;
    use infinite_seas::player_create_logic;
    use infinite_seas_common::coordinates::{Self, Coordinates};
    use std::string::String;

    const EMismatchedObjectSeed: u64 = 150;

    const ENotPublisher: u64 = 50;

    public entry fun create(
        account: &signer,
        name: String,
    ) {
        let player_created = player_create_logic::verify(
            account,
            name,
        );
        //TODO: This is a temporary solution to get the owner address
        let owner = std::signer::address_of(account);
        let constructor_ref = object::create_named_object(&genesis_account::resource_account_signer(), std::bcs::to_bytes(&owner));
        let object_signer = object::generate_signer(&constructor_ref);
        let extend_ref = object::generate_extend_ref(&constructor_ref);
        let transfer_ref = object::generate_transfer_ref(&constructor_ref);
        object::disable_ungated_transfer(&transfer_ref);
        let id = object::address_from_constructor_ref(&constructor_ref);
        let player = player_create_logic::mutate(
            account,
            &player_created,
            id,
        );
        assert!(owner == player::owner(&player), EMismatchedObjectSeed);
        player::add_player(&object_signer, player);
        player::save_object_controller(&object_signer,
            extend_ref,
            transfer_ref,
        );
        player::set_player_created_id(&mut player_created, id);
        player::emit_player_created(player_created);
    }

    public entry fun claim_island(
        account: &signer,
        player_obj: Object<Player>,
        coordinates_x: u32,
        coordinates_y: u32,
    ) {
        let coordinates: Coordinates = coordinates::new(
            coordinates_x,
            coordinates_y,
        );
        let id = object::object_address(&player_obj);
        let player = player::remove_player(id);
        let island_claimed = player_claim_island_logic::verify(
            account,
            coordinates,
            id,
            &player,
        );
        let updated_player = player_claim_island_logic::mutate(
            account,
            &island_claimed,
            id,
            player,
        );
        player::update_version_and_add(id, updated_player);
        player::emit_island_claimed(island_claimed);
    }

    public entry fun airdrop(
        account: &signer,
        player_obj: Object<Player>,
        item_id: u32,
        quantity: u32,
    ) {
        assert!(std::signer::address_of(account) == @infinite_seas, ENotPublisher);
        let id = object::object_address(&player_obj);
        let player = player::remove_player(id);
        let player_airdropped = player_airdrop_logic::verify(
            account,
            item_id,
            quantity,
            id,
            &player,
        );
        let updated_player = player_airdrop_logic::mutate(
            account,
            &player_airdropped,
            id,
            player,
        );
        player::update_version_and_add(id, updated_player);
        player::emit_player_airdropped(player_airdropped);
    }

}
