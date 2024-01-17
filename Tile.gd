extends Node2D
class_name Tile

var source = preload("res://Scenes/source.tscn")
var road = preload("res://Scenes/road.tscn")
var not_gate = preload("res://Gates/NOT.tscn")
var and_gate = preload("res://Gates/AND.tscn")
var or_gate = preload("res://Gates/OR.tscn")
var xor_gate = preload("res://Gates/XOR.tscn")
var nand_gate = preload("res://Gates/NAND.tscn")

enum Tile_Type {AND, NAND, NOT, OR, XOR, Road, Source}
var dict = {Tile_Type.Road : road, Tile_Type.Source : source}

var tile_object
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

func change_tile_object(new_tile_type):
	var new_tile = dict[new_tile_type]
	if (tile_object != null):
		self.tile_object.queue_free()
	self.tile_object = new_tile
	var temp = new_tile.instantiate()
	print(temp)
	add_child(temp)

signal mouse_clicked(this)
func _on_area_2d_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.pressed):
		mouse_clicked.emit(self)
