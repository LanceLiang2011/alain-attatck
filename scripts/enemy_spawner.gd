extends Node2D

var enemy_scene = preload("res://scenes/enemy.tscn")
var path_enemy_scene = preload("res://scenes/path_enemy.tscn")
@onready var spawn_area = $SpawnArea

signal enemy_spawned(enemy_instance: Enemy)
signal path_enemy_spawned(path_enemy_instance: PathEnemy)


func _on_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	var selected_position = spawn_area\
	.get_children()\
	.pick_random()\
	.global_position
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = selected_position
	emit_signal("enemy_spawned", enemy_instance)


func _on_path_timer_timeout():
	spawn_path_enemy()

func spawn_path_enemy():
	if not path_enemy_scene:
		return
	var path_enemy_instance: PathEnemy = path_enemy_scene.instantiate()
	add_child(path_enemy_instance)
	emit_signal("path_enemy_spawned", path_enemy_instance)

