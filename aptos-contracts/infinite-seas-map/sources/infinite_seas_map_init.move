// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas_map::infinite_seas_map_init {
    use infinite_seas_map::map;

    public entry fun initialize(store_account: &signer) {
        map::initialize(store_account);
    }

}
