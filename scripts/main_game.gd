extends Node2D

var not_gate = preload("res://Gates/NOT.tscn")
var and_gate = preload("res://Gates/AND.tscn")
var or_gate = preload("res://Gates/OR.tscn")
var xor_gate = preload("res://Gates/XOR.tscn")
var nand_gate = preload("res://Gates/NAND.tscn")

var tile = preload("res://Scenes/tile.tscn")

@export var gridSize : int
var cellSize : int = 16
var GameGrid : Array
var camera : Camera2D

func _ready():
	camera = $Camera2D
	DisplayServer.window_set_size(Vector2i(gridSize * cellSize * camera.zoom.x, gridSize * cellSize * camera.zoom.y))
	create_game_grid()

# Creates the game grid
func create_game_grid() -> void:
	for r in range(gridSize):
		var rows = []
		for c in range(gridSize):
			var new_tile = tile.instantiate()
			new_tile.position = Vector2(r * cellSize, c * cellSize)
			rows += [new_tile]
			add_child(new_tile)
		GameGrid += [rows]
