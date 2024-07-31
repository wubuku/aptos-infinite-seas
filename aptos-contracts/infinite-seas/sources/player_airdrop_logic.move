module infinite_seas::player_airdrop_logic {
    use infinite_seas_common::item_id_quantity_pair;
    use infinite_seas_common::sorted_vector_util;
    use infinite_seas::player;

    friend infinite_seas::player_aggregate;

    public(friend) fun verify(
        account: &signer,
        item_id: u32,
        quantity: u32,
        id: address,
        player: &player::Player,
    ): player::PlayerAirdropped {
        player::new_player_airdropped(
            id,
            player,
            item_id,
            quantity,
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        player_airdropped: &player::PlayerAirdropped,
        id: address,
        player: player::Player,
    ): player::Player {
        let item_id = player::player_airdropped_item_id(player_airdropped);
        let quantity = player::player_airdropped_quantity(player_airdropped);
        let inv = player::borrow_mut_inventory(&mut player);
        sorted_vector_util::insert_or_add_item_id_quantity_pair(inv, item_id_quantity_pair::new(item_id, quantity));
        player
    }

}
