extends Node2D


func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
	


func _on_texture_button_2_pressed():
	get_tree().change_scene_to_file("res://Scenes/Tutorial.tscn")
