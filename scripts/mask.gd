extends Area2D

signal collect

var flag: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show()
	flag = 0
	$Sprite2D.play("bear")
	position = Vector2(80, 400)
	scale = Vector2(0.1, 0.1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		collect.emit(flag)
		match flag:
			0:
				position = Vector2(500, 680)
				$Sprite2D.scale = Vector2(0.5, 0.5)
				$Sprite2D.play("fish")
			1:
				position = Vector2(1060, 750)
				$Sprite2D.play("eagle")
			2:
				hide()
				$CollisionShape2D.set_deferred("disabled", true)
		flag += 1
