extends Node2D

@export var gridSize: int
var cellSize: int = 16
var GameGrid: Array
var camera: Camera2D

enum Tile_Type {AND, NAND, NOT, OR, XOR, RoadS, RoadB, RoadD, RoadU, RoadC, RoadV, Source, ParkingLot}

var level = [Vector3(13,8,0), Vector3(8, 8, 1)]
var playing : bool = false

var LogicGates = [Tile_Type.AND, Tile_Type.NAND, Tile_Type.NOT, Tile_Type.OR, Tile_Type.XOR]

# Preload gate scenes
var gate_scenes = {
	Tile_Type.AND: preload("res://Gates/AND.tscn"),
	Tile_Type.NAND: preload("res://Gates/NAND.tscn"),
	Tile_Type.NOT: preload("res://Gates/NOT.tscn"),
	Tile_Type.OR: preload("res://Gates/OR.tscn"),
	Tile_Type.XOR: preload("res://Gates/XOR.tscn")
}

var source = preload("res://Scenes/source.tscn")
var parking_lot = preload("res://Scenes/ParkingLot.tscn")
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
		if (coords.z == 0):
			GameGrid[coords.x][coords.y].change_tile_object(Tile_Type.Source)
			var new_car = car.instantiate()
			new_car.position = GameGrid[coords.x][coords.y].position
			cars += [new_car] 
			add_child(new_car)
		if (coords.z == 1): 
			GameGrid[coords.x][coords.y].change_tile_object(Tile_Type.ParkingLot)

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
		"Source":
			new_tile_selected = Tile_Type.Source
		"ParkingLot":
			new_tile_selected = Tile_Type.ParkingLot
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
	var tile_pos = tile_instance.position
	var grid_pos = position_to_grid(tile_pos)
	var next_grid_pos = grid_pos + Vector2(-1,0)
	print(grid_pos)
	if (new_tile_selected in LogicGates):
		if (is_grid_empty(next_grid_pos)):
			GameGrid[next_grid_pos.x][next_grid_pos.y].change_tile_object(Tile_Type.RoadS)
			tile_instance.change_tile_object(new_tile_selected)
			play_building_sound()
	elif (new_tile_selected == Tile_Type.Source):
		level += [Vector3(grid_pos.x, grid_pos.y, 0)]
		tile_instance.change_tile_object(new_tile_selected)
		initialize_level()
	else:
		tile_instance.change_tile_object(new_tile_selected)
		play_building_sound()

func start_game():
	playing = true
	start_car_engine()

func stop_game():
	playing = false
	stop_car_engine()

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

func play_blip():
	$BlipPlayer.play()

func position_to_grid(pos):
	return Vector2(gridSize - int((pos.x + 8) / cellSize), gridSize - int((pos.y + 8) / cellSize))

func is_grid_empty(coords):
	return GameGrid[coords.x][coords.y].get_tile_object() == null

func play_building_sound():
	$BuildingSoundPlayer.play()

func start_car_engine():
	$CarEnginePlayer.play()

func stop_car_engine():
	$CarEnginePlayer.stop()

var on_logic_gate : bool = false
func _on_timer_timeout():
	if (playing):
		for eCar in cars:
			print(eCar.position)
			print(position_to_grid(eCar.position))
			var gridPos = position_to_grid(eCar.position)
			if (!is_grid_empty(gridPos)):
				var step = Vector2(2, 0)
				var tile_interacting_type = GameGrid[gridPos.x][gridPos.y].get_tile_type()
				var tile_interacting = GameGrid[gridPos.x][gridPos.y].get_tile_object()
				print(tile_interacting_type)
				if (tile_interacting_type in LogicGates):
					if (!on_logic_gate):
						on_logic_gate = true
						tile_interacting.set_inputs(eCar.get_value(), false)
						eCar.set_value(tile_interacting.get_output())
						play_blip()
				else:
					on_logic_gate = false
				if (tile_interacting_type == Tile_Type.RoadD):
					eCar.set_direction(Vector2(1, 1))
					step = Vector2(2, 2)
				if (tile_interacting_type == Tile_Type.RoadU):
					eCar.set_direction(Vector2(1, -1))
					step = Vector2(2, -2)
				if (tile_interacting_type == Tile_Type.RoadV):
					step = Vector2(0, eCar.get_direction().y * 2)
				if (tile_interacting_type == Tile_Type.RoadC):
					step = Vector2(1, eCar.get_direction().y * 0.8)
				eCar.move(step)

func _on_restart_button_pressed():
	restart()
