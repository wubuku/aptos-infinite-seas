# Aptos Move CLI Cheatsheet

[ToC]

## Ship aggregate

## Roster aggregate

### CreateEnvironmentRoster method

```shell
aptos move run --function-id 'default::roster_aggregate::create_environment_roster' \
--args address:roster_id_player_id u32:roster_id_sequence_number u32:coordinates_x u32:coordinates_y u32:ship_resource_quantity u32:ship_base_resource_quantity u32:base_experience \
--assume-yes
```

### SetSail method

```shell
aptos move run --function-id 'default::roster_aggregate::set_sail' \
--args address:id Object<Player>:player u32:target_coordinates_x u32:target_coordinates_y u64:sail_duration u32:updated_coordinates_x u32:updated_coordinates_y \
--assume-yes
```

### AdjustShipsPosition method

```shell
aptos move run --function-id 'default::roster_aggregate::adjust_ships_position' \
--args address:id Object<Player>:player 'u64:[positions_item_1,positions_item_2]' 'address:[ship_ids_item_1,ship_ids_item_2]' \
--assume-yes
```

### TransferShip method

```shell
aptos move run --function-id 'default::roster_aggregate::transfer_ship' \
--args address:id Object<Player>:player address:ship_id Object<Roster>:to_roster 'u64:[to_position]' \
--assume-yes
```

### TransferShipInventory method

```shell
aptos move run --function-id 'default::roster_aggregate::transfer_ship_inventory' \
--args address:id Object<Player>:player address:from_ship_id address:to_ship_id 'u32:[item_id_quantity_pairs_item_id_list_item_1,item_id_quantity_pairs_item_id_list_item_2]' 'u32:[item_id_quantity_pairs_item_quantity_list_item_1,item_id_quantity_pairs_item_quantity_list_item_2]' \
--assume-yes
```

### TakeOutShipInventory method

```shell
aptos move run --function-id 'default::roster_aggregate::take_out_ship_inventory' \
--args address:id Object<Player>:player address:ship_id 'u32:[item_id_quantity_pairs_item_id_list_item_1,item_id_quantity_pairs_item_id_list_item_2]' 'u32:[item_id_quantity_pairs_item_quantity_list_item_1,item_id_quantity_pairs_item_quantity_list_item_2]' u32:updated_coordinates_x u32:updated_coordinates_y \
--assume-yes
```

### PutInShipInventory method

```shell
aptos move run --function-id 'default::roster_aggregate::put_in_ship_inventory' \
--args address:id Object<Player>:player address:ship_id 'u32:[item_id_quantity_pairs_item_id_list_item_1,item_id_quantity_pairs_item_id_list_item_2]' 'u32:[item_id_quantity_pairs_item_quantity_list_item_1,item_id_quantity_pairs_item_quantity_list_item_2]' u32:updated_coordinates_x u32:updated_coordinates_y \
--assume-yes
```

## ShipBattle aggregate

### InitiateBattle method

```shell
aptos move run --function-id 'default::ship_battle_aggregate::initiate_battle' \
--args Object<Player>:player Object<Roster>:initiator Object<Roster>:responder u32:initiator_coordinates_x u32:initiator_coordinates_y u32:responder_coordinates_x u32:responder_coordinates_y \
--assume-yes
```

### MakeMove method

```shell
aptos move run --function-id 'default::ship_battle_aggregate::make_move' \
--args address:id Object<Player>:player Object<Roster>:initiator Object<Roster>:responder u8:attacker_command \
--assume-yes
```

### TakeLoot method

```shell
aptos move run --function-id 'default::ship_battle_aggregate::take_loot' \
--args address:id Object<Player>:player Object<Player>:loser_player Object<Roster>:initiator Object<Roster>:responder u8:choice \
--assume-yes
```

## Player aggregate

### Create method

```shell
aptos move run --function-id 'default::player_aggregate::create' \
--args 'string:name' \
--assume-yes
```

### ClaimIsland method

```shell
aptos move run --function-id 'default::player_aggregate::claim_island' \
--args address:id u32:coordinates_x u32:coordinates_y \
--assume-yes
```

### Airdrop method

```shell
aptos move run --function-id 'default::player_aggregate::airdrop' \
--args address:id u32:item_id u32:quantity \
--assume-yes
```

### GatherIslandResources method

```shell
aptos move run --function-id 'default::player_aggregate::gather_island_resources' \
--args address:id \
--assume-yes
```

