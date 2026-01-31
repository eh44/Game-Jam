extends Node2D

signal forceShift
signal GAME_OVER

var flags: int = 0
var wallScene = preload("res://scripts/tile_map_layer_3.gd")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_water_entered(body: Node2D) -> void:
	if body.name == "Player":
		forceShift.emit("water")

func _on_air_entered(body: Node2D) -> void:
	if body.name == "Player":
		forceShift.emit("air")


func _on_mask_collect() -> void:
	flags += 1
	$TileMapLayer3.set_deferred("disabled", true)
	if flags >= 2:
		var wall = wallScene.instantiate()
		add_child(wall)

func _on_goal_body_entered(body: Node2D) -> void:
	GAME_OVER.emit(body)
