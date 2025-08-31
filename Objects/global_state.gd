extends Node

const CROUCH_TIME = 15.0
@onready var CrouchTimer = $CrouchTimer
@export var biscuits = 0

signal crouch_expire

func _ready():
	CrouchTimer.paused = true
	CrouchTimer.start(CROUCH_TIME)

func start_crouch_timer():
	CrouchTimer.paused = false

func pause_crouch_timer():
	CrouchTimer.paused = true


func _on_crouch_timer_timeout():
	# just propogate the signal like a dumbass
	crouch_expire.emit()
