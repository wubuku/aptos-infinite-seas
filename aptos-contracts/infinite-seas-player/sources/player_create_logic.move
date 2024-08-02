module infinite_seas_player::player_create_logic {
    use std::signer;
    use std::vector;
    use infinite_seas_player::player;
    use std::string::String;

    friend infinite_seas_player::player_aggregate;

    public(friend) fun verify(
        account: &signer,
        store_account: &signer,
        name: String,
    ): player::PlayerCreated {
        let owner = signer::address_of(account);
        player::new_player_created(
            name,
            owner,
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        store_account: &signer,
        player_created: &player::PlayerCreated,
        id: address,
    ): player::Player {
        let owner = signer::address_of(_account);
        let name = player::player_created_name(player_created);
        player::new_player(owner, name, vector::empty(),)
    }

}
