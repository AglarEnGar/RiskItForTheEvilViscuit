extends CharacterBody2D
@export var move_speed :float = 0
@export var ttd :float = 0

@export var startng_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
#@onready var button: Button = $"./CanvasLayer/Button"
@onready var colorRect: ColorRect = $"./CanvasLayer/ColorRect"
@onready var crouchTime: Timer = $"./CrouchingTime"
@onready var deaths: PanelContainer = $"./ToolTip"
var initial_position: Vector2

var toggle = 0

func _ready():
	update_animation_parameters(startng_direction)
	crouchTime.timeout.connect(_on_timer_timeout)
	crouchTime.start(ttd)
	crouchTime.paused = true
	initial_position = global_position
	
	
func _on_timer_timeout():
	print("Char dies")
	colorRect.visible = false
	
	deaths.kill_player()

func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	update_animation_parameters(input_direction)
	velocity = input_direction*move_speed
	
	move_and_slide()
	pick_new_state()
	
	if toggle == 1:
		var next_sc = "res://Stages/UnderLevel.tscn"
		get_tree().change_scene_to_file(next_sc)
		#button.text = "Leave the ass dimension"
		colorRect.visible = true # Replace with function body.
		crouchTime.paused = false
		var fstring = "Crouching: %d" % crouchTime.time_left
		print(fstring)
		
	else:
		var next_sc = "res://Stages/OverLevel.tscn"
		get_tree().change_scene_to_file(next_sc)
		#button.text = "Enter the ass dimension"
		colorRect.visible = false # Replace with function body.
		crouchTime.paused = true
		var fstring = "Not Crouching: %d" % crouchTime.time_left
		print(fstring)
	
	
func _input(ev):
	if Input.is_key_pressed(KEY_C):
		toggle = 1
	elif (toggle == 1):
		toggle = 0
		

func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/walk/blend_position", move_input)
		animation_tree.set("parameters/idle/blend_position", move_input)

func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")
		
func go_home():
	global_position = initial_position
	
