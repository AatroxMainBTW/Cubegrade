extends KinematicBody2D

const SPEED = 500
var motion = Vector2(-100,0)
var bullet_speed = 1000
const BULLET = preload("res://Player/Bullet.tscn")
var time_out = false
const EFFECT = preload("res://Enemy/ExplotionPlayer.tscn")
export var tg = false
var viewRect = get_viewport_rect()
var temp = false
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


func _process(delta):
	_move_player_left_right()
	_move_player_up_down()
	_fire()
	move_and_slide(motion)
	look_at(get_global_mouse_position())
	monitor_player_limits_x()
	monitor_player_limits_y()

func _fire():
	if Input.is_action_pressed("fire"):
		if not time_out:
			if temp == true:
				var bullet = BULLET.instance()
				var bullet2 = BULLET.instance()
				bullet.position = get_global_position()
				bullet.rotation_degrees = rotation_degrees
				bullet.apply_impulse(Vector2(),Vector2(bullet_speed,0).rotated(rotation))
				get_tree().get_root().call_deferred("add_child",bullet)
				
				bullet2.position = get_global_position()
				bullet2.rotation_degrees = rotation_degrees
				bullet2.apply_impulse(Vector2(),Vector2(bullet_speed,0).rotated(rotation))
				get_tree().get_root().call_deferred("add_child",bullet2)
				time_out = true
				$Timer.start()
			elif temp == false:
				var bullet = BULLET.instance()
				bullet.position = get_global_position()
				bullet.rotation_degrees = rotation_degrees
				bullet.apply_impulse(Vector2(),Vector2(bullet_speed,0).rotated(rotation))
				get_tree().get_root().call_deferred("add_child",bullet)
				time_out = true
				$Timer.start()
			
			


func _on_Timer_timeout():
	time_out = false


func monitor_player_limits_y():
	if get_position().y <= 0:
		position.y += abs(position.y)

	
	elif get_position().y >= 600:
#		position.y = abs(position.y)
		position.y = clamp(position.y,0,600)
	
func monitor_player_limits_x():
		
	if get_position().x <= 16:
		position.x += abs(position.x)
	
	elif get_position().x >= 1024:
#		position.x = -abs(position.x)
		position.x = clamp(position.x,0,1024)


func _on_Area2D_area_entered(area):
	if tg == false:
		if area.name == "Hitbox":
			var eff = EFFECT.instance()
			eff.position = global_position
			eff.rotation = global_rotation
			get_tree().current_scene.add_child(eff)
			visible = false
			yield(get_tree().create_timer(1),"timeout")
			get_tree().call_group("Main","_kill")


func _on_Area2D_body_entered(body):

	if tg == false:
		if body != self && body.is_in_group("bulletEnemy"):
			var eff = EFFECT.instance()
			eff.position = global_position
			eff.rotation = global_rotation
			get_tree().current_scene.add_child(eff)
			visible = false
			yield(get_tree().create_timer(1),"timeout")
			get_tree().call_group("Main","_kill")

func _upgradeShots(cond):
	temp = cond
