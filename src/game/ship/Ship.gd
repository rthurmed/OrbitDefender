extends Node2D


const BONUS_HEAL_AMOUNT = 1
const BONUS_BOMB_AMOUNT = 1
const BONUS_TURRET_AMOUNT = 1

export var min_altitude = 32
export var max_altitude = 96
export var v_move_speed = 48
export var initial_bomb_count = 3
export var initial_turret_count = 2

onready var animation = $RotatoryAxis/Spaceship/AnimationPlayer
onready var visual_instance = $RotatoryAxis/Spaceship/VisualInstance
onready var ship_sprite = $RotatoryAxis/Spaceship/VisualInstance/Sprite
onready var ship = $RotatoryAxis/Spaceship
onready var gun = $RotatoryAxis/Spaceship/VisualInstance/Gun
onready var rotatory_axis = $RotatoryAxis
onready var bomb_shooter = $RotatoryAxis/Spaceship/VisualInstance/BombShooter
onready var turret_deployer = $RotatoryAxis/Spaceship/VisualInstance/TurretDeployer
onready var collision = $RotatoryAxis/Spaceship/CollisionShape2D
onready var health_module = $RotatoryAxis/Spaceship/HealthModule
onready var audio_bonus_picked = $Audio/BonusPicked

signal inverting(inverted)
signal died
signal updated_bomb_count(amount)
signal updated_turret_count(amount)

var bomb_count = initial_bomb_count
var turret_count = initial_turret_count


func _process(delta):
	# Shooting logic
	if Input.is_action_just_pressed("shoot"):
		gun.set_shooting(true)
	
	if Input.is_action_just_released("shoot"):
		gun.set_shooting(false)
	
	# Switch between clockwise and counter-clockwise
	if (
		not animation.is_playing() and
		Input.is_action_just_pressed("invert")
	):
		animation.play("deinvert" if is_inverted() else "invert")
		emit_signal("inverting", is_inverted())
	
	# Move up and down
	if (
		Input.is_action_pressed("higher") or
		Input.is_action_pressed("lower")
	):
		var move_x = (
			Input.get_action_strength("higher") -
			Input.get_action_strength("lower")
		)
		var target_position_x = clamp(ship.position.x + move_x, min_altitude, max_altitude)
		ship.position.x = lerp(ship.position.x, target_position_x, delta * v_move_speed)
	
	# Shoot bomb
	if Input.is_action_just_pressed("bomb") and bomb_count > 0:
		bomb_shooter.shoot()
		bomb_count -= 1
		emit_signal("updated_bomb_count", bomb_count)
	
	if Input.is_action_just_pressed("deploy_turret") and turret_count > 0:
		turret_deployer.deploy()
		turret_count -= 1
		emit_signal("updated_turret_count", turret_count)


func is_inverted():
	return rotatory_axis.target_speed > 0


func apply_bonus(bonus_type: int):
	audio_bonus_picked.play()
	if bonus_type == Enum.BonusType.HEAL:
		health_module.heal(BONUS_HEAL_AMOUNT)
	elif bonus_type == Enum.BonusType.BOMB:
		bomb_count += BONUS_BOMB_AMOUNT
		emit_signal("updated_bomb_count", bomb_count)
	elif bonus_type == Enum.BonusType.TURRET:
		turret_count += BONUS_TURRET_AMOUNT
		emit_signal("updated_turret_count", turret_count)


func _on_HealthModule_died():
	set_process(false)
	visual_instance.visible = false
	gun.shooting = false
	collision.disabled = true
	ship.position.x = 0
	emit_signal("died")


func _on_Spaceship_area_entered(area):
	if area.is_in_group('pickup'):
		apply_bonus(area.type)
		area.despawn()
