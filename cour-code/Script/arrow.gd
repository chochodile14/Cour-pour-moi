class_name Arrow
extends Node2D
@export var dammage: int = 10
@export var speed: float = 500.0
@onready var sprite : Sprite2D = $Sprite2D
var direction: Vector2 = Vector2.RIGHT
var shoot_on = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shoot_on == true:
		return
	else:
		sprite.visible = false
		shoot_on= false

func shoot(from: Vector2, to: Vector2):
	shoot_on = true
	sprite.visible
	global_position = from
	direction = from.direction_to(to)
	rotation = direction.angle()

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Monster:
		(body as Monster).take_damage(dammage)
		queue_free()
