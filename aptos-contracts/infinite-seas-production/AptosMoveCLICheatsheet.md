# Aptos Move CLI Cheatsheet

[ToC]

## SkillProcess aggregate

### Create method

```shell
aptos move run --function-id 'default::skill_process_aggregate::create' \
--args u8:skill_process_id_skill_type address:skill_process_id_player_id u8:skill_process_id_sequence_number \
--assume-yes
```

### StartProduction method

```shell
aptos move run --function-id 'default::skill_process_aggregate::start_production' \
--args address:id u32:batch_size Object<Player>:player u8:item_production_id_skill_type u32:item_production_id_item_id \
--assume-yes
```

### CompleteProduction method

```shell
aptos move run --function-id 'default::skill_process_aggregate::complete_production' \
--args address:id Object<Player>:player u8:item_production_id_skill_type u32:item_production_id_item_id \
--assume-yes
```

### StartShipProduction method

```shell
aptos move run --function-id 'default::skill_process_aggregate::start_ship_production' \
--args address:id 'u32:[production_materials_item_id_list_item_1,production_materials_item_id_list_item_2]' 'u32:[production_materials_item_quantity_list_item_1,production_materials_item_quantity_list_item_2]' Object<Player>:player u8:item_production_id_skill_type u32:item_production_id_item_id \
--assume-yes
```

### CompleteShipProduction method

```shell
aptos move run --function-id 'default::skill_process_aggregate::complete_ship_production' \
--args address:id Object<Roster>:unassigned_ships Object<Player>:player u8:item_production_id_skill_type u32:item_production_id_item_id \
--assume-yes
```

### StartCreation method

```shell
aptos move run --function-id 'default::skill_process_aggregate::start_creation' \
--args address:id u32:batch_size Object<Player>:player u8:item_creation_id_skill_type u32:item_creation_id_item_id \
--assume-yes
```

### CompleteCreation method

```shell
aptos move run --function-id 'default::skill_process_aggregate::complete_creation' \
--args address:id Object<Player>:player u8:item_creation_id_skill_type u32:item_creation_id_item_id \
--assume-yes
```

