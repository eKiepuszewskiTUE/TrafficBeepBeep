extends Node2D
class_name Tile

var source = preload("res://Scenes/source.tscn")
var parking_lot = preload("res://Scenes/ParkingLot.tscn")
var road = preload("res://Scenes/road.tscn")
var roadB = preload("res://Scenes/roadB.tscn")
var roadD = preload("res://Scenes/roadD.tscn")
var roadU = preload("res://Scenes/roadU.tscn")
var roadC = preload("res://Scenes/roadC.tscn")
var roadV = preload("res://Scenes/roadV.tscn")
var not_gate = preload("res://Gates/NOT.tscn")
var and_gate = preload("res://Gates/AND.tscn")
var or_gate = preload("res://Gates/OR.tscn")
var xor_gate = preload("res://Gates/XOR.tscn")
var nand_gate = preload("res://Gates/NAND.tscn")

enum Tile_Type {AND, NAND, NOT, OR, XOR, RoadS, RoadB, RoadD, RoadU, RoadC, RoadV, Source, ParkingLot}
var dict = {
	Tile_Type.RoadS : road,
	Tile_Type.RoadB : roadB,
	Tile_Type.RoadD : roadD,
	Tile_Type.RoadU : roadU,
	Tile_Type.RoadC : roadC,
	Tile_Type.RoadV : roadV,
	Tile_Type.Source : source,
	Tile_Type.ParkingLot : parking_lot,
	Tile_Type.AND : and_gate,
	Tile_Type.NAND : nand_gate,
	Tile_Type.NOT : not_gate,
	Tile_Type.OR : or_gate,
	Tile_Type.XOR : xor_gate}

var tile_object
var tile_type
var highlight_sprite : Sprite2D
var double_tile : bool = false
var tile_type_selected : Tile_Type
var RoadTileTypes = [Tile_Type.RoadS, Tile_Type.RoadB, Tile_Type.RoadD, Tile_Type.RoadU, Tile_Type.RoadC, Tile_Type.RoadV]

var empty : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_variable_nodes()

func initialize_variable_nodes():
	highlight_sprite = $Highlight

signal mouse_entered(this)
func _on_area_2d_mouse_entered() -> void:
	if (tile_object == null):
		highlight_sprite.visible = true
	mouse_entered.emit(self)

func _on_area_2d_mouse_exited() -> void:
	highlight_sprite.visible = false

func set_tile_type_selected(tile_type_selected):
	self.tile_type_selected = tile_type_selected

func set_double_tile(tile_type_selected):
	if (tile_type_selected in RoadTileTypes or tile_type_selected == Tile_Type.Source):
		double_tile = false
	else:
		double_tile = true
	set_highlight_sprite()

func set_highlight_sprite():
	if (double_tile == false):
		highlight_sprite.texture = preload("res://sprites/highlight.png")
		highlight_sprite.offset = Vector2(0, 0)
	else:
		highlight_sprite.texture = preload("res://sprites/highlightLong.png")
		highlight_sprite.offset = Vector2(8, 0)

func change_tile_object(new_tile_type):
	set_double_tile(new_tile_type)
	var new_tile = dict[new_tile_type]
	if (tile_object != new_tile and tile_object != null):
		#tile_object.queue_free()
		return
	var temp = new_tile.instantiate()
	add_child(temp)
	tile_object = temp
	tile_type = new_tile_type

func get_tile_object():
	return tile_object

func get_tile_type():
	return tile_type

signal mouse_clicked(this)
func _on_area_2d_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.pressed):
		mouse_clicked.emit(self)
