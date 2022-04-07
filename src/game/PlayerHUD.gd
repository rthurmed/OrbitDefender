extends CanvasLayer


onready var progress_label = $Shell/Progress/Label
onready var progress_bar = $Shell/Progress/ProgressBar
onready var bonus_label = $Shell/Bonus/Label
onready var bomb_count_label = $Shell/Indicators/BombCount/Label
onready var boost_count_label = $Shell/Indicators/BoostCount/Label


# TODO: show portrait


func _ready():
	# Examples
	set_general_progress(31)
	set_bonus_progress(56)
	set_bomb_count(5)
	set_boost_count(2)


func pad_number(x: int):
	var text = "%3d" % x
	return text.replace(" ", "~")


func set_general_progress(progress):
	progress_bar.value = progress
	progress_label.text = str(pad_number(progress), "%")


func set_bonus_progress(progress):
	bonus_label.text = str(pad_number(progress), "%")


func set_bomb_count(count):
	bomb_count_label.text = str(count)


func set_boost_count(count):
	boost_count_label.text = str(count)
