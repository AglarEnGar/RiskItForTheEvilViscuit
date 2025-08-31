extends Node

@onready var OverLevel = $OverLevel
@onready var UnderLevel = $UnderLevel

func _ready():
	show_level(OverLevel)
	hide_level(UnderLevel)

func show_level(lvl: Node2D):
	lvl.show()
	var walls = lvl.get_node("WallTiles")
	
	walls.set_deferred("collision_enabled", true)
	lvl.process_mode = Node.PROCESS_MODE_INHERIT

func hide_level(lvl: Node2D):
	lvl.hide()
	var walls = lvl.get_node("WallTiles")
	
	walls.set_deferred("collision_enabled", false)
	lvl.process_mode = Node.PROCESS_MODE_DISABLED

func _on_player_crouch_end():
	hide_level(UnderLevel)
	show_level(OverLevel)


func _on_player_crouch_start():
	hide_level(OverLevel)
	show_level(UnderLevel)
