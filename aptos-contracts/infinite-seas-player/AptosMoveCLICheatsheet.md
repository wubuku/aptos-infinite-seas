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

