extends Node2D

@onready var green = $TileMap2
@export var green_pos = Vector2i()

func _ready() -> void:
	green.position = green_pos*16

func _on_area_2d_area_entered(area: Area2D) -> void:
	#print("player stepped into portal")
	#print(area.get_parent())
	##area.get_parent().global_position.x = green.global_position.x + 8
	##area.get_parent().global_position.y = (green.global_position.y + 8)
	#area.get_parent().global_position = Vector2(
		#green.global_position.x + 8,
		#green.global_position.y + 8
	#)
	#if area.get_parent().has_node("AnimatedSprite2D"):
		#area.get_parent().get_node("AnimatedSprite2D").global_position = area.get_parent().global_position
# i think i stumbled upon a bug i couldn't fix right here (probably because of my not efficient code)
	
	print("player stepped into portal")
	var player = area.get_parent()
	
	if player.has_method("teleport"):
		await get_tree().create_timer(0.26).timeout
		player.teleport(green.global_position + Vector2(8, 8))
	
