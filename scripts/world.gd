extends Node2D

@onready var tilemap = $TileMap 
@onready var player = $CharacterBody2D


var ice_states: Dictionary = {}
var processing_tiles = {}

const ICE_REGULAR = Vector2i(37, 23)  
const ICE_CRACKED = Vector2i(38, 23) 
const ICE_HOLE = Vector2i(38, 22)     

func _ready():
	for cell in tilemap.get_used_cells(0):
		var tile_data = tilemap.get_cell_atlas_coords(0, cell)
		if tile_data == ICE_REGULAR:
			ice_states[cell] = 0
	
	player.tile_stepped.connect(_on_player_stepped)

func _on_player_stepped(tile_pos: Vector2i):
	print("Stepped on tile: ", tile_pos, " - State: ", ice_states.get(tile_pos, "unknown"))
	
	if not ice_states.has(tile_pos):
		return
	
	if processing_tiles.has(tile_pos):
		print("already stepped on tile")
		return
	
	processing_tiles[tile_pos] = true
	
	var current_state = ice_states[tile_pos]
	
	#await get_tree().create_timer(0.25).timeout
	
	if current_state == 0: 
		ice_states[tile_pos] = 1
		tilemap.set_cell(0, tile_pos, 0, ICE_CRACKED)
	elif current_state == 1:  
		ice_states[tile_pos] = 2
		tilemap.set_cell(0, tile_pos, 0, ICE_HOLE)
	

	await get_tree().create_timer(0.5).timeout
	processing_tiles.erase(tile_pos)
