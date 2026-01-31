extends CharacterBody2D


const SPEED = 200
const GRAVITY = 1000.0
const JUMPFORCE  = 150;
const shapes = ["Man", "Bear", "Fish", "Eagle"]

var shape: String = "Man"
var flag = 0
var currentShape = 0

func _ready() -> void:
	setCollision()
	velocity.y = 0
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("shift_quick"):
		if currentShape < flag:
			currentShape += 1
		else: currentShape = 0
		$AnimatedSprite2D.play(shapes[currentShape])
		setCollision()
	
	match shape:
		"Man":
			if Input.is_action_pressed("move_up"):
				if is_on_floor():
					velocity.y += -JUMPFORCE
			elif  Input.is_action_pressed("move_left"):
				$AnimatedSprite2D.flip_h = false
				position.x -= SPEED * delta
			elif  Input.is_action_pressed("move_right"):
				$AnimatedSprite2D.flip_h = true
				position.x += SPEED * delta
			velocity.y += GRAVITY * delta
			position.y += velocity.y * delta
		"Bear":
			if Input.is_action_pressed("move_up"):
				if is_on_floor():
					velocity.y += -JUMPFORCE
			elif  Input.is_action_pressed("move_left"):
				$AnimatedSprite2D.flip_h = false
				position.x -= SPEED * delta
			elif  Input.is_action_pressed("move_right"):
				$AnimatedSprite2D.flip_h = true
				position.x += SPEED * delta
			velocity.y += GRAVITY * delta
			position.y += velocity.y * delta
	move_and_slide()


func _on_mask_collect() -> void:
	match flag:
		0:
			$AnimatedSprite2D.play("Bear")
	flag += 1
	setCollision()

func setCollision():
	shape = shapes[currentShape]
	
	var pos: Vector2
	var rot: float
	var rad: float
	var hei: float
	var sca: Vector2
	
	match currentShape:
		0:
			pos = Vector2.ZERO
			rot = 0.0
			sca = Vector2.ONE
			rad = 10.0
			hei = 40.0
		1:
			pos = Vector2(0.0, 16.0)
			rot = 90.0
			sca = Vector2.ONE
			rad = 14.0
			hei = 54.0
		2:
			pos = Vector2.ZERO
			rot = 90.0
			sca = Vector2(0.1, 0.1)
			rad = 10.0
			hei = 40.0
		3:
			pos = Vector2(0.0, 2.0)
			rot = 90.0
			sca = Vector2.ONE
			rad = 2.0
			hei = 6.0
	
	$CollisionShape2D.position = pos
	$CollisionShape2D.rotation = rot
	$CollisionShape2D.scale = sca
	$CollisionShape2D.shape.radius = rad
	$CollisionShape2D.shape.height = hei
