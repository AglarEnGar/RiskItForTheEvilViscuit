extends CanvasLayer

@onready var AssDimensionShader: ColorRect = $AssDimensionShader
@onready var TimeLeftLabel: RichTextLabel = $TimeLeft

func _process(_d):
	TimeLeftLabel.text = "Time Until Dimensional Collapse: %d" % Globals.CrouchTimer.time_left

func _on_player_crouch_start():
	visible = true


func _on_player_crouch_end():
	visible = false
