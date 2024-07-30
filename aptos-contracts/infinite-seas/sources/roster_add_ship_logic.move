module infinite_seas::roster_add_ship_logic {
    use std::option::Option;
    use aptos_framework::object::{Self, Object};

    use infinite_seas::roster;
    use infinite_seas::roster_util;
    use infinite_seas::ship;
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
        let ship_id = object::object_address(&ship_obj);
        roster_util::add_ship_id(ship_ids, ship_id, position);

        //
        // Transfer the ship ownership to the roster
        //
        ship::transfer_ship(ship_id, id);
        // let ships = roster::borrow_mut_ships(roster);
        // object_table::add(ships, ship_id, ship);

        let speed = roster_util::calculate_roster_speed(&roster);
        roster::set_speed(&mut roster, speed);

        roster
    }
}
