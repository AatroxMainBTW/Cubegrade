extends Sprite

const EFFECT = preload("res://Enemy/ExplotionHazard.tscn")

var motion = Vector2()

func _on_Bonus_body_entered(body):
	if body.name == "Player":
		Global.bread_eaten += 1
		queue_free()
		var eff = EFFECT.instance()
		eff.position = global_position
		eff.rotation = global_rotation
		get_tree().current_scene.add_child(eff)
		get_tree().call_group("Main","_Scoretime",true)
		Global.temp = true

func _process(delta):
	motion.x = -200 * delta
	translate(motion)
