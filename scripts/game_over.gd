class_name GameOver
extends Control


func _on_retry_pressed():
	Engine.time_scale = 1
	get_tree().reload_current_scene()

func set_score_ui(score:int):
	$Panel/Score.text = "SCORE: " + str(score)
