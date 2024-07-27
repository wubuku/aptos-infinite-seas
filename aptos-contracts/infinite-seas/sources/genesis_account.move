// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas::genesis_account {
    use aptos_framework::account;
    use aptos_framework::event;
    use infinite_seas::resource_account;
    use std::error;
    use std::signer;

    friend infinite_seas::player;
    friend infinite_seas::player_aggregate;
    friend infinite_seas::player_create_logic;
    friend infinite_seas::player_claim_island_logic;
    friend infinite_seas::player_airdrop_logic;
    friend infinite_seas::player_gather_island_resources_logic;
    friend infinite_seas::skill_process;
    friend infinite_seas::skill_process_aggregate;
    friend infinite_seas::skill_process_create_logic;
    friend infinite_seas::ship;
    friend infinite_seas::ship_aggregate;
    friend infinite_seas::ship_create_logic;
    friend infinite_seas::roster;
    friend infinite_seas::roster_aggregate;
    friend infinite_seas::roster_create_logic;
    friend infinite_seas::ship_battle;
    friend infinite_seas::ship_battle_aggregate;
    friend infinite_seas::ship_battle_initiate_battle_logic;

    const ENotGenesisAccount: u64 = 100;

    struct Events has key {
        resource_account_created_handle: event::EventHandle<ResourceAccountCreated>,
    }

    struct ResourceAccountCreated has store, drop {
        address: address,
    }

    public fun initialize(account: &signer) acquires Events {
        assert_genesis_account(account);

        move_to(account, Events {
            resource_account_created_handle: account::new_event_handle<ResourceAccountCreated>(account),
        });

        resource_account::initialize(account);

        let events = borrow_global_mut<Events>(signer::address_of(account));
        event::emit_event(&mut events.resource_account_created_handle, ResourceAccountCreated {
            address: resource_account_address(),
        });
    }

    public fun assert_genesis_account(account: &signer) {
        assert!(signer::address_of(account) == @infinite_seas, error::invalid_argument(ENotGenesisAccount));
    }

    public(friend) fun resource_account_signer(): signer {
        resource_account::resource_account_signer(@infinite_seas)
    }

    public fun resource_account_signer_for_genesis_account(account: &signer): signer {
        assert_genesis_account(account);
        resource_account_signer()
    }

    public fun resource_account_address(): address {
        let res_account = resource_account::resource_account_signer(@infinite_seas);
        signer::address_of(&res_account)
    }

}

