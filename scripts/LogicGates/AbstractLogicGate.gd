extends Node
class_name LogicGate

var inputs : Array[bool] = [false, false]
var output

var cars = []

func set_input(car):
	var value = car.get_value()
	if (len(cars) < 2):
		output = -1
	inputs[len(cars)] = value
	cars += [car]
	car.stop()
	print(cars)
	if (len(cars) == 2):
		calculate_output()
		destroy_cars()

func destroy_cars():
	for car in cars:
		car.destroy()
	cars = []

func get_cars():
	return cars

func get_inputs():
	return inputs

func get_output():
	return output

func _ready():
	update_gate()

# Abstract method
func update_gate():
	pass

# Abstract method
func calculate_output():
	pass
