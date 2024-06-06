extends Node2D

@export var player_life := 3
var game_score:int = 0
@onready var player = $Player
@onready var hud = $UI/HUD
@onready var enemy_hit_sfx = $EnemyHitSFX
@onready var player_hurt_sfx = $PlayerHurtSFX

var gameover_scene = preload("res://scenes/game_over.tscn")

func _ready():
	hud.set_score_ui(game_score)
	hud.set_life(player_life)

func _on_deadzone_area_entered(area):
	if area.has_method("destroy"):
		area.destroy()


func _on_player_took_damage(damage: int):
	player_hurt_sfx.play()
	player_life -= damage;
	hud.set_life(player_life)
	if player_life <= 0:
		gameover()


func _on_enemy_spawner_enemy_spawned(enemy_instance: Enemy):
	enemy_instance.connect("dead", _on_enemy_dead)
	add_child(enemy_instance)

func _on_enemy_dead(score: int):
	enemy_hit_sfx.play()
	game_score += score



func gameover():
	player.die()
	await get_tree().create_timer(1.5).timeout
	var gameover_instance:GameOver= gameover_scene.instantiate()
	gameover_instance.set_score_ui(game_score)
	Engine.time_scale = 0
	$UI.add_child(gameover_instance)
