extends KinematicBody2D

var display_name : String = "Player" setget set_display_name
var color : Color setget set_color
var default_color := Color.gray

#func _ready():
#	if (color == null):
#		return
#	$CenterContainer/MarginContainer/DisplayName.text = display_name
#	var gradient = GradientTexture.new()
#	gradient.gradient = Gradient.new()
#	gradient.gradient.colors[0] = color
#	gradient.gradient.colors[1] = Color(0,0,0,0)
#	$Particles2D.process_material.color_ramp = gradient

func set_display_name(new_name):
	display_name = new_name
	$CenterContainer/MarginContainer/DisplayName.text = display_name


func set_color(new_color):
	color = new_color
	$Shape/Body.color = new_color
	var gradient = GradientTexture.new()
	gradient.gradient = Gradient.new()
	gradient.gradient.colors[0] = color
	gradient.gradient.colors[1] = Color(0,0,0,0)
	$Particles2D.process_material.color_ramp = gradient
	$CenterContainer/MarginContainer/DisplayName.set("custom_colors/font_color", color)
