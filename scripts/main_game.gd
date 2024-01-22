extends Node2D

@export var gridSize: int
var cellSize: int = 16
var GameGrid: Array
var camera: Camera2D

enum Tile_Type {AND, NAND, NOT, OR, XOR, RoadS, RoadB, RoadD, RoadU, RoadC, RoadV, Source}

var level = [Vector2(13,8),Vector2(13,12)]
var playing : bool = false

# Preload gate scenes
var gate_scenes = {
	Tile_Type.AND: preload("res://Gates/AND.tscn"),
	Tile_Type.NAND: preload("res://Gates/NAND.tscn"),
	Tile_Type.NOT: preload("res://Gates/NOT.tscn"),
	Tile_Type.OR: preload("res://Gates/OR.tscn"),
	Tile_Type.XOR: preload("res://Gates/XOR.tscn")
}

var source = preload("res://Scenes/source.tscn")
var tile = preload("res://Scenes/tile.tscn")
var new_tile_selected: Tile_Type = Tile_Type.RoadS
var car = preload("res://Scenes/car.tscn")
var cars = []

func _ready():
	camera = $Camera2D
	DisplayServer.window_set_size(Vector2i(gridSize * cellSize * camera.zoom.x, gridSize * cellSize * camera.zoom.y))
	create_game_grid()
	initialize_level()
	connect_ui_signals()

func initialize_level():
	for coords in level:
		GameGrid[coords.x][coords.y].change_tile_object(Tile_Type.Source)
		var new_car = car.instantiate()
		new_car.position = GameGrid[coords.x][coords.y].position
		cars += [new_car] 
		add_child(new_car)

# Creates the game grid
func create_game_grid() -> void:
	for r in range(gridSize, -1, -1):
		var rows = []
		for c in range(gridSize, -1, -1):
			var new_tile = tile.instantiate()
			new_tile.position = Vector2(r * cellSize, c * cellSize)
			new_tile.mouse_clicked.connect(_on_area_2d_input_event)
			new_tile.mouse_entered.connect(_on_area_2d_mouse_entered)
			#new_tile.get_node("Area2D").input_event.connect(_on_area_2d_input_event)
			rows += [new_tile]
			add_child(new_tile)
		GameGrid += [rows]

func connect_ui_signals() -> void:
	# Assuming the UI scene is a direct child of this node, replace "UI" with your actual UI scene's name
	var ui = $CanvasLayer/UI
	ui.gate_selected.connect(_on_gate_selected)

func _on_gate_selected(gate_type: String) -> void:
	print("Gate selected: ", gate_type)
	
	match gate_type:
		"RoadS":
			new_tile_selected = Tile_Type.RoadS
		"RoadB":
			new_tile_selected = Tile_Type.RoadB
		"RoadD":
			new_tile_selected = Tile_Type.RoadD
		"RoadU":
			new_tile_selected = Tile_Type.RoadU
		"RoadC":
			new_tile_selected = Tile_Type.RoadC
		"RoadV":
			new_tile_selected = Tile_Type.RoadV
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

func _on_area_2d_mouse_entered(tile_instance):
	tile_instance.set_double_tile(new_tile_selected)

func _on_area_2d_input_event(tile_instance):
	tile_instance.change_tile_object(new_tile_selected)

func start_game():
	playing = true

func stop_game():
	playing = false

func restart():
	for eCar in cars:
		eCar.queue_free()
	cars.clear()
	stop_game()
	initialize_level()

func _on_play_button_pressed():
	if (playing):
		stop_game()
	else:
		start_game()

func position_to_grid(pos):
	return Vector2(gridSize - int((pos.x + 8) / cellSize), gridSize - int((pos.y + 8) / cellSize))

func is_grid_empty(coords):
	return GameGrid[coords.x][coords.y].get_tile_object() == null

func _on_timer_timeout():
	if (playing):
		for eCar in cars:
			#print(eCar.position)
			#print(position_to_grid(eCar.position))
			if (!is_grid_empty(position_to_grid(eCar.position))):
				eCar.move(2)


func _on_restart_button_pressed():
	restart()
