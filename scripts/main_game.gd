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

func _process(delta: float) -> void:
	# UI buttons will now handle the tile selection, so no need for keyboard input here.
	pass

func connect_ui_signals() -> void:
	# Assuming the UI scene is a direct child of this node, replace "UI" with your actual UI scene's name
	var ui = $UI
	ui.connect("gate_selected", self, "_on_gate_selected")

func _on_gate_selected(gate_type: String) -> void:
	match gate_type:
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


