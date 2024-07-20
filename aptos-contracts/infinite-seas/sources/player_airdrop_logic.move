module infinite_seas::player_airdrop_logic {
    use infinite_seas::player;

    friend infinite_seas::player_aggregate;

    public(friend) fun verify(
        account: &signer,
        item_id: u32,
        quantity: u32,
        id: address,
        player: &player::Player,
    ): player::PlayerAirdropped {
        // ...
        //
    }

    public(friend) fun mutate(
        _account: &signer,
        player_airdropped: &player::PlayerAirdropped,
        id: address,
        player: player::Player,
    ): player::Player {
        let item_id = player::player_airdropped_item_id(player_airdropped);
        let quantity = player::player_airdropped_quantity(player_airdropped);
        // ...
        //
    }

}
