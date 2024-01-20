extends Sprite2D
func _ready():
	var animation_player = $AnimationPlayer  # Access the AnimationPlayer node
	animation_player.play("colorchange")  # Play the animation named 'colorchange'
