module infinite_seas::player_claim_island_logic {
    use infinite_seas::player;
    use infinite_seas_common::coordinates::Coordinates;

    friend infinite_seas::player_aggregate;

    const ESenderHasNoPermission: u64 = 22;

    public(friend) fun verify(
        account: &signer,
        coordinates: Coordinates,
        id: address,
        player: &player::Player,
    ): player::IslandClaimed {
        assert!(sui::tx_context::sender(ctx) == player::owner(player), ESenderHasNoPermission);

    }

    public(friend) fun mutate(
        _account: &signer,
        island_claimed: &player::IslandClaimed,
        id: address,
        player: player::Player,
    ): player::Player {
        let coordinates = player::island_claimed_coordinates(island_claimed);
        let claimed_at = player::island_claimed_claimed_at(island_claimed);
        // ...
        //
    }

}
