extends Control

func _ready():
	_set_keys()  


func _on_Mainmene_pressed():
	get_tree().change_scene("res://HUD/MainMenu.tscn")


var can_change_key = false
var action_string
enum ACTIONS {up, down, left, right, fire}

	
func _set_keys():
	$VBoxContainer/VBoxContainer/HBoxContainer_UP/Button.set_pressed(false)
	$VBoxContainer/VBoxContainer/HBoxContainer_Down/Button.set_pressed(false)
	$VBoxContainer/VBoxContainer/HBoxContainer_LEFT/Button.set_pressed(false)
	$VBoxContainer/VBoxContainer/HBoxContainer_RIGHT/Button.set_pressed(false)
	$VBoxContainer/VBoxContainer/HBoxContainer_FIRE/Button.set_pressed(false)

	$VBoxContainer/VBoxContainer/HBoxContainer_UP/Button.set_text(InputMap.get_action_list("up")[0].as_text())
	$VBoxContainer/VBoxContainer/HBoxContainer_Down/Button.set_text(InputMap.get_action_list("down")[0].as_text())
	$VBoxContainer/VBoxContainer/HBoxContainer_LEFT/Button.set_text(InputMap.get_action_list("left")[0].as_text())
	$VBoxContainer/VBoxContainer/HBoxContainer_RIGHT/Button.set_text(InputMap.get_action_list("right")[0].as_text())
	$VBoxContainer/VBoxContainer/HBoxContainer_FIRE/Button.set_text(InputMap.get_action_list("fire")[0].as_text())
		
func _mark_button(string):
	can_change_key = true
	action_string = string
	
	$VBoxContainer/VBoxContainer/HBoxContainer_UP/Button.set_pressed(false)
	$VBoxContainer/VBoxContainer/HBoxContainer_Down/Button.set_pressed(false)
	$VBoxContainer/VBoxContainer/HBoxContainer_LEFT/Button.set_pressed(false)
	$VBoxContainer/VBoxContainer/HBoxContainer_RIGHT/Button.set_pressed(false)
	$VBoxContainer/VBoxContainer/HBoxContainer_FIRE/Button.set_pressed(false)
func _input(event):
	if event is InputEventKey: 
		if can_change_key:
			_change_key(event)
			can_change_key = false
func _change_key(new_key):
	#Delete key of pressed button
	if !InputMap.get_action_list(action_string).empty():
		InputMap.action_erase_event(action_string, InputMap.get_action_list(action_string)[0])
	
	#Check if new key was assigned somewhere
	for i in ACTIONS:
		if InputMap.action_has_event(i, new_key):
			InputMap.action_erase_event(i, new_key)
			
	#Add new Key
	InputMap.action_add_event(action_string, new_key)
	
	_set_keys()

func _on_Down_pressed():
	_mark_button("down")


func _on_Up_pressed():
	_mark_button("up")


func _on_LEFT_pressed():
	_mark_button("left")


func _on_RIGHT_pressed():
	_mark_button("right")


func _on_FIRE_pressed():
	_mark_button("fire")
