extends Area2D

var inputs = [false] # NOT gate has one input
var output = false

func _ready():
	update_gate()

func set_input(value):
	inputs[0] = value
	calculate_output()

func calculate_output():
	output = !inputs[0]
	update_gate()

func update_gate():
	# Update visual representation here
