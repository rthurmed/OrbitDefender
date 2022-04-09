extends CanvasLayer


onready var animation = $AnimationPlayer
onready var subtitle_label = $GameOver/Message/Subtitle


func call_game_over(subtitle = ''):
	animation.play("game_over")
	subtitle_label.text = subtitle
