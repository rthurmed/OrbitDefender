extends Node2D


export var target_group = 'friendly'
export var relocate_time = 1

onready var relocate_timer = $RelocateTimer

var target = null


func _ready():
	relocate_timer.start()


func find_closest_target():
	var all_targets = get_tree().get_nodes_in_group(target_group)
	var closest_distance
	var closest_node
	
	for node in all_targets:
		var distance = global_position.distance_to(node.global_position)
		if not closest_distance or closest_distance > distance:
			closest_distance = distance
			closest_node = node
	
	return closest_node


func relocate():
	target = find_closest_target()


func _on_RelocateTimer_timeout():
	relocate()
