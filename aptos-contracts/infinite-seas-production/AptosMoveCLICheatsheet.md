# Aptos Move CLI Cheatsheet

[ToC]

## SkillProcess aggregate

### Create method

```shell
aptos move run --function-id 'default::skill_process_aggregate::create' \
--args SkillProcessId:skill_process_id \
--assume-yes
```

### StartProduction method

```shell
aptos move run --function-id 'default::skill_process_aggregate::start_production' \
--args address:id u32:batch_size address:player_id u16:player_level SkillTypeItemIdPair:item_production_id \
--assume-yes
```

### CompleteProduction method

```shell
aptos move run --function-id 'default::skill_process_aggregate::complete_production' \
--args address:id address:player_id u16:player_level u32:player_experience SkillTypeItemIdPair:item_production_id \
--assume-yes
```

### StartShipProduction method

```shell
aptos move run --function-id 'default::skill_process_aggregate::start_ship_production' \
--args address:id ItemIdQuantityPairs:production_materials address:player_id u16:player_level SkillTypeItemIdPair:item_production_id \
--assume-yes
```

### CompleteShipProduction method

```shell
aptos move run --function-id 'default::skill_process_aggregate::complete_ship_production' \
--args address:id address:unassigned_ships address:player_id u16:player_level u32:player_experience SkillTypeItemIdPair:item_production_id \
--assume-yes
```

### StartCreation method

```shell
aptos move run --function-id 'default::skill_process_aggregate::start_creation' \
--args address:id u32:batch_size address:player_id u16:player_level SkillTypeItemIdPair:item_creation_id \
--assume-yes
```

### CompleteCreation method

```shell
aptos move run --function-id 'default::skill_process_aggregate::complete_creation' \
--args address:id address:player_id u16:player_level u32:player_experience SkillTypeItemIdPair:item_creation_id \
--assume-yes
```

