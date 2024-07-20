# Aptos Move CLI Cheatsheet

[ToC]

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

## Map singleton object

### AddIsland method

```shell
aptos move run --function-id 'default::map_aggregate::add_island' \
--args u32:coordinates_x u32:coordinates_y 'u32:[resources_item_id_list_item_1,resources_item_id_list_item_2]' 'u32:[resources_item_quantity_list_item_1,resources_item_quantity_list_item_2]' \
--assume-yes
```

### GatherIslandResources method

```shell
aptos move run --function-id 'default::map_aggregate::gather_island_resources' \
--args Object<Player>:player \
--assume-yes
```

