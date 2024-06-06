class_name Enemy
extends Area2D

@export var speed := 250 # pixel per second
@export var score := 100

signal dead(score:int)


func _physics_process(delta):
	global_position.x -= delta * speed

func die():
	emit_signal("dead", score)
	queue_free()

func destroy():
	queue_free()	

func _on_body_entered(body):
	if body is Player:
		body.take_damage(1)
		die()
