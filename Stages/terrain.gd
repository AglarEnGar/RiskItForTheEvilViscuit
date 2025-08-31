extends Area2D

@export var target_tilemap_layer: int = 0  # Set this to the layer you want to detect
@export var player_path: NodePath  # Drag your player node here in the inspector

var player: CharacterBody2D
var tilemap: TileMap

func _ready():
	# Get the tilemap (assuming this script is attached to the tilemap or a child of it)
	tilemap = get_parent() as TileMap
	if not tilemap:
		push_error("This script should be attached to a TileMap or its child")
		return
	
	# Get the player
	player = get_node(player_path) as CharacterBody2D
	if not player:
		push_error("Player node not found")
		return
	
	# Connect the area entered signal
	connect("body_entered", _on_body_entered)

func _on_body_entered(body: Node2D):
	if body == player:
		var player_position = player.global_position
		var tile_position = tilemap.local_to_map(tilemap.to_local(player_position))
		
		# Get the data for the tile at the player's position
		var tile_data = tilemap.get_cell_tile_data(target_tilemap_layer, tile_position)
		
		if tile_data:
			# Player is standing on the target layer
			handle_special_tile()

func handle_special_tile():
	print("Player stepped on special tile!")
	# Add your custom behavior here, for example:
	# - Damage the player
	# - Heal the player
	# - Trigger an event
	# - Play a sound
	# - Change scene
