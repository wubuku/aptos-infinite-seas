module infinite_seas::roster_add_ship_logic {
    use std::option::Option;
    use aptos_framework::object::{Self, Object};

    use infinite_seas::genesis_account;
    use infinite_seas::roster;
    use infinite_seas::roster::Roster;
    use infinite_seas::roster_util;
    use infinite_seas::ship::Ship;

    friend infinite_seas::roster_aggregate;

    public(friend) fun verify(
        account: &signer,
        ship: Object<Ship>,
        position: Option<u64>,
        id: address,
        roster: &roster::Roster,
    ): roster::RosterShipAdded {
        roster::new_roster_ship_added(id, roster, ship, position)
    }

    public(friend) fun mutate(
        _account: &signer,
        roster_ship_added: &roster::RosterShipAdded,
        id: address,
        roster: roster::Roster,
    ): roster::Roster {
        let position = roster::roster_ship_added_position(roster_ship_added);

        let ship_ids = roster::borrow_mut_ship_ids(&mut roster);
        let ship_obj = roster::roster_ship_added_ship(roster_ship_added);// ship::id(&ship);
        roster_util::add_ship_id(ship_ids, object::object_address(&ship_obj), position);

        //
        // Transfer the ship ownership to the roster
        //
        let roster_obj = object::address_to_object<Roster>(id);
        //TODO object::transfer_to_object(&genesis_account::resource_account_signer(), ship_obj, roster_obj);
        // let ships = roster::borrow_mut_ships(roster);
        // object_table::add(ships, ship_id, ship);

        let speed = roster_util::calculate_roster_speed(&roster);
        roster::set_speed(&mut roster, speed);

        roster
    }
}
