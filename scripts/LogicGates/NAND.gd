extends LogicGate

func _ready():
	super()
	inputs = [false, false] # NAND gate has two inputs
	output = true

func calculate_output():
	output = !(inputs[0] && inputs[1])
	update_gate()

func set_inputs(val1, val2):
	inputs[0] = val1
	inputs[1] = val2
	calculate_output()

func get_inputs():
	return output

func update_gate():
	# Update visual representation here
	pass
