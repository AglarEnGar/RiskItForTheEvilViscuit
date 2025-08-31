extends PanelContainer

# Reference to the death screen UI
var death_screen: Control
@onready var respawnbut: Button = $"./RichTextLabel/Button"
@onready var panelself: PanelContainer = $"./"

func _ready():
	# hide the thingy
	panelself.hide()

func show_death_screen():
	# Make the death screen visible
	panelself.show()
	
	# Pause the game (optional)
	get_tree().paused = true

func hide_death_screen():
	# Hide the death screen
	panelself.hide()
	
	# Unpause the game (if you paused it)
	get_tree().paused = false
	

# Example function to call when player dies (call this from your player script)
func kill_player():
	show_death_screen()

func _on_button_button_down() :
	# Unpause the game first
	print("Button Pressed")
	hide_death_screen()
	
	# Reload the current scene (restart level)
	get_tree().reload_current_scene() # Replace with function body.
	restart()

func restart() :
	get_tree().call_group("player", "go_home")
