extends Node2D



func _ready():
	$Label.text = str(Global.amount)
	$AnimationPlayer.play("SHOW")

func _delete():
	queue_free()
