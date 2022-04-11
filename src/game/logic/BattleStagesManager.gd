extends Node2D


export var autostart = true
export var duration = 6 * 60 # in seconds
export var timer_asteroid_path: NodePath
export var timer_large_asteroid_path: NodePath
export var timer_enemy_path: NodePath
export var timer_heavy_enemy_path: NodePath

onready var timer_asteroid: Timer = get_node(timer_asteroid_path)
onready var timer_large_asteroid: Timer = get_node(timer_large_asteroid_path)
onready var timer_enemy: Timer = get_node(timer_enemy_path)
onready var timer_heavy_enemy: Timer = get_node(timer_heavy_enemy_path)
onready var stage_run = $StageRun

# Represent the wait time to each entity spawn in a given stage
# The lower the value the more frequent are the enemies
# The stages advance getting progressively more difficult
var stages = [
	# STAGE #1
	{
		'asteroid': 8,
		'large_asteroid': 0,
		'enemy': 4,
		'heavy_enemy': 0
	},
	# STAGE #2
	{
		'asteroid': 4,
		'large_asteroid': 12,
		'enemy': 3,
		'heavy_enemy': 20
	},
	# STAGE #3
	{
		'asteroid': 2,
		'large_asteroid': 12,
		'enemy': 3,
		'heavy_enemy': 20
	},
	# STAGE #4
	{
		'asteroid': 2,
		'large_asteroid': 8,
		'enemy': 4,
		'heavy_enemy': 10
	},
	# STAGE #5
	{
		'asteroid': 8,
		'large_asteroid': 12,
		'enemy': 2,
		'heavy_enemy': 6
	}
]
var stages_count = len(stages)
var stages_passed = -1

signal ended


func _ready():
	stage_run.wait_time = duration / stages_count
	if autostart:
		start()


func start():
	stage_run.start()
	advance_stage()


func stop():
	stage_run.stop()


func get_percent():
	return (stages_passed + Util.timer_percent(stage_run)) / stages_count


func advance_stage():
	stages_passed += 1
	
	if stages_passed >= stages_count:
		emit_signal("ended")
		return
	
	var stage_subjects: Dictionary = stages[stages_passed]
	for subject in stage_subjects.keys():
		var timer: Timer = get('timer_' + subject)
		var value = stage_subjects[subject]
		
		if value == 0:
			timer.stop()
			continue
		
		if timer.is_stopped():
			timer.start()
		
		timer.wait_time = value


func _on_StageRun_timeout():
	advance_stage()


func _on_BattleStagesManager_ended():
	timer_asteroid.stop()
	timer_large_asteroid.stop()
	timer_enemy.stop()
	timer_heavy_enemy.stop()
