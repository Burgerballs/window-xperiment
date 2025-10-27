extends Panel

@onready var scene = $SubViewportContainer/SubViewport/scene
var mouse_overlapping_viewport:bool = false
var mouse_overlapping_window:bool = false
var grabbed = false
func _on_close_pressed():
	OS.kill(0)

func _input(_event):
	if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and mouse_overlapping_window and not mouse_overlapping_viewport):
		grabbed = true
	elif (!Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		grabbed = false
	
var prevMouse:Vector2 = Vector2(0,0)
func _process(_delta):
	var mouse = get_global_mouse_position()
	if grabbed:
		position -= (prevMouse - mouse)
		position.x = clampf(position.x, 0, DisplayServer.screen_get_size().x - size.x)
		position.y = clampf(position.y, 0, DisplayServer.screen_get_size().y - size.y)
	prevMouse = get_global_mouse_position()

func _on_mouse_entered():
	mouse_overlapping_window = true


func _on_mouse_exited():
	mouse_overlapping_window = false
	print('exit window')


func _on_viewport_mouse_entered():
	mouse_overlapping_viewport = true


func _on_viewport_mouse_exited():
	mouse_overlapping_viewport = false
	print('exit vp')
