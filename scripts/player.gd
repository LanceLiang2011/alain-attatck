class_name Player
extends CharacterBody2D

@export var move_speed := 250
@export var freeze_time: float = 0.5

@onready var rocket_scene: PackedScene = preload("res://scenes/rocket.tscn")
@onready var rockets = $"../Rockets"
@onready var shoot_sfx = $ShootSFX

signal took_damage(damage: int)

var shoot_timer: float = 0.0
var is_shooting := false


func _process(delta):
	process_shooting_timer(delta)
	if Input.is_action_just_pressed("shoot") && !is_shooting:
		is_shooting = true
		shoot_sfx.play()
		shoot_timer = 0.0
		shoot()


func _physics_process(delta):
	velocity = Vector2(0, 0)
	if Input.is_action_pressed("move_right"):
		velocity.x = move_speed
	if Input.is_action_pressed("move_left"):
		velocity.x = -move_speed
	if Input.is_action_pressed("move_down"):
		velocity.y = move_speed
	if Input.is_action_pressed("move_up"):
		velocity.y = -move_speed
	move_and_slide()
	clamp_player()

func process_shooting_timer(delta: float):
	if is_shooting:
		shoot_timer += delta
	if shoot_timer > freeze_time:
		is_shooting = false

func shoot():
	var rocket_instance := rocket_scene.instantiate()
	rocket_instance.global_position = Vector2(
		global_position.x + 80,
		global_position.y
	)
	rockets.add_child(rocket_instance)


func clamp_player():
	
	global_position = global_position.clamp(
		Vector2(0, 0), 
		get_viewport_rect().size
		)

	
	#if global_position.x < 0:
		#global_position.x = 0
	#if global_position.x > viewport_size.x:
		#global_position.x = viewport_size.x
	#if global_position.y < 0:
		#global_position.y = 0
	#if global_position.y > viewport_size.y:
		#global_position.y = viewport_size.y


func take_damage(damage: int = 1):
	emit_signal("took_damage", damage)


func die():
	queue_free()
