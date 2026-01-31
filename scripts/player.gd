extends CharacterBody2D


const SPEED: int = 200
const GRAVITY: float = 1000.0
const JUMP_FORCE: int = 150;
const SCALE_OFFSET: float = 0.5
const shapes = ["Man", "Bear", "Fish", "Eagle"]

var shape: String = "Man"
var flag = 0
var currentShape = 0

func _ready() -> void:
	shift()
	scale = Vector2(0.7, 0.7)
	velocity.y = 0
	

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("shift_quick"):
		if currentShape < flag:
			currentShape += 1
		else: currentShape = 0
		$AnimatedSprite2D.play(shapes[currentShape])
		shift()
	
	if shape == "Man" or shape == "Bear":
		if Input.is_action_pressed("move_up"):
			if is_on_floor():
				velocity.y += -JUMP_FORCE
		elif Input.is_action_pressed("move_left"):
			$AnimatedSprite2D.flip_h = false
			position.x -= SPEED * delta
		elif Input.is_action_pressed("move_right"):
			$AnimatedSprite2D.flip_h = true
			position.x += SPEED * delta
		velocity.y += GRAVITY * delta
		position.y += velocity.y * delta
	else:
		if Input.is_action_pressed("move_left"):
			$AnimatedSprite2D.flip_h = false
			position.x -= SPEED * delta
		elif Input.is_action_pressed("move_right"):
			$AnimatedSprite2D.flip_h = true
			position.x += SPEED * delta
		if Input.is_action_pressed("move_up"):
			position.y -= SPEED * delta
		elif Input.is_action_pressed("move_down"):
			position.y += SPEED * delta
	move_and_slide()

func _on_mask_collect(currentFlag: int) -> void:
	flag += 1
	currentShape = currentFlag + 1
	shift()

func shift():
	shape = shapes[currentShape]
	$AnimatedSprite2D.play(shape)
	
	var pos: Vector2
	var rot: float
	var rad: float
	var hei: float
	var sca: Vector2
	
	match shape:
		"Man":
			pos = Vector2.ZERO
			rot = 0.0
			sca = Vector2(0.7, 0.7)
			rad = 10.0
			hei = 40.0
		"Bear":
			pos = Vector2(0.0, 16.0)
			rot = 90.0
			sca = Vector2.ONE
			rad = 14.0
			hei = 54.0
		"Fish":
			pos = Vector2.ZERO
			rot = 90.0
			sca = Vector2(0.1, 0.1)
			rad = 10.0
			hei = 40.0
		"Eagle":
			pos = Vector2(0.0, 4.0)
			rot = 90.0
			sca = Vector2(0.2, 0.2)
			rad = 2.0
			hei = 6.0
	
	$CollisionShape2D.position = pos
	$CollisionShape2D.rotation = rot
	$AnimatedSprite2D.scale = sca
	$CollisionShape2D.shape.radius = rad
	$CollisionShape2D.shape.height = hei


func _on_force_shift(area: String) -> void:
	match area:
		"air":
			if flag < 3:
				currentShape = 0
			else:
				currentShape = 3
			shift()
		"water":
			currentShape = 2
			shift()
