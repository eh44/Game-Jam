extends Area2D

signal collect

const cycle = ["bear", "fish", "eagle"]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.play("bear")
	position = Vector2(80, 400)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	match $Sprite2D.animation:
		"bear":
			position = Vector2(500, 680)
			$Sprite2D.play("fish")
		"fish":
			position = Vector2(1075, 750)
			$Sprite2D.play("eagle")
	collect.emit()
