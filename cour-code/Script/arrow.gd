class_name Arrow
extends Node2D
@export var dammage: int = 10
@export var speed: float = 500.0
@onready var sprite : Sprite2D = $Sprite2D
@export var lifetime : float = 3.0
var direction: Vector2 = Vector2.RIGHT
var shoot_on = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().create_timer(lifetime).timeout.connect(queue_free)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func shoot(from: Vector2, to: Vector2):
	global_position = from
	direction = from.direction_to(to)
	rotation = direction.angle()

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Monster:
		(body as Monster).take_damage(dammage)
		queue_free()
