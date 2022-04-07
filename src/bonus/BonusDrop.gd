extends Node2D


const rand_offset_pos = 8

export (Enum.BonusType) var drop_type = Enum.BonusType.HEAL
export (float, 0.0, 1.0) var chance: float = .5
export var health_module_path: NodePath 

onready var health_module = get_node(health_module_path)

var BonusPickup = preload("res://src/bonus/BonusPickup.tscn")
var disabled = false


func _ready():
	health_module.connect("died", self, "_on_HealthModule_died")
	health_module.connect("self_killed", self, "_on_HealthModule_self_killed")


func drop():
	if disabled: return
	if randf() < chance:
		var inst = BonusPickup.instance()
		var offset = Vector2(
			rand_range(-rand_offset_pos, rand_offset_pos),
			rand_range(-rand_offset_pos, rand_offset_pos)
		)
		inst.global_position = global_position + offset
		inst.type = drop_type
		get_tree().current_scene.call_deferred("add_child", inst)


func _on_HealthModule_died():
	drop()


func _on_HealthModule_self_killed():
	disabled = true
