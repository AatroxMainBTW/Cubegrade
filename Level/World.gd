extends Node

const ENEMY = preload("res://Enemy/Enemy.tscn")
const BONUS = preload("res://Hazard/Bread.tscn")
const ENEMY_SHOOT = preload("res://Enemy/EnemyShoot.tscn")
var timeout = true
var increase_score = false
var spawntime = false
var score = 0

func _kill():

		Global.score = $CanvasLayer2/HUD/VBoxContainer/HBoxContainer/Score.text
		get_tree().change_scene("res://HUD/GameOver.tscn")

	

func _process(delta):
	if increase_score == true:
		_progress()
	get_tree().get_root().set_disable_input(false)
	_spawn_enemy()
	_spawn_bonus()
#	pause_mode = Node.PAUSE_MODE_STOP
	

func _ready():
	$SpawnTimer.start()
	$VBoxContainer/ProgressBar.visible = false
	$VBoxContainer/Label.visible = false
	Global.player = $Player

func _spawn_bonus():
	if not spawntime:
		var bonus = BONUS.instance()
		$Spawn7.add_child(bonus)
		spawntime = true
		$Timer.start()


func _spawn_enemy():
	if not timeout:
		var enemy1 = ENEMY.instance()
		var enemy2 = ENEMY.instance()
		var enemy4 = ENEMY.instance()
		var enemy5 = ENEMY.instance()
		var enemy6_shoot = ENEMY_SHOOT.instance()	
		$Spawn.add_child(enemy1)
		$Spawn2.add_child(enemy2)
		$Spawn4.add_child(enemy4)
		$Spawn5.add_child(enemy5)
		$Spawn6.add_child(enemy6_shoot)
		timeout = true
		$SpawnTimer.start()	


func _on_SpawnTimer_timeout():
	timeout = false

func _updateScore(amount):
	_playsound()
	score = score + amount
	
		
		
	get_tree().call_group("HUD","_updateScore",score)
func _playsound():
	var audiostream = preload("res://Player/explosion.wav")
	$DeathSound.set_stream(audiostream)
	$DeathSound.playing = true	

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
		elif amount >= 3000 && amount <5000:
			get_node("Player").get_node("Timer").wait_time = 0.3
			score = score - amount
			get_tree().call_group("Shop","_showPop","x3 bought")
		elif amount >= 5000:
			score = score - amount
			get_tree().call_group("Shop","_showPop","Double shots bought")
			get_tree().call_group("HUD","_updateScore",score)
			get_tree().call_group("Player","_upgradeShots",true)
			
	else:
		get_tree().call_group("Shop","_showPop","You dont have enough")

func _shake():
	$Camera2D._screen_shake(4,0.2)

func _Scoretime(scorebool):
	increase_score = scorebool
	$IncreaseTimer.start()
	$VBoxContainer/ProgressBar.visible = true
	if Global.bread_eaten >= 30:
		$VBoxContainer/Label.text = "score x3"
	$VBoxContainer/Label.visible = true
	
	
	
func _progress():
	$VBoxContainer/ProgressBar.value=$IncreaseTimer.time_left

func _on_IncreaseTimer_timeout():
	increase_score = false
	Global.temp = false
	$VBoxContainer/ProgressBar.visible = false
	$VBoxContainer/Label.visible = false



func _on_Timer_timeout():
	spawntime = false
