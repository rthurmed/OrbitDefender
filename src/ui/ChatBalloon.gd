extends Control


onready var portrait_image = $TextureRect/Portrait
onready var name_label = $TextureRect/Name
onready var message_label = $TextureRect/Message


func prompt(message: String, char_name: String, portrait: int = 0):
	portrait_image.frame = portrait
	name_label.text = char_name
	typewriter(message_label, message)


func typewriter(label: Label, text: String, time_sec = .02):
	label.text = ''
	for letter in text:
		label.text += letter
		yield(get_tree().create_timer(time_sec), "timeout")
