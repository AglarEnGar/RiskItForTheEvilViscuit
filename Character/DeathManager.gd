extends Control

# Reference to the death screen UI
var death_screen: Control
@onready var respawnbut: Button = $"./RichTextLabel/Button"


func _on_crouch_expire():
	print("death")
	kill_player()

func _ready():
	# hide the thingy
	Globals.crouch_expire.connect(_on_crouch_expire)
	hide()

func show_death_screen():
	# Make the death screen visible
	show()
	
	# Pause the game (optional)
	get_tree().paused = true

func hide_death_screen():
	# Hide the death screen
	hide()
	
	# Unpause the game (if you paused it)
	get_tree().paused = false
	

# Example function to call when player dies (call this from your player script)
func kill_player():
	show_death_screen()

# LOL on_button_button_down
func _on_button_button_down() :
	# Unpause the game first
	print("reloading")
	hide_death_screen()
	
	# Reload the current scene (restart level)
	get_tree().reload_current_scene() # Replace with function body.
	restart()

func restart():
	pass
	#get_tree().call_group("player", "go_home")
