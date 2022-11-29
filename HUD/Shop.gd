extends Control

var temp = false
func _ready():
	visible = false
	pause_mode = Node.PAUSE_MODE_PROCESS

func _on_Button_pressed():
	
	get_tree().call_group("Main","_scoreChecker",500)

func _process(delta):
	set_process_input(true)

func _on_Button2_pressed():
	get_tree().call_group("Main","_scoreChecker",2000)
	
	
func _input(event):
	if event.is_action_pressed("Pause"):
		print("nonod")
		print("pause")
		if temp == false:
			get_tree().paused = true
			visible = true
			temp = true
		elif temp == true:
			print("unpause")
			get_tree().paused = false
			visible = false
			temp = false


func _on_Button3_pressed():
		get_tree().call_group("Main","_scoreChecker",3000)
	
func _showPop(response):
	$Label.text = response



func _on_Button4_pressed():
	get_tree().call_group("Main","_scoreChecker",5000)
