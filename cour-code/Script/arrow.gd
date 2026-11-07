class_name Arrow
extends Node2D
@export var dammage: int = 10
@export var speed: float = 500

var target : Monster = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func shoot():
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Monster:
		(body as Monster).take_damage(10)
