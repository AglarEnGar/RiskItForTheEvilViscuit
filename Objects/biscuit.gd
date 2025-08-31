extends Area2D

# You can customize these in the inspector
@export var item_name = "Biscuit"
@export var value = 1



func _ready():
	# Connect the area_entered sigal
	body_entered.connect(_on_body_entered)
	
	
# Add to your collectible script
@export var spin_speed = 2.0
@export var bounce_height = 10.0
@export var bounce_speed = 3.0

var time = 0.0

func _process(delta):
	time += delta
	# Create a bouncing animation
	position.y = sin(time * bounce_speed) * bounce_height
	# Create a spinning animation
	#rotation += spin_speed * delta

func _on_body_entered(body):
	print("entered")
	# Check if the entering body is the player
	if body.is_in_group("player"):
		# Call the player's collect method if it exists
		if body.has_method("collect_item"):
			body.collect_item(self)
		
		# Or handle the collection here
		collect()

func collect():
	# Add any collection effects here (particles, sound, etc.)
	print("Collected: ", item_name)
	Globals.biscuits += 1

	# Remove the collectible from the scene
	queue_free()
