extends Node2D

@export var node_id : int
@export var node_connections = []

var circle_default = preload("res://sprites/circle.png")
var circle_highlighted = preload("res://sprites/circle_highlighted.png")
var clicked : bool = false

func _ready():
	$Sprite2D.texture = circle_default
	print("Graph node created")

func _process(delta):
	pass

# adds a new node connection
# @param next_node_id : node id of the node to connect to
func add_node_connection(next_node_id):
	node_connections += [next_node_id]
	pass

# checks if mouse is clicked on node
func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if (event.pressed):
			print(node_id,  "clicked")

# if mouse is hovering about object
func _on_area_2d_mouse_entered():
	$Sprite2D.texture = circle_highlighted

# if mouse exited the object
func _on_area_2d_mouse_exited():
	if (!clicked):
		$Sprite2D.texture = circle_default
