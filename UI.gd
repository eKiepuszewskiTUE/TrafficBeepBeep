extends Control
class_name UI
# Signal to notify the main scene of the selected gate type
signal gate_selected(gate_type)

func _on_and_button_pressed():
	gate_selected.emit("AND")

func _on_nand_button_pressed():
	gate_selected.emit("NAND")

func _on_not_button_pressed():
	gate_selected.emit("NOT")

func _on_or_button_pressed():
	gate_selected.emit("OR")

func _on_xor_button_pressed():
	gate_selected.emit("XOR")

func _on_road_button_pressed():
	gate_selected.emit("RoadS")

func _on_road_b_button_pressed():
	gate_selected.emit("RoadB")

func _on_road_d_button_pressed():
	gate_selected.emit("RoadD")

func _on_road_u_button_pressed():
	gate_selected.emit("RoadU")

func _on_road_c_button_pressed():
	gate_selected.emit("RoadC")

func _on_road_v_button_pressed():
	gate_selected.emit("RoadV")

func _on_source_button_pressed():
	gate_selected.emit("Source")

func _on_parking_lot_button_pressed():
	gate_selected.emit("ParkingLot")
