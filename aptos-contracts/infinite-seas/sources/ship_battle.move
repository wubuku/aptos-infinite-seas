// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas::ship_battle {
    use aptos_framework::account;
    use aptos_framework::event;
    use aptos_framework::object;
    use infinite_seas::genesis_account;
    use infinite_seas::pass_object;
    use infinite_seas_common::coordinates::Coordinates;
    use infinite_seas_common::item_id_quantity_pair::ItemIdQuantityPair;
    use std::option::{Self, Option};
    friend infinite_seas::ship_battle_initiate_battle_logic;
    friend infinite_seas::ship_battle_make_move_logic;
    friend infinite_seas::ship_battle_take_loot_logic;
    friend infinite_seas::ship_battle_aggregate;

    const EDataTooLong: u64 = 102;
    const EInappropriateVersion: u64 = 103;
    const ENotInitialized: u64 = 110;

    struct Events has key {
        ship_battle_initiated_handle: event::EventHandle<ShipBattleInitiated>,
        ship_battle_move_made_handle: event::EventHandle<ShipBattleMoveMade>,
        ship_battle_loot_taken_handle: event::EventHandle<ShipBattleLootTaken>,
    }

    public fun initialize(account: &signer) {
        genesis_account::assert_genesis_account(account);

        let res_account = genesis_account::resource_account_signer();
        move_to(&res_account, Events {
            ship_battle_initiated_handle: account::new_event_handle<ShipBattleInitiated>(&res_account),
            ship_battle_move_made_handle: account::new_event_handle<ShipBattleMoveMade>(&res_account),
            ship_battle_loot_taken_handle: account::new_event_handle<ShipBattleLootTaken>(&res_account),
        });

    }

    #[resource_group_member(group = aptos_framework::object::ObjectGroup)]
    struct ShipBattle has key {
        version: u64,
        initiator: address,
        responder: address,
        status: u8,
        initiator_experiences: vector<u32>,
        responder_experiences: vector<u32>,
        ended_at: Option<u64>,
        winner: Option<u8>,
        round_number: u32,
        round_started_at: u64,
        round_mover: Option<u8>,
        round_attacker_ship: Option<address>,
        round_defender_ship: Option<address>,
    }

    #[resource_group_member(group = aptos_framework::object::ObjectGroup)]
    struct ObjectController has key {
        extend_ref: object::ExtendRef,
        delete_ref: object::DeleteRef,
    }


    public(friend) fun save_object_controller(
        object_signer: &signer,
        extend_ref: object::ExtendRef,
        delete_ref: object::DeleteRef,
    ) {
        move_to(
            object_signer,
            ObjectController {
                extend_ref,
                delete_ref,
            }
        )
    }

    public fun version(ship_battle: &ShipBattle): u64 {
        ship_battle.version
    }

    public fun initiator(ship_battle: &ShipBattle): address {
        ship_battle.initiator
    }

    public(friend) fun set_initiator(ship_battle: &mut ShipBattle, initiator: address) {
        ship_battle.initiator = initiator;
    }

    public fun responder(ship_battle: &ShipBattle): address {
        ship_battle.responder
    }

    public(friend) fun set_responder(ship_battle: &mut ShipBattle, responder: address) {
        ship_battle.responder = responder;
    }

    public fun status(ship_battle: &ShipBattle): u8 {
        ship_battle.status
    }

    public(friend) fun set_status(ship_battle: &mut ShipBattle, status: u8) {
        ship_battle.status = status;
    }

    public fun borrow_initiator_experiences(ship_battle: &ShipBattle): &vector<u32> {
        &ship_battle.initiator_experiences
    }

    public(friend) fun borrow_mut_initiator_experiences(ship_battle: &mut ShipBattle): &mut vector<u32> {
        &mut ship_battle.initiator_experiences
    }

    public fun initiator_experiences(ship_battle: &ShipBattle): vector<u32> {
        ship_battle.initiator_experiences
    }

    public(friend) fun set_initiator_experiences(ship_battle: &mut ShipBattle, initiator_experiences: vector<u32>) {
        ship_battle.initiator_experiences = initiator_experiences;
    }

    public fun borrow_responder_experiences(ship_battle: &ShipBattle): &vector<u32> {
        &ship_battle.responder_experiences
    }

    public(friend) fun borrow_mut_responder_experiences(ship_battle: &mut ShipBattle): &mut vector<u32> {
        &mut ship_battle.responder_experiences
    }

    public fun responder_experiences(ship_battle: &ShipBattle): vector<u32> {
        ship_battle.responder_experiences
    }

    public(friend) fun set_responder_experiences(ship_battle: &mut ShipBattle, responder_experiences: vector<u32>) {
        ship_battle.responder_experiences = responder_experiences;
    }

    public fun ended_at(ship_battle: &ShipBattle): Option<u64> {
        ship_battle.ended_at
    }

    public(friend) fun set_ended_at(ship_battle: &mut ShipBattle, ended_at: Option<u64>) {
        ship_battle.ended_at = ended_at;
    }

    public fun winner(ship_battle: &ShipBattle): Option<u8> {
        ship_battle.winner
    }

    public(friend) fun set_winner(ship_battle: &mut ShipBattle, winner: Option<u8>) {
        ship_battle.winner = winner;
    }

    public fun round_number(ship_battle: &ShipBattle): u32 {
        ship_battle.round_number
    }

    public(friend) fun set_round_number(ship_battle: &mut ShipBattle, round_number: u32) {
        ship_battle.round_number = round_number;
    }

    public fun round_started_at(ship_battle: &ShipBattle): u64 {
        ship_battle.round_started_at
    }

    public(friend) fun set_round_started_at(ship_battle: &mut ShipBattle, round_started_at: u64) {
        ship_battle.round_started_at = round_started_at;
    }

    public fun round_mover(ship_battle: &ShipBattle): Option<u8> {
        ship_battle.round_mover
    }

    public(friend) fun set_round_mover(ship_battle: &mut ShipBattle, round_mover: Option<u8>) {
        ship_battle.round_mover = round_mover;
    }

    public fun round_attacker_ship(ship_battle: &ShipBattle): Option<address> {
        ship_battle.round_attacker_ship
    }

    public(friend) fun set_round_attacker_ship(ship_battle: &mut ShipBattle, round_attacker_ship: Option<address>) {
        ship_battle.round_attacker_ship = round_attacker_ship;
    }

    public fun round_defender_ship(ship_battle: &ShipBattle): Option<address> {
        ship_battle.round_defender_ship
    }

    public(friend) fun set_round_defender_ship(ship_battle: &mut ShipBattle, round_defender_ship: Option<address>) {
        ship_battle.round_defender_ship = round_defender_ship;
    }

    public(friend) fun new_ship_battle(
        initiator: address,
        responder: address,
        status: u8,
        round_started_at: u64,
        round_mover: Option<u8>,
        round_attacker_ship: Option<address>,
        round_defender_ship: Option<address>,
    ): ShipBattle {
        ShipBattle {
            version: 0,
            initiator,
            responder,
            status,
            initiator_experiences: std::vector::empty(),
            responder_experiences: std::vector::empty(),
            ended_at: std::option::none(),
            winner: std::option::none(),
            round_number: 1,
            round_started_at,
            round_mover,
            round_attacker_ship,
            round_defender_ship,
        }
    }

    struct ShipBattleInitiated has store, drop {
        id: option::Option<address>,
        player_id: address,
        initiator_id: address,
        responder_id: address,
        initiator_coordinates: Coordinates,
        responder_coordinates: Coordinates,
        started_at: u64,
        first_round_mover: Option<u8>,
        first_round_attacker_ship: Option<address>,
        first_round_defender_ship: Option<address>,
    }

    public fun ship_battle_initiated_id(ship_battle_initiated: &ShipBattleInitiated): option::Option<address> {
        ship_battle_initiated.id
    }

    public(friend) fun set_ship_battle_initiated_id(ship_battle_initiated: &mut ShipBattleInitiated, id: address) {
        ship_battle_initiated.id = option::some(id);
    }

    public fun ship_battle_initiated_player_id(ship_battle_initiated: &ShipBattleInitiated): address {
        ship_battle_initiated.player_id
    }

    public fun ship_battle_initiated_initiator_id(ship_battle_initiated: &ShipBattleInitiated): address {
        ship_battle_initiated.initiator_id
    }

    public fun ship_battle_initiated_responder_id(ship_battle_initiated: &ShipBattleInitiated): address {
        ship_battle_initiated.responder_id
    }

    public fun ship_battle_initiated_initiator_coordinates(ship_battle_initiated: &ShipBattleInitiated): Coordinates {
        ship_battle_initiated.initiator_coordinates
    }

    public fun ship_battle_initiated_responder_coordinates(ship_battle_initiated: &ShipBattleInitiated): Coordinates {
        ship_battle_initiated.responder_coordinates
    }

    public fun ship_battle_initiated_started_at(ship_battle_initiated: &ShipBattleInitiated): u64 {
        ship_battle_initiated.started_at
    }

    public fun ship_battle_initiated_first_round_mover(ship_battle_initiated: &ShipBattleInitiated): Option<u8> {
        ship_battle_initiated.first_round_mover
    }

    public(friend) fun set_ship_battle_initiated_first_round_mover(ship_battle_initiated: &mut ShipBattleInitiated, first_round_mover: Option<u8>) {
        ship_battle_initiated.first_round_mover = first_round_mover;
    }

    public fun ship_battle_initiated_first_round_attacker_ship(ship_battle_initiated: &ShipBattleInitiated): Option<address> {
        ship_battle_initiated.first_round_attacker_ship
    }

    public(friend) fun set_ship_battle_initiated_first_round_attacker_ship(ship_battle_initiated: &mut ShipBattleInitiated, first_round_attacker_ship: Option<address>) {
        ship_battle_initiated.first_round_attacker_ship = first_round_attacker_ship;
    }

    public fun ship_battle_initiated_first_round_defender_ship(ship_battle_initiated: &ShipBattleInitiated): Option<address> {
        ship_battle_initiated.first_round_defender_ship
    }

    public(friend) fun set_ship_battle_initiated_first_round_defender_ship(ship_battle_initiated: &mut ShipBattleInitiated, first_round_defender_ship: Option<address>) {
        ship_battle_initiated.first_round_defender_ship = first_round_defender_ship;
    }

    public(friend) fun new_ship_battle_initiated(
        player_id: address,
        initiator_id: address,
        responder_id: address,
        initiator_coordinates: Coordinates,
        responder_coordinates: Coordinates,
        started_at: u64,
        first_round_mover: Option<u8>,
        first_round_attacker_ship: Option<address>,
        first_round_defender_ship: Option<address>,
    ): ShipBattleInitiated {
        ShipBattleInitiated {
            id: option::none(),
            player_id,
            initiator_id,
            responder_id,
            initiator_coordinates,
            responder_coordinates,
            started_at,
            first_round_mover,
            first_round_attacker_ship,
            first_round_defender_ship,
        }
    }

    struct ShipBattleMoveMade has store, drop {
        id: address,
        version: u64,
        player_id: address,
        initiator_id: address,
        responder_id: address,
        attacker_command: u8,
        defender_command: u8,
        round_number: u32,
        defender_damage_taken: u32,
        attacker_damage_taken: u32,
        is_battle_ended: bool,
        winner: Option<u8>,
        next_round_started_at: u64,
        next_round_mover: Option<u8>,
        next_round_attacker_ship: Option<address>,
        next_round_defender_ship: Option<address>,
    }

    public fun ship_battle_move_made_id(ship_battle_move_made: &ShipBattleMoveMade): address {
        ship_battle_move_made.id
    }

    public fun ship_battle_move_made_player_id(ship_battle_move_made: &ShipBattleMoveMade): address {
        ship_battle_move_made.player_id
    }

    public fun ship_battle_move_made_initiator_id(ship_battle_move_made: &ShipBattleMoveMade): address {
        ship_battle_move_made.initiator_id
    }

    public fun ship_battle_move_made_responder_id(ship_battle_move_made: &ShipBattleMoveMade): address {
        ship_battle_move_made.responder_id
    }

    public fun ship_battle_move_made_attacker_command(ship_battle_move_made: &ShipBattleMoveMade): u8 {
        ship_battle_move_made.attacker_command
    }

    public fun ship_battle_move_made_defender_command(ship_battle_move_made: &ShipBattleMoveMade): u8 {
        ship_battle_move_made.defender_command
    }

    public fun ship_battle_move_made_round_number(ship_battle_move_made: &ShipBattleMoveMade): u32 {
        ship_battle_move_made.round_number
    }

    public fun ship_battle_move_made_defender_damage_taken(ship_battle_move_made: &ShipBattleMoveMade): u32 {
        ship_battle_move_made.defender_damage_taken
    }

    public fun ship_battle_move_made_attacker_damage_taken(ship_battle_move_made: &ShipBattleMoveMade): u32 {
        ship_battle_move_made.attacker_damage_taken
    }

    public fun ship_battle_move_made_is_battle_ended(ship_battle_move_made: &ShipBattleMoveMade): bool {
        ship_battle_move_made.is_battle_ended
    }

    public fun ship_battle_move_made_winner(ship_battle_move_made: &ShipBattleMoveMade): Option<u8> {
        ship_battle_move_made.winner
    }

    public(friend) fun set_ship_battle_move_made_winner(ship_battle_move_made: &mut ShipBattleMoveMade, winner: Option<u8>) {
        ship_battle_move_made.winner = winner;
    }

    public fun ship_battle_move_made_next_round_started_at(ship_battle_move_made: &ShipBattleMoveMade): u64 {
        ship_battle_move_made.next_round_started_at
    }

    public fun ship_battle_move_made_next_round_mover(ship_battle_move_made: &ShipBattleMoveMade): Option<u8> {
        ship_battle_move_made.next_round_mover
    }

    public(friend) fun set_ship_battle_move_made_next_round_mover(ship_battle_move_made: &mut ShipBattleMoveMade, next_round_mover: Option<u8>) {
        ship_battle_move_made.next_round_mover = next_round_mover;
    }

    public fun ship_battle_move_made_next_round_attacker_ship(ship_battle_move_made: &ShipBattleMoveMade): Option<address> {
        ship_battle_move_made.next_round_attacker_ship
    }

    public(friend) fun set_ship_battle_move_made_next_round_attacker_ship(ship_battle_move_made: &mut ShipBattleMoveMade, next_round_attacker_ship: Option<address>) {
        ship_battle_move_made.next_round_attacker_ship = next_round_attacker_ship;
    }

    public fun ship_battle_move_made_next_round_defender_ship(ship_battle_move_made: &ShipBattleMoveMade): Option<address> {
        ship_battle_move_made.next_round_defender_ship
    }

    public(friend) fun set_ship_battle_move_made_next_round_defender_ship(ship_battle_move_made: &mut ShipBattleMoveMade, next_round_defender_ship: Option<address>) {
        ship_battle_move_made.next_round_defender_ship = next_round_defender_ship;
    }

    public(friend) fun new_ship_battle_move_made(
        id: address,
        ship_battle: &ShipBattle,
        player_id: address,
        initiator_id: address,
        responder_id: address,
        attacker_command: u8,
        defender_command: u8,
        round_number: u32,
        defender_damage_taken: u32,
        attacker_damage_taken: u32,
        is_battle_ended: bool,
        winner: Option<u8>,
        next_round_started_at: u64,
        next_round_mover: Option<u8>,
        next_round_attacker_ship: Option<address>,
        next_round_defender_ship: Option<address>,
    ): ShipBattleMoveMade {
        ShipBattleMoveMade {
            id,
            version: version(ship_battle),
            player_id,
            initiator_id,
            responder_id,
            attacker_command,
            defender_command,
            round_number,
            defender_damage_taken,
            attacker_damage_taken,
            is_battle_ended,
            winner,
            next_round_started_at,
            next_round_mover,
            next_round_attacker_ship,
            next_round_defender_ship,
        }
    }

    struct ShipBattleLootTaken has store, drop {
        id: address,
        version: u64,
        player_id: address,
        loser_player_id: address,
        initiator_id: address,
        responder_id: address,
        choice: u8,
        loot: vector<ItemIdQuantityPair>,
        looted_at: u64,
        increased_experience: u32,
        new_level: u16,
        loser_increased_experience: u32,
        loser_new_level: u16,
    }

    public fun ship_battle_loot_taken_id(ship_battle_loot_taken: &ShipBattleLootTaken): address {
        ship_battle_loot_taken.id
    }

    public fun ship_battle_loot_taken_player_id(ship_battle_loot_taken: &ShipBattleLootTaken): address {
        ship_battle_loot_taken.player_id
    }

    public fun ship_battle_loot_taken_loser_player_id(ship_battle_loot_taken: &ShipBattleLootTaken): address {
        ship_battle_loot_taken.loser_player_id
    }

    public fun ship_battle_loot_taken_initiator_id(ship_battle_loot_taken: &ShipBattleLootTaken): address {
        ship_battle_loot_taken.initiator_id
    }

    public fun ship_battle_loot_taken_responder_id(ship_battle_loot_taken: &ShipBattleLootTaken): address {
        ship_battle_loot_taken.responder_id
    }

    public fun ship_battle_loot_taken_choice(ship_battle_loot_taken: &ShipBattleLootTaken): u8 {
        ship_battle_loot_taken.choice
    }

    public fun ship_battle_loot_taken_loot(ship_battle_loot_taken: &ShipBattleLootTaken): vector<ItemIdQuantityPair> {
        ship_battle_loot_taken.loot
    }

    public fun ship_battle_loot_taken_looted_at(ship_battle_loot_taken: &ShipBattleLootTaken): u64 {
        ship_battle_loot_taken.looted_at
    }

    public fun ship_battle_loot_taken_increased_experience(ship_battle_loot_taken: &ShipBattleLootTaken): u32 {
        ship_battle_loot_taken.increased_experience
    }

    public fun ship_battle_loot_taken_new_level(ship_battle_loot_taken: &ShipBattleLootTaken): u16 {
        ship_battle_loot_taken.new_level
    }

    public fun ship_battle_loot_taken_loser_increased_experience(ship_battle_loot_taken: &ShipBattleLootTaken): u32 {
        ship_battle_loot_taken.loser_increased_experience
    }

    public fun ship_battle_loot_taken_loser_new_level(ship_battle_loot_taken: &ShipBattleLootTaken): u16 {
        ship_battle_loot_taken.loser_new_level
    }

    public(friend) fun new_ship_battle_loot_taken(
        id: address,
        ship_battle: &ShipBattle,
        player_id: address,
        loser_player_id: address,
        initiator_id: address,
        responder_id: address,
        choice: u8,
        loot: vector<ItemIdQuantityPair>,
        looted_at: u64,
        increased_experience: u32,
        new_level: u16,
        loser_increased_experience: u32,
        loser_new_level: u16,
    ): ShipBattleLootTaken {
        ShipBattleLootTaken {
            id,
            version: version(ship_battle),
            player_id,
            loser_player_id,
            initiator_id,
            responder_id,
            choice,
            loot,
            looted_at,
            increased_experience,
            new_level,
            loser_increased_experience,
            loser_new_level,
        }
    }


    public(friend) fun update_version_and_add(obj_addr: address, ship_battle: ShipBattle) acquires ObjectController {
        ship_battle.version = ship_battle.version + 1;
        let extend_ref = &borrow_global<ObjectController>(obj_addr).extend_ref;
        let object_signer = object::generate_signer_for_extending(extend_ref);
        private_add_ship_battle(&object_signer, ship_battle)
    }

    public(friend) fun add_ship_battle(object_signer: &signer, ship_battle: ShipBattle) {
        assert!(ship_battle.version == 0, EInappropriateVersion);
        private_add_ship_battle(object_signer, ship_battle);
    }

    public(friend) fun remove_ship_battle(obj_addr: address): ShipBattle acquires ShipBattle {
        move_from<ShipBattle>(obj_addr)
    }

    fun private_add_ship_battle(object_signer: &signer, ship_battle: ShipBattle) {
        move_to(object_signer, ship_battle);
    }

    public(friend) fun delete_ship_battle(obj_addr: address) acquires ObjectController {
        let ObjectController {
            extend_ref: _extend_ref,
            delete_ref,
        } = move_from<ObjectController>(
            obj_addr
        );
        object::delete(delete_ref)
    }

    public fun get_ship_battle(obj_addr: address): pass_object::PassObject<ShipBattle> acquires ShipBattle {
        let ship_battle = remove_ship_battle(obj_addr);
        pass_object::new_with_address(ship_battle, obj_addr)
    }

    public fun return_ship_battle(ship_battle_pass_obj: pass_object::PassObject<ShipBattle>) acquires ObjectController {
        let (ship_battle, obj_addr) = pass_object::extract_value_and_address(ship_battle_pass_obj);
        let extend_ref = &borrow_global<ObjectController>(obj_addr).extend_ref;
        let object_signer = object::generate_signer_for_extending(extend_ref);
        private_add_ship_battle(&object_signer, ship_battle);
    }

    public(friend) fun borrow_mut(ship_battle_pass_obj: &mut pass_object::PassObject<ShipBattle>): &mut ShipBattle {
        pass_object::borrow_mut(ship_battle_pass_obj)
    }

    public(friend) fun object_signer(obj_addr: address): signer acquires ObjectController {
        let extend_ref = &borrow_global<ObjectController>(obj_addr).extend_ref;
        object::generate_signer_for_extending(extend_ref)
    }

    public(friend) fun drop_ship_battle(ship_battle: ShipBattle) {
        let ShipBattle {
            version: _version,
            initiator: _initiator,
            responder: _responder,
            status: _status,
            initiator_experiences: _initiator_experiences,
            responder_experiences: _responder_experiences,
            ended_at: _ended_at,
            winner: _winner,
            round_number: _round_number,
            round_started_at: _round_started_at,
            round_mover: _round_mover,
            round_attacker_ship: _round_attacker_ship,
            round_defender_ship: _round_defender_ship,
        } = ship_battle;
    }

    public(friend) fun emit_ship_battle_initiated(ship_battle_initiated: ShipBattleInitiated) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.ship_battle_initiated_handle, ship_battle_initiated);
    }

    public(friend) fun emit_ship_battle_move_made(ship_battle_move_made: ShipBattleMoveMade) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.ship_battle_move_made_handle, ship_battle_move_made);
    }

    public(friend) fun emit_ship_battle_loot_taken(ship_battle_loot_taken: ShipBattleLootTaken) acquires Events {
        assert!(exists<Events>(genesis_account::resource_account_address()), ENotInitialized);
        let events = borrow_global_mut<Events>(genesis_account::resource_account_address());
        event::emit_event(&mut events.ship_battle_loot_taken_handle, ship_battle_loot_taken);
    }

}
