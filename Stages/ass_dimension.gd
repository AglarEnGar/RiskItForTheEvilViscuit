extends ColorRect

@onready var button: Button = $/root/EvilDimension/CanvasLayer/Button

func _on_button_toggled(toggled_on):
	if toggled_on:
		var next_sc = "res://Stages/UnderWorld.tscn"
		
		button.text = "Leave the ass dimension"
		get_tree().change_scene_to_file(next_sc)
		self.visible = toggled_on # Replace with function body.
		
		button.text = "Leave the ass dimension"
		
	else:
		var next_sc = "res://Stages/OverWorld.tscn"
		
		button.text = "Enter the ass dimension"
		get_tree().change_scene_to_file(next_sc)
		self.visible = toggled_on # Replace with function body.
		button.text = "Enter the ass dimension"
		
	self.visible = toggled_on # Replace with function body.
	print("Ran past the condition")
		
		
	
