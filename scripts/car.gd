extends Node2D

var blue_car_texture = preload("res://sprites/CarBlue.png")
var red_car_texture = preload("res://sprites/CarRed.png")

var value : bool

func move(step : Vector2):
	position += step

func set_value(val):
	value = val
	if (val):
		$Sprite2D.texture = blue_car_texture
	else:
		$Sprite2D.texture = red_car_texture

func get_value():
	return value
