// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

#[allow(unused_mut_parameter, unused_use)]
module infinite_seas_player::player_aggregate {
    use aptos_framework::object::{Self, Object};
    use infinite_seas_common::coordinates::Coordinates;
    use infinite_seas_player::player::{Self, Player};
    use infinite_seas_player::player_airdrop_logic;
    use infinite_seas_player::player_claim_island_logic;
    use infinite_seas_player::player_create_logic;
    use infinite_seas_player::player_friend_config;
    use infinite_seas_player::player_gather_island_resources_logic;
    use std::signer;
    use std::string::String;

    const EMismatchedObjectSeed: u64 = 150;

    const ENotPublisher: u64 = 50;

    public fun create<FWT: drop>(
        _friend_witness: FWT,
        account: &signer,
        store_account: &signer,
        name: String,
    ) {
        player_friend_config::assert_allowlisted(_friend_witness);
        let player_created = player_create_logic::verify(
            account,
            store_account,
            name,
        );
        let owner = player::player_created_owner(&player_created);
        let constructor_ref = object::create_named_object(store_account, std::bcs::to_bytes(&owner));
        let object_signer = object::generate_signer(&constructor_ref);
        let extend_ref = object::generate_extend_ref(&constructor_ref);
        let id = object::address_from_constructor_ref(&constructor_ref);
        let player = player_create_logic::mutate(
            account,
            store_account,
            &player_created,
            id,
        );
        assert!(owner == player::owner(&player), EMismatchedObjectSeed);
        player::add_player(&object_signer, player);
        player::save_object_controller(&object_signer,
            extend_ref,
        );
        player::set_player_created_id(&mut player_created, id);
        player::emit_player_created(signer::address_of(store_account), player_created);
    }

    public fun claim_island<FWT: drop>(
        _friend_witness: FWT,
        account: &signer,
        store_account: &signer,
        player_obj: Object<Player>,
        coordinates: Coordinates,
    ) {
        player_friend_config::assert_allowlisted(_friend_witness);
        let store_address = std::signer::address_of(store_account);
        let id = object::object_address(&player_obj);
        let player = player::remove_player(id);
        let island_claimed = player_claim_island_logic::verify(
            account,
            store_account,
            coordinates,
            id,
            &player,
        );
        let updated_player = player_claim_island_logic::mutate(
            account,
            store_account,
            &island_claimed,
            id,
            player,
        );
        player::update_version_and_add(id, updated_player);
        player::emit_island_claimed(store_address, island_claimed);
    }

    public entry fun airdrop(
        account: &signer,
        player_obj: Object<Player>,
        item_id: u32,
        quantity: u32,
    ) {
        assert!(std::signer::address_of(account) == @infinite_seas_player, ENotPublisher);
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
        // TODO: player::emit_player_airdropped(store_address, player_airdropped);
    }

    public fun gather_island_resources<FWT: drop>(
        _friend_witness: FWT,
        account: &signer,
        store_address: address,
        player_obj: Object<Player>,
    ) {
        player_friend_config::assert_allowlisted(_friend_witness);
        let id = object::object_address(&player_obj);
        let player = player::remove_player(id);
        let player_island_resources_gathered = player_gather_island_resources_logic::verify(
            account,
            store_address,
            id,
            &player,
        );
        let updated_player = player_gather_island_resources_logic::mutate(
            account,
            store_address,
            &player_island_resources_gathered,
            id,
            player,
        );
        player::update_version_and_add(id, updated_player);
        player::emit_player_island_resources_gathered(store_address, player_island_resources_gathered);
    }

}
