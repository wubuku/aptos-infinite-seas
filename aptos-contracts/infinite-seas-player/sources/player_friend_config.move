// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas_player::player_friend_config {
    use aptos_std::type_info;
    use std::signer;
    use std::string::String;
    use std::vector;
    const ENotInitialized: u64 = 100;
    const ENotAllowedCaller: u64 = 101;
    const ENotPublisher: u64 = 102;

    struct PlayerFriendConfig has key, store {
        caller_allowlist: vector<String>,
    }

    fun init_module(account: &signer) {
        assert!(std::signer::address_of(account) == @infinite_seas_player, ENotPublisher);
        let config = PlayerFriendConfig {
            caller_allowlist: vector::empty(),
        };
        move_to(account, config);
    }

    public entry fun add_allowed_caller<WT: drop>(account: &signer) acquires PlayerFriendConfig {
        assert!(std::signer::address_of(account) == @infinite_seas_player, ENotPublisher);
        let config = borrow_global_mut<PlayerFriendConfig>(signer::address_of(account));
        let type_name = type_info::type_name<WT>();
        if (!vector::contains(&config.caller_allowlist, &type_name)) {
            vector::push_back(&mut config.caller_allowlist, type_name);
        };
    }

    public entry fun remove_allowed_caller<WT: drop>(account: &signer) acquires PlayerFriendConfig {
        assert!(std::signer::address_of(account) == @infinite_seas_player, ENotPublisher); // NOTE: Is this ok?
        let config = borrow_global_mut<PlayerFriendConfig>(signer::address_of(account));
        let type_name = type_info::type_name<WT>();
        vector::remove_value(&mut config.caller_allowlist, &type_name);
    }

    public fun assert_allowlisted<WT: drop>(_friend_witness: WT) acquires PlayerFriendConfig {
        assert!(exists<PlayerFriendConfig>(@infinite_seas_player), ENotInitialized);
        let config = borrow_global<PlayerFriendConfig>(@infinite_seas_player);
        assert!(vector::contains(&config.caller_allowlist, &type_info::type_name<WT>()), ENotAllowedCaller);
    }

}
