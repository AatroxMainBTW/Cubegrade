extends Control
onready var scroll = $VBoxContainer/ScrollContainer
onready var scrollbar = scroll.get_v_scrollbar()
const inst = preload("res://HUD/Score.tscn")
func _ready():
	scrollbar.connect("changed",self,"_handle_scrollbar_changed")
	yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")
	print("Scores: " + str(SilentWolf.Scores.scores))
	var i = 1
	for score in SilentWolf.Scores.scores:
		var instance = inst.instance()
		instance.get_node("HBoxContainer2/Place").text = str(i)
		instance.get_node("HBoxContainer2/Player").text = str(score.player_name)
		instance.get_node("HBoxContainer2/Score").text = str(int(score.score))
		i += 1 
		$VBoxContainer/ScrollContainer/VBoxContainer.add_child(instance)

func _handle_scrollbar_changed():
	scroll.scroll_vertical = scrollbar.max_value


func _on_Button_pressed():
	get_tree().change_scene("res://HUD/MainMenu.tscn")
