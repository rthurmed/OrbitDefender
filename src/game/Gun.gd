extends Node2D


export var shooting = false
export var dps = 1.0

onready var bullets = $Bullets
onready var raycast = $RayCast


func _process(delta):
	bullets.emitting = shooting
	bullets.global_rotation = 0
	bullets.direction = Vector2.UP.rotated(global_rotation)
	
	raycast.enabled = shooting
	
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		var health_module = collider.find_node("HealthModule")
		if health_module:
			health_module.hit(dps * delta)
