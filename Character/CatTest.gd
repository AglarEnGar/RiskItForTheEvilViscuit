extends CharacterBody2D
@export var move_speed :float = 0
@export var ttd :float = 0

signal crouch_start
signal crouch_end

@export var start_dir : Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var animCrouch = $AnimatedSprite2D

var initial_position: Vector2

var is_crouching: bool = false

func _ready():
	update_animation_parameters(start_dir)
	animCrouch.hide()
	
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
	print(Globals.CrouchTimer.time_left)

func _process(delta: float) -> void:
	var tilebelow = Vector2i(0, 0)
	var tile_source_id = 0
	if is_crouching:
		tilebelow = $"../Level/UnderLevel/Terrain".local_to_map(position)
		tile_source_id = $"../Level/UnderLevel/Terrain".get_cell_source_id(tilebelow)
	else:
		tilebelow = $"../Level/OverLevel/Terrain".local_to_map(position)
		tile_source_id = $"../Level/OverLevel/Terrain".get_cell_source_id(tilebelow)
	
	if tile_source_id != -1:
		print("Tile exists")
		Globals.dieAnyawayLol()
		

func _input(_ev):
	if Input.is_action_just_released("crouch") && not animCrouch.is_visible_in_tree() :
		if is_crouching:
			Globals.pause_crouch_timer()
			crouch_end.emit()
		else:
			Globals.start_crouch_timer()
			animCrouch.show()
			animCrouch.play("default")
			crouch_start.emit()
			
		is_crouching = not is_crouching
		

func _on_animated_sprite_2d_animation_finished() -> void:
	animCrouch.hide()

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
	
