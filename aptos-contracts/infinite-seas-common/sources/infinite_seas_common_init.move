// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas_common::infinite_seas_common_init {
    use infinite_seas_common::experience_table;
    use infinite_seas_common::item;
    use infinite_seas_common::item_creation;
    use infinite_seas_common::item_production;

    public entry fun initialize(store_account: &signer) {
        item::initialize(store_account);
        item_creation::initialize(store_account);
        item_production::initialize(store_account);
        experience_table::initialize(store_account);
    }

}
