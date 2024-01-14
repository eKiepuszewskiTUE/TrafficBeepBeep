extends Node2D

var road = preload("res://Scenes/road.tscn")

var and_gate = preload("res://Gates/AND.tscn")

var object
var highlight_sprite : Sprite2D

var empty : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_variable_nodes()

func initialize_variable_nodes():
	highlight_sprite = $Highlight

func _on_area_2d_mouse_entered() -> void:
	highlight_sprite.visible = true

func _on_area_2d_mouse_exited() -> void:
	highlight_sprite.visible = false

func _on_area_2d_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.pressed):
		if (object == null):
			#object = and_gate.instantiate()
			object = road.instantiate()
			add_child(object)
