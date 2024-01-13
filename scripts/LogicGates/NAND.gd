extends LogicGate

func _ready():
	super()
	inputs = [false, false] # NAND gate has two inputs
	output = true

func calculate_output():
	output = !(inputs[0] && inputs[1])
	update_gate()

func update_gate():
	# Update visual representation here
	pass
