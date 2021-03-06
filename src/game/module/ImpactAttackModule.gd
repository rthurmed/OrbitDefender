extends Node2D


export var impact_damage = 2
export var target_group = ''
export var area_node_path: NodePath
export var collision_node_path: NodePath
export var health_module_path: NodePath

onready var area_node = get_node(area_node_path)
onready var collision_node = get_node(collision_node_path)
onready var own_health_module = get_node(health_module_path) if health_module_path else null


func _ready():
	area_node.connect("area_entered", self, "_on_AreaNode_area_entered")


func _on_AreaNode_area_entered(area):
	if (
		len(target_group) > 0 and
		not area.is_in_group(target_group)
	):
		return
	
	var health_module = area.find_node("HealthModule")
	var angle = global_position.angle_to(area.global_position)
	var shape: CircleShape2D = collision_node.shape
	var diameter = shape.radius / 2
	var collision_point = (global_position + Vector2.RIGHT * diameter).rotated(angle)
	
	if health_module:
		health_module.hit(impact_damage, collision_point)
		if own_health_module:
			own_health_module.kill(collision_point)
