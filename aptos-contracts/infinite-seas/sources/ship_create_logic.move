module infinite_seas::ship_create_logic {
    use infinite_seas::ship;
    use infinite_seas_common::item_id_quantity_pairs::ItemIdQuantityPairs;

    friend infinite_seas::ship_aggregate;

    public(friend) fun verify(
        account: &signer,
        owner: address,
        health_points: u32,
        attack: u32,
        protection: u32,
        speed: u32,
        building_expenses: ItemIdQuantityPairs,
    ): ship::ShipCreated {
        let _ = account;
        ship::new_ship_created(
            owner,
            health_points,
            attack,
            protection,
            speed,
            building_expenses,
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        ship_created: &ship::ShipCreated,
        id: address,
    ): ship::Ship {
        let owner = ship::ship_created_owner(ship_created);
        let health_points = ship::ship_created_health_points(ship_created);
        let attack = ship::ship_created_attack(ship_created);
        let protection = ship::ship_created_protection(ship_created);
        let speed = ship::ship_created_speed(ship_created);
        let building_expenses = ship::ship_created_building_expenses(ship_created);
        ship::new_ship(
            owner,
            health_points,
            attack,
            protection,
            speed,
            building_expenses,
        )
    }

}
