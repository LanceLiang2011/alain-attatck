extends Node2D

var enemy_scene = preload("res://scenes/enemy.tscn")
@onready var spawn_area = $SpawnArea

signal enemy_spawned(enemy_instance: Enemy)


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
