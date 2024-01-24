extends LogicGate

func _ready():
	super()
	inputs = [false, false] # NOT gate has one input
	output = false

func set_input(index, value):
	inputs[0] = value
	calculate_output()

func calculate_output():
	output = !inputs[0]
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
