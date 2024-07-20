module infinite_seas::player_create_logic {
    use infinite_seas::player;
    use std::string::String;

    friend infinite_seas::player_aggregate;

    public(friend) fun verify(
        account: &signer,
        name: String,
    ): player::PlayerCreated {
        // ...
    }

    public(friend) fun mutate(
        _account: &signer,
        player_created: &player::PlayerCreated,
        id: address,
    ): player::Player {
        let name = player::player_created_name(player_created);
        // ...
        //
    }

}
