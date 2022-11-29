extends Control

func _ready():
	
	SilentWolf.configure({
			  "api_key": "qN4q5GPJkr8H7v0pRr5mi4QRXPzljmJlaUpSaQbJ",
			  "game_id": "Cubgrade",
			  "game_version": "0.0.1",
			  "log_level": 1
			})
	SilentWolf.configure_scores({
			  "open_scene_on_close": "res://scenes/MainPage.tscn"
			})
func _on_NewGame_pressed():
	get_tree().change_scene("res://Level/World.tscn")


func _on_Leaderboard_pressed():
	get_tree().change_scene("res://HUD/LeaderBoard.tscn")


func _on_Options_pressed():
	get_tree().change_scene("res://HUD/Options.tscn")


func _on_Quit_pressed():
	get_tree().quit()
