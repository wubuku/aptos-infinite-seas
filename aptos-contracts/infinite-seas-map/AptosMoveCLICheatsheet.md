# Aptos Move CLI Cheatsheet

[ToC]

## Map singleton object

### AddIsland method

```shell
aptos move run --function-id 'default::map_aggregate::add_island' \
--args u32:coordinates_x u32:coordinates_y 'u32:[resources_item_id_list_item_1,resources_item_id_list_item_2]' 'u32:[resources_item_quantity_list_item_1,resources_item_quantity_list_item_2]' \
--assume-yes
```

### ClaimIsland method

```shell
aptos move run --function-id 'default::map_aggregate::claim_island' \
--args Coordinates:coordinates address:claimed_by u64:claimed_at \
--assume-yes
```

### GatherIslandResources method

```shell
aptos move run --function-id 'default::map_aggregate::gather_island_resources' \
--args address:player_id Coordinates:coordinates \
--assume-yes
```

## Register "friends" in dependency packages

