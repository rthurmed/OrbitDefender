extends Area2D


export var speed = 150
export var accel = 1.5

onready var timer = $Timer


func _process(delta):
	position = lerp(
		position,
		position + Vector2.RIGHT * speed,
		delta * accel
	)



func _on_Bullet_body_entered(body):
	print(body)


func _on_Timer_timeout():
	queue_free()
