extends Node
class_name LogicGate

var inputs : Array[bool]
var output : bool

func set_input(index, value):
	inputs[index] = value
	calculate_output()

func _ready():
	update_gate()

# Abstract method
func update_gate():
	pass

# Abstract method
func calculate_output():
	pass
