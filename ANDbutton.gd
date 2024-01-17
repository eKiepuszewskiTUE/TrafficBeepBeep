extends TextureButton

# Signal to notify when an item is placed in the slot
signal item_placed(slot_id, res://Gates/AND.tscn)

var slot_id: int
var current_item_scene: Node = null

func _ready():
	connect("pressed", self, "_on_ItemSlot_pressed")

func _on_ItemSlot_pressed():
	var selected_item_scene_path = Inventory.get_selected_item_scene()
	if selected_item_scene_path != "":
		place_item(selected_item_scene_path)

func place_item(item_scene_path: String):
	clear_slot()  # Clear the slot before placing a new item
	var item_scene = load(item_scene_path).instance()
	add_child(item_scene)
	current_item_scene = item_scene
	emit_signal("item_placed", slot_id, item_scene_path)

# Function to clear the slot
func clear_slot():
	if current_item_scene:
		current_item_scene.queue_free()  # Remove the current item scene
		current_item_scene = null
