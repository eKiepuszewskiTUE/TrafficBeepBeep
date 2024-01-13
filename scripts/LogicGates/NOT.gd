extends LogicGate

func _ready():
	super()
	inputs = [false] # NOT gate has one input
	output = false

func set_input(index, value):
	inputs[0] = value
	calculate_output()

func calculate_output():
	output = !inputs[0]
	update_gate()

func update_gate():
	# Update visual representation here
	pass
