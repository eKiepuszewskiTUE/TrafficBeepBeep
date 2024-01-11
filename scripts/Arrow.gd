extends Node2D

@export var start_point : Vector2
@export var end_point : Vector2

var body_sprite : Sprite2D
var head_sprite : Sprite2D

# -----------------------------
# ----- Core Functionality ----
# -----------------------------

# Called when the node enters the scene tree for the first time.
func _ready():
	head_sprite = $Head
	body_sprite = $Body
	set_body_dimensions()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_body_dimensions():
	var x = start_point.x - end_point.x
	var y = -1* (start_point.y - end_point.y)
	print("x: ", x, " y: ", y)
	body_sprite.scale.y = sqrt(pow(x, 2) + pow(y, 2))
	if (start_point.x > end_point.x):
		if (start_point.y > end_point.y):
			pass
		else:
			pass
	else:
		if (start_point.y > end_point.y):
			pass
		else:
			pass
	print(body_sprite.rotation)

# -----------------------------
# ----- Getters & Setters -----
# -----------------------------

func set_start_point(start_point : Vector2):
	self.start_point = start_point

func get_start_point():
	return start_point

func set_end_point(end_point : Vector2):
	self.end_point = end_point

func get_end_point():
	return end_point
