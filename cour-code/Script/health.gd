extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("4PV")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.Healt == 3:
		$AnimatedSprite2D.play("3PV")
	elif Global.Healt== 2:
		$AnimatedSprite2D.play("2PV")
	elif Global.Healt==1:
		$AnimatedSprite2D.play("1PV")
	elif Global.Healt==0:
		$AnimatedSprite2D.play("0PV")
