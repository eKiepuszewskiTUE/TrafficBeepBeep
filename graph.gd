extends Node2D

var graph_node = preload("res://graph_node.tscn")
var mouse_on_node : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	# Mouse in viewport coordinates.
	if (event is InputEventMouseButton) and (!mouse_on_node):
		print("Mouse Click/Unclick at: ", event.position)
		var graph_node_instance = graph_node.instantiate()
		graph_node_instance.position = event.position
		add_child(graph_node_instance)
