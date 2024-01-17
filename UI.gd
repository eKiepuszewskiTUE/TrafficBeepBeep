extends Control

# Signal to notify the main scene of the selected gate type
signal gate_selected(gate_type)

func _ready():
	$AND_Button.connect("pressed", Callable(self, "_on_AND_Button_pressed"))
	$NAND_Button.connect("pressed", Callable(self, "_on_NAND_Button_pressed"))
	$NOT_Button.connect("pressed", Callable(self, "_on_NOT_Button_pressed"))
	$OR_Button.connect("pressed", Callable(self, "_on_OR_Button_pressed"))
	$XOR_Button.connect("pressed", Callable(self, "_on_XOR_Button_pressed"))


func _on_AND_Button_pressed():
	emit_signal("gate_selected", "AND")

func _on_NAND_Button_pressed():
	emit_signal("gate_selected", "NAND")

func _on_NOT_Button_pressed():
	emit_signal("gate_selected", "NOT")

func _on_OR_Button_pressed():
	emit_signal("gate_selected", "OR")

func _on_XOR_Button_pressed():
	emit_signal("gate_selected", "XOR")
