extends Control

@onready var score_label:Label = $Score
@onready var life_label:Label = $Life

func set_score_ui(score:int):
	score_label.text = "SCORE: " + str(score);

func set_life(life:int):
	life_label.text = str(life)
