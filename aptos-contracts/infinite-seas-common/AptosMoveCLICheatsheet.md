# Aptos Move CLI Cheatsheet

[ToC]

## Item aggregate

### Create method

```shell
aptos move run --function-id 'default::item_aggregate::create' \
--args u32:item_id 'string:name' bool:required_for_completion u32:sells_for \
--assume-yes
```

### Update method

```shell
aptos move run --function-id 'default::item_aggregate::update' \
--args u32:item_id 'string:name' bool:required_for_completion u32:sells_for \
--assume-yes
```

## ItemCreation aggregate

### Create method

```shell
aptos move run --function-id 'default::item_creation_aggregate::create' \
--args u8:item_creation_id_skill_type u32:item_creation_id_item_id u32:resource_cost u16:requirements_level u32:base_quantity u32:base_experience u64:base_creation_time u64:energy_cost u16:success_rate \
--assume-yes
```

### Update method

```shell
aptos move run --function-id 'default::item_creation_aggregate::update' \
--args u8:item_creation_id_skill_type u32:item_creation_id_item_id u32:resource_cost u16:requirements_level u32:base_quantity u32:base_experience u64:base_creation_time u64:energy_cost u16:success_rate \
--assume-yes
```

## ItemProduction aggregate

### Create method

```shell
aptos move run --function-id 'default::item_production_aggregate::create' \
--args u8:item_production_id_skill_type u32:item_production_id_item_id 'u32:[production_materials_item_id_list_item_1,production_materials_item_id_list_item_2]' 'u32:[production_materials_item_quantity_list_item_1,production_materials_item_quantity_list_item_2]' u16:requirements_level u32:base_quantity u32:base_experience u64:base_creation_time u64:energy_cost u16:success_rate \
--assume-yes
```

### Update method

```shell
aptos move run --function-id 'default::item_production_aggregate::update' \
--args u8:item_production_id_skill_type u32:item_production_id_item_id 'u32:[production_materials_item_id_list_item_1,production_materials_item_id_list_item_2]' 'u32:[production_materials_item_quantity_list_item_1,production_materials_item_quantity_list_item_2]' u16:requirements_level u32:base_quantity u32:base_experience u64:base_creation_time u64:energy_cost u16:success_rate \
--assume-yes
```

## ExperienceTable singleton object

### AddLevel method

```shell
aptos move run --function-id 'default::experience_table_aggregate::add_level' \
--args u16:level u32:experience u32:difference \
--assume-yes
```

### UpdateLevel method

```shell
aptos move run --function-id 'default::experience_table_aggregate::update_level' \
--args u16:level u32:experience u32:difference \
--assume-yes
```

