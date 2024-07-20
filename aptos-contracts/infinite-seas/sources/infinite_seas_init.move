// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas::infinite_seas_init {
    use infinite_seas::genesis_account;
    use infinite_seas::map;
    use infinite_seas::player;

    public entry fun initialize(account: &signer) {
        genesis_account::initialize(account);
        player::initialize(account);
        map::initialize(account);
        let store_account = genesis_account::resource_account_signer_for_genesis_account(account);
        infinite_seas_common::infinite_seas_common_init::initialize(&store_account);
    }

}
