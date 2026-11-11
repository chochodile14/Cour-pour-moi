class_name Monster
extends RigidBody2D
var target : Player = null
@onready var animation : AnimatedSprite2D = $AnimatedSprite2D
@export var Max_Health: float = 30.0
@export var Health:float = 30.0
@export var dammage : int = 1
@export var Speed:float = 300.0
@export var attack_couldown : float = 1.0
enum State {IDLE, CHASE , DEATH , WALK , ATTAKE}
@export_group("Stats")
var state = State.IDLE
var can_attack: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("monsters")
	Health = Max_Health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if state == State.DEATH:
		return
	if target != null:
		state = State.ATTAKE
		try_attack()
	else:
		state= State.IDLE
	match state:
		State.WALK:
			animation.play("Walk")
		State.IDLE:
			animation.play("Idle")
		State.ATTAKE:
			animation.play("Attack")

func try_attack():
	if can_attack or target == null:
		return
	can_attack = false
	target.take_damage(dammage)
	await get_tree().create_timer(attack_couldown).timeout
	can_attack = true

func take_damage(amount:int):
	if state == State.DEATH:
		return
	Health -= amount
	if Health <= 0:
		state = State.DEATH
		animation.play("Death")
		await animation.animation_finished
		queue_free()


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body is Player:
		target = body as Player

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == target:
		target = null
