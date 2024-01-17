extends Node2D

@export var gridSize: int
var cellSize: int = 16
var GameGrid: Array
var camera: Camera2D

enum Tile_Type {AND, NAND, NOT, OR, XOR, Road, Source}

# Preload gate scenes
var gate_scenes = {
	Tile_Type.AND: preload("res://Gates/AND.tscn"),
	Tile_Type.NAND: preload("res://Gates/NAND.tscn"),
	Tile_Type.NOT: preload("res://Gates/NOT.tscn"),
	Tile_Type.OR: preload("res://Gates/OR.tscn"),
	Tile_Type.XOR: preload("res://Gates/XOR.tscn")
}

var tile = preload("res://Scenes/tile.tscn")
var new_tile_selected: Tile_Type = Tile_Type.Road

func _ready():
	camera = $Camera2D
	DisplayServer.window_set_size(Vector2i(gridSize * cellSize * camera.zoom.x, gridSize * cellSize * camera.zoom.y))
	create_game_grid()
	connect_ui_signals()

func _process(delta):
	print(new_tile_selected)

# Creates the game grid
func create_game_grid() -> void:
	for r in range(gridSize):
		var rows = []
		for c in range(gridSize):
			var new_tile = tile.instantiate()
			new_tile.position = Vector2(r * cellSize, c * cellSize)
			new_tile.mouse_clicked.connect(_on_area_2d_input_event)
			#new_tile.get_node("Area2D").input_event.connect(_on_area_2d_input_event)
			rows += [new_tile]
			add_child(new_tile)
		GameGrid += [rows]

func connect_ui_signals() -> void:
	# Assuming the UI scene is a direct child of this node, replace "UI" with your actual UI scene's name
	var ui = $CanvasLayer/UI
	ui.gate_selected.connect(_on_gate_selected)

func _on_gate_selected(gate_type: String) -> void:
	match gate_type:
		"Road":
			new_tile_selected = Tile_Type.Road
		"AND":
			new_tile_selected = Tile_Type.AND
		"NAND":
			new_tile_selected = Tile_Type.NAND
		"NOT":
			new_tile_selected = Tile_Type.NOT
		"OR":
			new_tile_selected = Tile_Type.OR
		"XOR":
			new_tile_selected = Tile_Type.XOR
		_:
			print("Unknown gate type selected")

func _on_area_2d_input_event(tile_instance):
	tile_instance.change_tile_object(new_tile_selected)
