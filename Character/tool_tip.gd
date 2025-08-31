extends PanelContainer
@onready var timer = $Timer

func _ready() :
	show()
	timer.timeout.connect(_on_timer_timeout)
	timer.start(4)  # Start timer for 3 seconds

func _on_timer_timeout():
	# Your code here
	hide()
	print("timer finished")
	timer.stop()
	# Example: change scene, spawn object, etc.
