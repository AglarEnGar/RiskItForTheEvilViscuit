extends Node

const CROUCH_TIME = 45.0
@onready var CrouchTimer = $CrouchTimer
@export var biscuits = 0

signal crouch_expire

func _ready():
	CrouchTimer.start(CROUCH_TIME)
	CrouchTimer.paused = true
	

func start_crouch_timer():
	CrouchTimer.paused = false

func pause_crouch_timer():
	CrouchTimer.paused = true
	
func rest_crouch_timer():
	CrouchTimer.start(CROUCH_TIME)
	CrouchTimer.paused = true

func _on_crouch_timer_timeout():
	# just propogate the signal like a dumbass
	crouch_expire.emit()
	
func dieAnyawayLol():
	crouch_expire.emit()
