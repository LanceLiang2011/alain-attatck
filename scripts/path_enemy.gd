class_name PathEnemy
extends Path2D

@onready var path_follow_2d = $PathFollow2D
@onready var enemy = $PathFollow2D/Enemy

@export var speed:float = 0.25 # change path radio in 1s


func _ready():
	path_follow_2d.progress_ratio = 1
	

func _physics_process(delta):
	path_follow_2d.progress_ratio -= speed * delta
	if path_follow_2d.progress_ratio <= 0.01:
		queue_free()
	
