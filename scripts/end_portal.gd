extends Node2D

@onready var green = $TileMap2
@export var green_pos = Vector2i()
@export var level_needed = 2

const level_2 = preload("res://scenes/level_2.tscn")
const level_3 = preload("res://scenes/level_3.tscn")
const level_4 = preload("res://scenes/level_4.tscn")
const done = preload("res://scenes/menu.tscn")


func _ready() -> void:
	green.position = green_pos*16
	green.visible = false

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
	
	print("player stepped into portal")	
	var player = area.get_parent()
	
	if player.has_method("teleport"):
		await get_tree().create_timer(0.26).timeout
		#player.teleport(green.global_position + Vector2(8, 8))
		if level_needed == 2:
			get_tree().change_scene_to_packed(level_2)
		if level_needed == 3:
			get_tree().change_scene_to_packed(level_3)
		if level_needed == 4:
			get_tree().change_scene_to_packed(level_4)
		if level_needed == 5:
			get_tree().change_scene_to_packed(done)
