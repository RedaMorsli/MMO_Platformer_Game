extends KinematicBody2D

const speed := 500
const max_gravity = 1200
var gravity := 0
var jump_force := -2000
var x := 0.0
var y := 0.0
var vel := Vector2.ZERO

func _process(delta):
	x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if Input.is_action_just_pressed("ui_up") and _is_on_floor():
		y = jump_force
		gravity = 0
	elif not _is_on_floor():
		y = min(vel.y + gravity, max_gravity)
		gravity = gravity + 10
	vel = vel.linear_interpolate(Vector2(x * speed, y), 0.15)
	vel = move_and_slide(vel)


func _is_on_floor() -> bool:
	return $RayCast2D.is_colliding() or $RayCast2D2.is_colliding()
