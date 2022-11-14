extends KinematicBody2D

const SPEED = 500
var motion = Vector2(-100,0)
var bullet_speed = 500
const BULLET = preload("res://Player/Bullet.tscn")
var time_out = false
const EFFECT = preload("res://Enemy/ExplotionPlayer.tscn")



func _move_player_left_right():
	if Input.is_action_pressed("left") && not Input.is_action_pressed("right"):
		motion.x =  -SPEED
	elif Input.is_action_pressed("right") && not Input.is_action_pressed("left"):
		motion.x =  SPEED
	else:
		motion.x = 0;
	
func _move_player_up_down():
	if Input.is_action_pressed("up") && not Input.is_action_pressed("down"):
		motion.y =  -SPEED
	elif Input.is_action_pressed("down") && not Input.is_action_pressed("up"):
		motion.y =  SPEED
	else:
		motion.y = 0;


func _physics_process(delta):
	_move_player_left_right()
	_move_player_up_down()
	_fire()
	move_and_slide(motion)
	look_at(get_global_mouse_position())

func _fire():
	if Input.is_action_pressed("fire"):
		if not time_out:
			var bullet = BULLET.instance()
			bullet.position = get_global_position()
			bullet.rotation_degrees = rotation_degrees
			bullet.apply_impulse(Vector2(),Vector2(bullet_speed,0).rotated(rotation))
			get_tree().get_root().call_deferred("add_child",bullet)
			time_out = true
			$Timer.start()
		


func _on_Timer_timeout():
	time_out = false




func _on_Area2D_body_entered(body):
	print(body.name)
	if body.name == "Enemy":
		var eff = EFFECT.instance()
		eff.position = global_position
		eff.rotation = global_rotation
		get_tree().current_scene.add_child(eff)
		visible = false
		yield(get_tree().create_timer(1),"timeout")
		get_tree().call_group("Main","_kill")
	

	
