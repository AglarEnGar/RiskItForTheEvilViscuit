extends CharacterBody2D
@export var move_speed :float = 0
@export var ttd :float = 0

signal crouch_start
signal crouch_end

@export var start_dir : Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var initial_position: Vector2

var is_crouching: bool = false

func _ready():
	update_animation_parameters(start_dir)
	
func _on_timer_timeout():
	print("you died")

func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	update_animation_parameters(input_direction)
	velocity = input_direction*move_speed
	
	move_and_slide()
	pick_new_state()


func _input(_ev):
	if Input.is_action_just_released("crouch"):
		if is_crouching:
			Globals.pause_crouch_timer()
			crouch_end.emit()
		else:
			Globals.start_crouch_timer()
			crouch_start.emit()
		is_crouching = not is_crouching
		

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
	
func collect_item(item):
	# Handle what happens when player collects an item
	print("Player collected: ", item.item_name)
	# You might want to update score, inventory, etc.
	
