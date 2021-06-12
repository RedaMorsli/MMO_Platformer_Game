extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	OS.set_window_size(Vector2(OS.get_real_window_size().x, rect_global_position.y + 16))

