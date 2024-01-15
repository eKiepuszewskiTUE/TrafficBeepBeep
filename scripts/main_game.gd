extends Node2D

@export var gridSize : int
var cellSize : int = 16
var GameGrid : Array
var camera : Camera2D

enum Tile_Type {AND, OR, NAND, XOR, NOT, Road, Source}

var tile = preload("res://Scenes/tile.tscn")
var new_tile_selected : Tile_Type = Tile_Type.Road

func _ready():
	camera = $Camera2D
	DisplayServer.window_set_size(Vector2i(gridSize * cellSize * camera.zoom.x, gridSize * cellSize * camera.zoom.y))
	create_game_grid()

func _process(delta):
	if (Input.is_key_pressed(KEY_1)):
		new_tile_selected = Tile_Type.Source
		print("Source selected")
	if (Input.is_key_pressed(KEY_2)):
		new_tile_selected = Tile_Type.Road
		print("Road selected")
	if (Input.is_key_pressed(KEY_3)):
		new_tile_selected = Tile_Type.NOT
		print("NOT selected")

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

func _on_area_2d_input_event(tile_instance):
	tile_instance.change_tile_object(new_tile_selected)
