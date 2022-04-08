extends Node2D


export var max_range = 140
export var targetting_module_path: NodePath
export var gun_path: NodePath

onready var targetting_module = get_node(targetting_module_path)
onready var gun = get_node(gun_path)

onready var raycast = $RayCast

var on_sight = false


func _ready():
	raycast.cast_to.y = -max_range


func _process(_delta):
	if (
		targetting_module.target == null or
		not is_instance_valid(targetting_module.target)
	):
		return
	
	var last_sight = on_sight
	
	on_sight = (
		raycast.is_colliding() and
		raycast.get_collider() != null and
		raycast.get_collider().name == targetting_module.target.name
	)
	
	if last_sight != on_sight:
		gun.set_shooting(on_sight)
