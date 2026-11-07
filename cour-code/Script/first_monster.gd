class_name Monster
extends RigidBody2D
var target : Player = null
@onready var animation : AnimatedSprite2D = $AnimatedSprite2D
@export var Max_Health: float = 30.0
@export var Health:float = 30.0
@export var dammage : int = 1
@export var Speed:float = 300.0

enum State {IDLE, CHASE , DEATH , WALK , ATTAKE}
@export_group("Stats")
var state = State.IDLE
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Health = Max_Health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match state:
		State.DEATH:
			animation.play("Death")
		State.WALK:
			animation.play("Walk")
		State.IDLE:
			animation.play("Idle")
		State.ATTAKE:
			animation.play("Attack")


func take_damage(amount:int):
	Health -= amount
	if Health == 0:
		state = State.DEATH


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body is Player:
		state = State.ATTAKE
		(body as Player).take_damage(dammage)
