# Aptos Move CLI Cheatsheet

[ToC]

## Player aggregate

### Create method

```shell
aptos move run --function-id 'default::player_aggregate::create' \
--args 'string:name' \
--assume-yes
```

### Update method

```shell
aptos move run --function-id 'default::player_aggregate::update' \
--args address:id Option<u32>:experience_gained Option<u16>:new_level 'InventoryEntry:[inventory_entries_item_1,inventory_entries_item_2]' \
--assume-yes
```

### ClaimIsland method

```shell
aptos move run --function-id 'default::player_aggregate::claim_island' \
--args address:id Coordinates:coordinates \
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

## Register "friends" in dependency packages

```shell
aptos move run --function-id '{MAP_PACKAGE}::map_friend_config::add_allowed_caller' \
  --type-args '{PLAYER_PACKAGE}::player::FriendWitness' \
  --assume-yes

```

```shell
aptos move run --function-id '{PRODUCTION_PACKAGE}::production_friend_config::add_allowed_caller' \
  --type-args '{PLAYER_PACKAGE}::player::FriendWitness' \
  --assume-yes

```

