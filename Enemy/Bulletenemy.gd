extends RigidBody2D



const EFFECT = preload("res://Enemy/ExplotionEnemySHoot.tscn") 
var move = Vector2.ZERO
var look_vec = Vector2.ZERO
var speed = 50
var player = Global.player


	

func _physics_process(delta):

#	if player != null:
#		look_vec = player.position
#		move = Vector2.ZERO
#
#		move = move.move_toward(look_vec,delta)
#		move = move.normalized() * speed
#		position += move
	#
	pass


#func _triggerExplosion(body):
#	var dist = sqrt(pow((player.position.x - position.x),2) - pow((player.position.y - position.y),2))
##	print(str(self)+" : "+str(dist))
#	if dist <= 20 && dist >= 0 :
#		randomize()
#		var temp = rand_range(0,2)
#		temp = int(temp)
#		print(temp)
#		if temp == 0:
#			pass
#		elif temp == 1:
#			var eff = EFFECT.instance()
#			eff.position = global_position
#			eff.rotation = global_rotation
#			get_tree().current_scene.add_child(eff)
#			body.queue_free()
#			queue_free()
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_ExplosionRadius_body_entered(body):
	if body != self && body.name == "Player":
#		_triggerExplosion(body)
		pass
