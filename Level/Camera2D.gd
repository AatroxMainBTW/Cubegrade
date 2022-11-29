extends Camera2D

var screen_shake_start = false
var shake_intensity = 0




func _process(delta):
	zoom = lerp(zoom, Vector2(1,1), 0.3)
	
	if screen_shake_start == true:
		global_position += Vector2(rand_range(-shake_intensity,shake_intensity),rand_range(-shake_intensity,shake_intensity)) * delta
		
		
		
func _screen_shake(intensity, time):
	zoom = Vector2(1,1) - Vector2(intensity * 0.02, intensity * 0.02)
	shake_intensity = intensity
	$Screen_Shake_Time.wait_time = time
	$Screen_Shake_Time.start()
	screen_shake_start = true

func _on_Screen_Shake_Time_timeout():
	screen_shake_start = false
