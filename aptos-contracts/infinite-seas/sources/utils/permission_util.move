module infinite_seas::permission_util {

    use std::signer;
    use infinite_seas::player::{Self, Player};
    //use infinite_seas::roster::{Self, Roster};

    const ESenderIsNotPlayerOwner: u64 = 1;
    const EPlayerIsNotRosterOwner: u64 = 2;
    // const ELocationNotFound: u64 = 10;
    // const ELocationNotAnIsland: u64 = 11;
    // const EIslandNotOccupied: u64 = 12;
    // const EPlayerIsNotIslandOwner: u64 = 13;
    // const EPlayerClaimedNoIsland: u64 = 14;

    public fun assert_sender_is_player_owner(player: &Player, sender: &signer) {
        assert!(player::owner(player) == signer::address_of(sender), ESenderIsNotPlayerOwner);
    }

    // public fun assert_player_is_roster_owner(player: &Player, roster: &Roster) {
    //     let roster_id = roster::roster_id(roster);
    //     assert!(roster_id::player_id(&roster_id) == player::id(player), EPlayerIsNotRosterOwner);
    // }

    // public fun assert_player_is_island_owner(player: &Player, map: &Map) {
    //     let coordinates_o = player::claimed_island(player);
    //     assert!(option::is_some(&coordinates_o), EPlayerClaimedNoIsland);
    //     let coordinates = option::extract(&mut coordinates_o);
    //     assert!(map::locations_contains(map, coordinates), ELocationNotFound);
    //     let island = map::borrow_location(map, coordinates);
    //     assert!(map_location_type::island() == map_location::type(island), ELocationNotAnIsland);
    //     let occupied_by = map_location::occupied_by(island);
    //     assert!(option::is_some(&occupied_by), EIslandNotOccupied);
    //     assert!(option::extract(&mut occupied_by) == player::id(player), EPlayerIsNotIslandOwner);
    // }
}
