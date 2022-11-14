extends Control


func _updateScore(score):
	$VBoxContainer/HBoxContainer/Score.text = str(score)
