extends Panel

# Signal to notify the main game scene of the player's action
signal spawn_gate(gate_type)
signal delete_gate

func _ready():
	# Connect the 'pressed' signal of each button to a function
	for button in get_children():
		if button is Button:
			button.connect("pressed", self, "_on_Button_pressed", [button.name])

func _on_Button_pressed(button_name):
	# Check the name of the button and emit the appropriate signal
	if button_name in ["NOT", "AND", "OR", "NAND", "XOR"]:
		emit_signal("spawn_gate", button_name)
	elif button_name == "Delete":
		emit_signal("delete_gate")
