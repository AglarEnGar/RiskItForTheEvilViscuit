extends ColorRect

@onready var button: Button = $/root/Stage/CanvasLayer/Button

func _on_button_toggled(toggled_on):
	if toggled_on:
		button.text = "Leave the ass dimension"
	else:
		button.text = "Enter the ass dimension"
	self.visible = toggled_on # Replace with function body.
