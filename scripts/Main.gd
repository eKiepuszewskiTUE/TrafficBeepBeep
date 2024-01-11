extends Node2D

var graph_node = preload("res://graph_node.tscn") # change if directory changes

enum Mode {Edit, Play}
var mode : Mode

# Called when the node enters the scene tree for the first time.
func _ready():
	mode = Mode.Edit
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
