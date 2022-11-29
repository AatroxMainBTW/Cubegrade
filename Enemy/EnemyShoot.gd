extends Sprite


const EFFECT = preload("res://Enemy/ExplotionEnemySHoot.tscn")
const BULLET = preload("res://Enemy/Bulletenemy.tscn")
var motion = Vector2()
var speed = 200
var bullet_speed = 500
var Player = null
var player_touched = false;
var AMOUNT = 50
var timeout = false
func _physics_process(delta):
	_detect(delta)
	_fire()
	


#
#func _fire():
#	if not timeout:
#
#		var bullet = BULLET.instance()
#		bullet.player = Player
#		get_tree().get_root().call_deferred("add_child",bullet)
#		bullet.position = get_global_position()
#		bullet.rotation_degrees = rotation_degrees
#		print("fire")
#		timeout = true
#		$Timer.start()
func _fire():
	
	if not timeout:
		var bullet = BULLET.instance()
		bullet.position = get_global_position()
		bullet.rotation_degrees = rotation_degrees
		bullet.apply_impulse(Vector2(),Vector2(bullet_speed,0).rotated(rotation))
		get_tree().get_root().call_deferred("add_child",bullet)
		timeout = true
		$Timer.start()
			



func _detect(delta):
	if Player != null:
		look_at(Player.position)
		motion = global_position.direction_to(Player.global_position)
		global_position += motion * delta * speed

		

	else:
		motion = Vector2.ZERO


func _on_Hitbox_body_entered(body):
	if body.name == "Bullet":
		if Global.temp == true:
			if Global.bread_eaten >= 30:
				AMOUNT = AMOUNT * 3
			else:
				AMOUNT = AMOUNT * 2
		$DeathSound.play()
		Global.amount = AMOUNT
		var label := preload("res://HUD/LabelDamage.tscn").instance()
		label.global_position = $LabelPos.global_position
		get_tree().current_scene.add_child(label)
		get_tree().call_group("Main","_updateScore",AMOUNT)
		get_tree().call_group("Main","_shake")
		body.queue_free()
		var eff = EFFECT.instance()
		eff.position = global_position
		eff.rotation = global_rotation
		get_tree().current_scene.add_child(eff)
		queue_free()


func _on_Detector_body_entered(body):
	if body.name == "Player":
		Player = body


func _on_Timer_timeout():
	timeout = false
