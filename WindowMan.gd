extends Node2D
func _ready():
	get_tree().get_root().set_transparent_background(true)
	var size : Vector2i = DisplayServer.screen_get_size()
	DisplayServer.window_set_size(size)
	var vector2Array = PackedVector2Array([
		Vector2(0, 0), # Top left corner
		Vector2(1 * size.x, 0), # Top right corner
		Vector2(1 * size.x, 1 * size.y), # Bottom right corner
		Vector2(0, 1 * size.y) # Bottom left corner
		])
	get_window().mouse_passthrough_polygon = vector2Array

var frame_count = 0
var timer = 0
func _process(delta):
	timer += delta
	frame_count += 1
	if (timer >= 2):
		timer = 0
		print(frame_count)
		$Label.text = 'FPS: ' + str(frame_count / 2.0)
		frame_count = 0
func _physics_process(_delta):
	for i in get_children():
		var c:Control = i
		if (c.get_rect().has_point(get_global_mouse_position())):
			var vector2Array = PackedVector2Array([
				Vector2(c.position.x, c.position.y), # Top left corner
				Vector2(c.position.x + c.size.x, c.position.y), # Top right corner
				Vector2(c.position.x + c.size.x, c.position.y + c.size.y), # Bottom right corner
				Vector2(c.position.x, c.position.y + c.size.y) # Bottom left corner
			])
			get_window().mouse_passthrough_polygon = vector2Array
			break
