extends LogicGate

func _ready():
	super()
	inputs = [false, false] # NOT gate has one input
	output = false

func set_input(car):
	inputs[0] = car.get_value()
	car.stop()
	cars += [car]
	calculate_output()

func calculate_output():
	output = !inputs[0]
	update_gate()

func get_inputs():
	return output

func update_gate():
	# Update visual representation here
	pass
