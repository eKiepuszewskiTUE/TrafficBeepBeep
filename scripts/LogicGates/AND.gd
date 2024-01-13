extends LogicGate

func _ready():
	super()
	inputs = [false, false] # AND gate has two inputs
	output = false

func calculate_output():
	output = inputs[0] && inputs[1]
	update_gate()

func update_gate():
	# Update visual representation here
	pass
