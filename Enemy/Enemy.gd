extends Sprite

const EFFECT = preload("res://Enemy/Explotion.tscn")
var motion = Vector2()
var speed = 200
var Player = null
var player_touched = false;
var AMOUNT = 20

func _physics_process(delta):
	_detect(delta)
	




func _detect(delta):
	if Player != null:
		look_at(Player.position)
		motion = global_position.direction_to(Player.global_position)
		global_position += motion * delta * speed

		

	else:
		motion = Vector2.ZERO
		

func _kill(body):
	if Global.temp == true:
		if Global.bread_eaten >= 30:
			AMOUNT = AMOUNT * 3
		else:
			AMOUNT = AMOUNT * 2
	get_tree().call_group("Main","_updateScore",AMOUNT)
	Global.amount = AMOUNT
	get_tree().call_group("Main","_shake")
	body.queue_free()
	var label := preload("res://HUD/LabelDamage.tscn").instance()
	label.global_position = $LabelPos.global_position
	get_tree().current_scene.add_child(label)
	var eff = EFFECT.instance()
	eff.position = global_position
	eff.rotation = global_rotation
	get_tree().current_scene.add_child(eff)

	queue_free()
	
func _on_Area2D_body_entered(body):
	if body.name == "Bullet":
		_kill(body)
		
#	elif body.name =="Player":
#		var eff = EFFECT.instance()
#		eff.position = global_position
#		eff.rotation = global_rotation
#		get_tree().current_scene.add_child(eff)
#		print(eff)
#		queue_free()


func _on_Detector_body_entered(body):

	if body.name == "Player":
		Player = body
