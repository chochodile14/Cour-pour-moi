class_name Player
extends CharacterBody2D

@onready var animation : AnimatedSprite2D = $AnimatedSprite2D
const SPEED:float= 300.0
enum Type {IDLE ,WALK, DEATH, ATTACK}
var type : Type = Type.IDLE
var target : Monster = null
var Projectil : Arrow = null
@export var dammage : int = 5
@export var arrow_scene: PackedScene
@export var shoot_couldown: float = 0.5
var can_shoot : bool = true
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
		Type.DEATH:
			animation.modulate = Color.FIREBRICK
			await get_tree().create_timer(0.2).timeout
			animation.modulate = Color.POWDER_BLUE
			get_tree().quit()
		Type.ATTACK:
			animation.play("Shoot")
			var target: Monster = get_nearest_monster()
			if target:
				fire_at(target.global_position)

func take_damage(amount:int):
	Global.Healt -= amount
	if Global.Healt == 0:
		type=Type.DEATH

func fire_at(target_position : Vector2):
	if can_shoot:
		return
	can_shoot = false
	var arrow: Arrow = arrow_scene.instantiate() as Arrow
	get_tree().current_scene.add_child(arrow)
	arrow.shoot(global_position, target_position)
	await  get_tree().create_timer(shoot_couldown).timeout
	can_shoot = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Monster:
		type = Type.ATTACK

func get_nearest_monster():
	var nearest : Monster = null
	var best_distance : float = INF
	for node in get_tree().get_nodes_in_group("monsters"):
		var monster := node as Monster
		var distance : float = global_position.distance_to(monster.global_position)
		if distance < best_distance:
			best_distance = distance
			nearest = monster
	return nearest
