extends Resource

class_name FoodInfo

@export var id: String
@export var name: String
@export var texture: Texture2D

@export_category("Buffs")

## Permanent tail size
@export var length := 0

@export var boost: BoostInfo
