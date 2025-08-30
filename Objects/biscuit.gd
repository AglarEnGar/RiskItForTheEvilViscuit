extends Area2D

@export var disappear_effect: PackedScene  # Optional: assign a disappearing effect

func _ready():
	connect("area_entered", _on_area_entered)
	connect("body_entered", _on_body_entered)

func _on_area_entered(area):
	if area.is_in_group("player"):
		collect()

func _on_body_entered(body):
	if body.is_in_group("player"):
		collect()

func collect():
	if disappear_effect:
		var effect = disappear_effect.instantiate()
		get_parent().add_child(effect)
		effect.global_position = global_position
	
	visible = false
	$"./Biscuit/Area2D/CollisionShape2D".disabled = true
	
	end_game()
	
	await get_tree().create_timer(0.5).timeout
	queue_free()

func end_game():
	# Your game ending logic here
	get_tree().quit()
