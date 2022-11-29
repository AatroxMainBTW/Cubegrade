extends Control


func _addscore():
	SilentWolf.Scores.persist_score($VBoxContainer/VBoxContainer2/ED.text, Global.score)

#
#func _ready():
#	SilentWolf.Scores.persist_score("Fouzz", score)

func _on_Button_pressed():
	_addscore()
	get_tree().change_scene("res://HUD/MainMenu.tscn")
