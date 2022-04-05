extends Sprite


export var notify_explosion_max = false

onready var animation = $AnimationPlayer

signal explosion_max
signal ended


func _ready():
	animation.play("play")


# This function is called in the animation player
func emit_explosion_max():
	if notify_explosion_max:
		emit_signal("explosion_max")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "play":
		emit_signal("ended")
		queue_free()
