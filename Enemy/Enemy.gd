extends KinematicBody2D

const EFFECT = preload("res://Enemy/Explotion.tscn")
var motion = Vector2()
var speed = 500
var Player = null
var player_touched = false;
const SCORE = 20
func _physics_process(delta):
	_detect()





func _detect():
	if Player != null:

		position += (Player.position - position)/50
		look_at(Player.position)
		
		move_and_collide(motion)
	else:
		motion = Vector2.ZERO
		
		
func _on_Area2D_body_entered(body):
	if body.name == "Bullet":
		get_tree().call_group("Main","_updateScore")
		body.queue_free()
		var eff = EFFECT.instance()
		eff.position = global_position
		eff.rotation = global_rotation
		get_tree().current_scene.add_child(eff)
		print(eff)
		queue_free()
#	elif body.name =="Player":
#		var eff = EFFECT.instance()
#		eff.position = global_position
#		eff.rotation = global_rotation
#		get_tree().current_scene.add_child(eff)
#		print(eff)
#		queue_free()


func _on_Detector_body_entered(body):
	print(body.name)
	if body.name == "Player":
		Player = body
