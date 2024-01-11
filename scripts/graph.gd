extends Node2D

var arrow = preload("res://arrow.tscn")
var graph_node = preload("res://graph_node.tscn")
var mouse_on_node : bool = false
var mouse_on_node_object
var nodes_spawned = []
var graph = []
var selected_node = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mouse_on_node = check_if_mouse_on_node()
	if Input.is_action_just_pressed("left_mouse"):
		if (mouse_on_node):
			if (selected_node != null):
				if (mouse_on_node_object == selected_node):
					deselect_node()
				else:
					connect_nodes(selected_node, mouse_on_node_object)
					deselect_node()
			else: # selected node == null
				selected_node = mouse_on_node_object
				selected_node.selected = true
		
		if (!mouse_on_node):
			if (selected_node == null):
				spawn_node()
			else:
				deselect_node()

func connect_nodes(node1, node2):
	graph[node1.get_node_id()] += [node2.get_node_id()] # create node connection
	print(graph)
	
	var connecting_arrow = arrow.instantiate()
	connecting_arrow.set_start_point(node1.position)
	connecting_arrow.set_end_point(node2.position)
	add_child(connecting_arrow)

func deselect_node():
	selected_node.deselect()
	selected_node = null

# Create connection between two nodes
func create_connection():
	pass

# Spawn node at mouse position
func spawn_node():
	var mouse_position = get_global_mouse_position()
	
	var graph_node_instance = graph_node.instantiate()
	graph_node_instance.set_node_id(nodes_spawned.size())
	graph_node_instance.position = mouse_position
	graph_node_instance.set_label(graph_node_instance.get_node_id())
	
	nodes_spawned += [graph_node_instance]
	graph += [[]]
	
	add_child(graph_node_instance)

func check_if_mouse_on_node():
	for node in nodes_spawned:
		if (node.mouse_on_node): 
			mouse_on_node_object = node
			return true
	return false
