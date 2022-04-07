extends Area2D


export (Enum.BonusType) var type = Enum.BonusType.HEAL

onready var animation = $AnimationPlayer
onready var sprite = $Sprite


func _ready():
	sprite.frame = type
	animation.play("dropped")


func despawn():
	queue_free()
