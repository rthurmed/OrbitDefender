extends Node2D


export var destination: Vector2 = Vector2.ZERO
export (Enum.BonusType) var type = Enum.BonusType.HEAL

onready var auto_move_module = $AutoMoveModule
onready var bonus_pickup = $BonusPickup


func _ready():
	auto_move_module.set_destination(destination)
	bonus_pickup.set_type(type)
	bonus_pickup.animation.stop()


func _on_AutoMoveModule_completed():
	if is_instance_valid(bonus_pickup):
		bonus_pickup.animation.play("dropped")
