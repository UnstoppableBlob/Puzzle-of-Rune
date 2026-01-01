extends CharacterBody2D


@onready var anim_sprite = $AnimatedSprite2D
@onready var colshape = $CollisionShape2D


const tile_size: Vector2 = Vector2(16, 16)

var sprite_node_pos_tween: Tween

func _physics_process(delta: float) -> void:
	if !sprite_node_pos_tween or !sprite_node_pos_tween.is_running():
		if Input.is_action_pressed("up") and !$up.is_colliding():
			anim_sprite.play("walk_back")
			move(Vector2(0, -1))
		elif Input.is_action_pressed("up"):
			anim_sprite.play("up")
			
		elif Input.is_action_pressed("down") and !$down.is_colliding():
			anim_sprite.play("down")
			anim_sprite.play("walk_front")
			move(Vector2(0, 1))
		elif Input.is_action_pressed("down"):
			anim_sprite.play("down")
		elif Input.is_action_pressed("left") and !$left.is_colliding():
			anim_sprite.flip_h = true
			anim_sprite.play("right")
			anim_sprite.play("walk_right")
			move(Vector2(-1, 0))
		elif Input.is_action_pressed("left"):
			anim_sprite.flip_h = true
			anim_sprite.play("right")
		elif Input.is_action_pressed("right") and !$right.is_colliding():
			anim_sprite.flip_h = false
			anim_sprite.play("right")
			anim_sprite.play("walk_right")
			move(Vector2(1, 0))
		elif Input.is_action_pressed("right"):
			anim_sprite.flip_h = false
			anim_sprite.play("right")
	 
func move(dir: Vector2):
	global_position += dir * tile_size
	anim_sprite.global_position -= dir * tile_size
	
	if sprite_node_pos_tween:
		sprite_node_pos_tween.kill()
	sprite_node_pos_tween = create_tween()
	sprite_node_pos_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	sprite_node_pos_tween.tween_property(anim_sprite, "global_position", global_position, 0.25).set_trans(Tween.TRANS_LINEAR)
	
	
	
