extends Node

const ENEMY = preload("res://Enemy/Enemy.tscn")

var timeout = true

var score = 0
func _kill():
	get_tree().reload_current_scene()

func _process(delta):
	get_tree().get_root().set_disable_input(false)
	_spawn_enemy()
#	pause_mode = Node.PAUSE_MODE_STOP
	

func _ready():
	$SpawnTimer.start()

func _spawn_enemy():
	if not timeout:
		var enemy1 = ENEMY.instance()
		var enemy2 = ENEMY.instance()
		var enemy3 = ENEMY.instance()	
		var enemy4 = ENEMY.instance()
		var enemy5 = ENEMY.instance()
		var enemy6 = ENEMY.instance()	
		$Spawn.add_child(enemy1)
		$Spawn2.add_child(enemy2)
		$Spawn3.add_child(enemy3)
		$Spawn4.add_child(enemy4)
		$Spawn5.add_child(enemy5)
		$Spawn6.add_child(enemy6)
		timeout = true
		$SpawnTimer.start()	


func _on_SpawnTimer_timeout():
	timeout = false

func _updateScore():
	score = score + 20
	get_tree().call_group("HUD","_updateScore",score)


func _scoreChecker(amount):
	if score >= amount:
		if amount < 2000 && amount >= 500:
			get_node("Player").get_node("Timer").wait_time = 0.4
			
			score = score - amount
			get_tree().call_group("Shop","_showPop","x1 bought")
			get_tree().call_group("HUD","_updateScore",score)
		elif amount < 3000 && amount >= 2000:
			get_node("Player").get_node("Timer").wait_time = 0.3
			score = score - amount
			get_tree().call_group("Shop","_showPop","x2 bought")
			get_tree().call_group("HUD","_updateScore",score)
		elif amount >= 3000:
			get_node("Player").get_node("Timer").wait_time = 0.3
			score = score - amount
			get_tree().call_group("Shop","_showPop","x3 bought")
			
	else:
		get_tree().call_group("Shop","_showPop","You dont have enough")
