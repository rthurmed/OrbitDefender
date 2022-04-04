extends Node2D


onready var spaceship = $"../.."
onready var bullets = $Bullets
onready var raycast = $RayCast

var shooting


func _process(_delta):
	shooting = Input.is_action_pressed("shoot")
	
	bullets.emitting = shooting
	bullets.global_rotation = 0
	bullets.direction = Vector2.UP.rotated(global_rotation)
	
	raycast.enabled = shooting


func _on_Spaceship_inverting(_inverted):
	bullets.orbit_velocity = bullets.orbit_velocity * -1
