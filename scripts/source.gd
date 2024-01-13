extends Area2D
class_name Source

var value : bool
var label : Label

func _ready():
	label = $Label

func set_value(value) -> void:
	self.value = value
	set_label_value(value)

func set_label_value(value) -> void:
	label.text = str(int(value))

func get_value() -> bool:
	return self.value

func _on_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		set_value(!get_value())
