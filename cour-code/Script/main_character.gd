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
@export var attack_range: float = 400.0
var can_shoot : bool = true
func _process(delta: float) -> void:
	pass

func _physics_process(delta) -> void:
	if type == Type.DEATH:
		return
	var direction: Vector2 = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * SPEED
	if direction.x != 0:
		animation.flip_h = direction.x < 0
	var nearest: Monster = get_nearest_monster()
	var in_range :bool = nearest != null and global_position.distance_to(nearest.global_position) <= attack_range
	if in_range:
		fire_at(nearest.global_position)
	if direction == Vector2.ZERO:
		type = Type.IDLE
	else:
		type = Type.WALK
	pass
	match  type:
		Type.WALK:
			animation.play("Walk")
			move_and_slide()
		Type.IDLE:
			animation.play("Iddle")
		Type.ATTACK:
			animation.play("Shoot")

func die():
	type = Type.DEATH
	animation.modulate = Color.FIREBRICK
	await get_tree().create_timer(0.2).timeout
	animation.modulate = Color.POWDER_BLUE
	await get_tree().create_timer(0.2).timeout
	get_tree().quit()



func take_damage(amount:int):
	if type == Type.DEATH:
		return
	Global.Healt -= amount
	if Global.Healt == 0:
		die()

func fire_at(target_position : Vector2):
	if not can_shoot:
		return
	can_shoot = false
	var arrow: Arrow = arrow_scene.instantiate() as Arrow
	get_tree().current_scene.add_child(arrow)
	arrow.shoot(global_position, target_position)
	await  get_tree().create_timer(shoot_couldown).timeout
	can_shoot = true


func get_nearest_monster():
	var nearest : Monster = null
	var best_distance : float = INF
	for node in get_tree().get_nodes_in_group("monsters"):
		var monster := node as Monster
		if monster.state == Monster.State.DEATH:
			continue
		var distance : float = global_position.distance_to(monster.global_position)
		if distance < best_distance:
			best_distance = distance
			nearest = monster
	return nearest
