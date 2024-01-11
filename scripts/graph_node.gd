extends Node2D

@export var node_id : int
@export var node_connections = []

var circle_default = preload("res://sprites/circle.png")
var circle_highlighted = preload("res://sprites/circle_highlighted.png")
var highlighted = false
var selected = false
var clicked : bool = false
var mouse_on_node : bool = false

func _ready():
	$Sprite2D.texture = circle_default

func _process(delta):
	if (highlighted):
		$Sprite2D.texture = circle_highlighted
	else:
		if (!selected):
			$Sprite2D.texture = circle_default

# adds a new node connection
# @param next_node_id : node id of the node to connect to
func add_node_connection(next_node_id):
	node_connections += [next_node_id]
	pass

# checks if mouse is clicked on node
func _on_area_2d_input_event(viewport, event, shape_idx):
	if (Input.is_action_just_pressed("left_mouse")):
		print(node_id,  " clicked")

# if mouse is hovering about object
func _on_area_2d_mouse_entered():
	mouse_on_node = true
	highlighted = true

func set_label(text):
	print(text)
	$Label.text = str(text)

func deselect():
	highlighted = false
	selected = false

# if mouse exited the object
func _on_area_2d_mouse_exited():
	mouse_on_node = false
	highlighted = false

func get_node_id():
	return self.node_id

func set_node_id(node_id):
	self.node_id = node_id
