module infinite_seas_player::player_update_logic {
    use std::option::{Self, Option};

    use infinite_seas_common::inventory_entry::InventoryEntry;

    use infinite_seas_player::player;
    use infinite_seas_player::player_properties;

    friend infinite_seas_player::player_aggregate;

    public(friend) fun verify(
        account: &signer,
        store_address: address,
        experience_gained: Option<u32>,
        new_level: Option<u16>,
        inventory_entries: vector<InventoryEntry>,
        id: address,
        player: &player::Player,
    ): player::PlayerUpdated {
        player::new_player_updated(
            id,
            player,
            experience_gained,
            new_level,
            inventory_entries,
        )
    }

    public(friend) fun mutate(
        _account: &signer,
        store_address: address,
        player_updated: &player::PlayerUpdated,
        id: address,
        player: player::Player,
    ): player::Player {
        let experience_gained = player::player_updated_experience_gained(player_updated);
        let new_level = player::player_updated_new_level(player_updated);
        let inventory_entries = player::player_updated_inventory_entries(player_updated);
        if (option::is_some(&experience_gained)) {
            let old_experience = player::experience(&player);
            player::set_experience(&mut player, old_experience + option::extract(&mut experience_gained));
        };
        if (option::is_some(&new_level)) {
            player::set_level(&mut player, option::extract(&mut new_level));
        };
        player_properties:: modify_inventory(&mut player, &inventory_entries);
        player
    }
}
