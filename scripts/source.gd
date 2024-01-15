extends Area2D
class_name Source

var value : bool
var textures : Array = [preload("res://sprites/Source0.png"), preload("res://sprites/Source1.png")]

func set_value(value) -> void:
	self.value = value
	$Sprite2D.texture = textures[value]
	

func get_value() -> bool:
	return self.value

func _on_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		set_value(!get_value())
