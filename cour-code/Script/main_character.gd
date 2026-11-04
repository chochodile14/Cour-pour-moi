class_name Player
extends CharacterBody2D

@onready var animation : AnimatedSprite2D = $AnimatedSprite2D
const SPEED:float= 300.0
enum Type {IDLE ,WALK}
var type : Type = Type.IDLE
func _process(delta: float) -> void:
	var direction: Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	direction.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	velocity = direction * SPEED
	if direction.x != 0:
		animation.flip_h = direction.x < 0
	
	if direction == Vector2.ZERO:
		type = Type.IDLE
	else:
		type = Type.WALK
	pass
func _physics_process(delta) -> void:

	match  type:
		Type.WALK:
			animation.play("Walk")
			move_and_slide()
		Type.IDLE:
			animation.play("Iddle")
	
