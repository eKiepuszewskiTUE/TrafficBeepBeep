extends Area2D

var inputs = [false, false] # NAND gate has two inputs
var output = true

func _ready():
	update_gate()

func set_input(index, value):
	inputs[index] = value
	calculate_output()

func calculate_output():
	output = !(inputs[0] && inputs[1])
	update_gate()

func update_gate():
	# Update visual representation here
