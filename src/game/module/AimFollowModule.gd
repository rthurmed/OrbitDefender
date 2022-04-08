extends Node2D


export var main_node_path: NodePath
export var targetting_module_path: NodePath
export var disabled = false
export var aim_speed: float = 1.0
export var adjust_degrees: float = 90.0

onready var targetting_module = get_node(targetting_module_path)
onready var main_node = get_node(main_node_path)


func _process(delta):
	if (
		disabled or
		targetting_module.target == null or
		not is_instance_valid(targetting_module.target)
	):
		return
	
	var diff_pos = targetting_module.target.global_position - main_node.global_position
	var angle_to_target = diff_pos.angle() + deg2rad(adjust_degrees)
	
	main_node.global_rotation = lerp_angle(main_node.global_rotation, angle_to_target, delta * aim_speed)
