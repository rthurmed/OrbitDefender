extends CanvasLayer


onready var animation = $AnimationPlayer


func call_game_over():
	animation.play("game_over")
