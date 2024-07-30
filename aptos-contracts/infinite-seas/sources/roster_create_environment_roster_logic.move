module infinite_seas::roster_create_environment_roster_logic {
    use std::bcs;
    use std::option;
    use std::vector;
    use aptos_framework::object;

    use infinite_seas_common::coordinates::Coordinates;
    use infinite_seas_common::item_id;
    use infinite_seas_common::item_id_quantity_pairs;
    use infinite_seas_common::roster_id;
    use infinite_seas_common::roster_id::RosterId;
    use infinite_seas_common::roster_status;
    use infinite_seas_common::ship_util;
    use infinite_seas_common::ts_random_util;

    use infinite_seas::genesis_account;
    use infinite_seas::roster;
    use infinite_seas::roster::Roster;
    use infinite_seas::roster_util;
    use infinite_seas::ship::Ship;
    use infinite_seas::ship_aggregate;

    friend infinite_seas::roster_aggregate;

    const EInvalidShipResourceQuantity: u64 = 1;
    const EInvalidShipBaseResourceQuantity: u64 = 2;

    const DEFAULT_NUMBER_OF_SHIPS: u32 = 4;

    public(friend) fun verify(
        account: &signer,
        roster_id: RosterId,
        coordinates: Coordinates,
        ship_resource_quantity: u32,
        ship_base_resource_quantity: u32,
        base_experience: u32,
    ): roster::EnvironmentRosterCreated {
        assert!(ship_resource_quantity >= ship_base_resource_quantity * 3, EInvalidShipResourceQuantity);
        assert!(ship_base_resource_quantity > 0, EInvalidShipBaseResourceQuantity);
        //roster::asset_roster_id_not_exists(roster_id, roster_table);
        roster::new_environment_roster_created(
            roster_id, coordinates, ship_resource_quantity, ship_base_resource_quantity, base_experience
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        environment_roster_created: &roster::EnvironmentRosterCreated,
        id: address,
    ): roster::Roster {
        let coordinates = roster::environment_roster_created_coordinates(environment_roster_created);
        let ship_resource_quantity = roster::environment_roster_created_ship_resource_quantity(
            environment_roster_created
        );
        let ship_base_resource_quantity = roster::environment_roster_created_ship_base_resource_quantity(
            environment_roster_created
        );
        let base_experience = roster::environment_roster_created_base_experience(environment_roster_created);

        let roster_id = roster::environment_roster_created_roster_id(environment_roster_created);
        let coordinates = roster::environment_roster_created_coordinates(environment_roster_created);
        let ship_resource_quantity = roster::environment_roster_created_ship_resource_quantity(
            environment_roster_created
        );
        let ship_base_resource_quantity = roster::environment_roster_created_ship_base_resource_quantity(
            environment_roster_created
        );
        let base_experience = roster::environment_roster_created_base_experience(environment_roster_created);

        let status = roster_status::at_anchor();
        let total_roster_speed = 0;
        //let roster = roster::create_roster(roster_id, status, total_roster_speed, sui::object_table::new(ctx),
        let roster = roster::new_roster(roster_id, status, total_roster_speed,
            coordinates,
            0, //coordinates_updated_at,
            option::none(), //target_coordinates,
            option::none(),
            option::none(), //ship_battle_id,
        );
        roster::set_base_experience(&mut roster, option::some(base_experience));

        let position = 0;
        let number_of_ships = DEFAULT_NUMBER_OF_SHIPS;
        while (position < number_of_ships) {
            // only one ship for now!
            let player_id = roster_id::player_id(&roster_id);

            let building_expenses_item_ids = vector[item_id::copper_ore(), item_id::normal_logs(), item_id::cottons()];
            // distribute random resources based on ship_resource_quantity
            let current_resource_quantity = ship_resource_quantity;// / number_of_ships;
            // if (position == number_of_ships - 1) {
            //     current_resource_quantity = current_resource_quantity + (ship_resource_quantity % number_of_ships);
            // };
            let rand_seed = bcs::to_bytes(&id); //object::id_to_bytes(&roster::id(&roster));
            vector::append(&mut rand_seed, bcs::to_bytes(&position));
            let random_resource_quantities = ts_random_util::divide_int(
                //clock,
                rand_seed,
                ((current_resource_quantity - ship_base_resource_quantity * 3) as u64),
                3
            );
            let building_expenses_item_quantities = vector[
                ship_base_resource_quantity + (*vector::borrow(&random_resource_quantities, 0) as u32),
                ship_base_resource_quantity + (*vector::borrow(&random_resource_quantities, 1) as u32),
                ship_base_resource_quantity + (*vector::borrow(&random_resource_quantities, 2) as u32),
            ];
            let building_expenses = item_id_quantity_pairs::new(
                building_expenses_item_ids,
                building_expenses_item_quantities
            );
            let (health_points, attack, protection, ship_speed) = ship_util::calculate_ship_attributes(
                &item_id_quantity_pairs::items(&building_expenses)
            );
            let ship = ship_aggregate::create(_account,
                player_id, health_points, attack, protection, ship_speed,
                building_expenses, //ctx,
            );

            let ship_id = object::object_address(&ship);//ship::id(&ship);
            let ship_ids = roster::borrow_mut_ship_ids(&mut roster);
            roster_util::add_ship_id(ship_ids, ship_id, option::some((position as u64)));

            let ship_obj = object::address_to_object<Ship>(ship_id);
            //
            // Transfer the ship ownership to the roster
            //
            let roster_obj = object::address_to_object<Roster>(id);
            //TODO object::transfer_to_object(&genesis_account::resource_account_signer(), ship_obj, roster_obj);
            // let ships = roster::borrow_mut_ships(&mut roster);
            // object_table::add(ships, ship_id, ship);

            total_roster_speed = total_roster_speed + ship_speed;

            position = position + 1;
        };

        let roster_speed = total_roster_speed / number_of_ships;
        roster::set_speed(&mut roster, roster_speed);
        roster::set_environment_owned(&mut roster, true);
        roster::set_base_experience(&mut roster, option::some(base_experience));

        roster
    }
}
