extends Node2D

var blue_car_texture = preload("res://sprites/CarBlue.png")
var red_car_texture = preload("res://sprites/CarRed.png")

var value : bool
var on_logic_gate : bool = false
var direction : Vector2
var stopped : bool = false

func move(step : Vector2):
	if (!stopped):
		position += step

func set_value(val):
	value = val
	if (val):
		$Sprite2D.texture = blue_car_texture
	else:
		$Sprite2D.texture = red_car_texture

func stop():
	stopped = true

func get_value():
	return value

func set_direction(val):
	direction = val

func get_direction():
	return direction

func destroy():
	queue_free()
