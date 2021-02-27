extends KinematicBody

export (Resource) var KeyDoorResource

export var camera_angle = 0
var mouse_sensitivity = 0.3
var camera_change = Vector2()

var walking_speed = 275
var running_speed = 475
var velocity = Vector3.ZERO
var gravity = -9.8
var direction = Vector3.ZERO
var jump_strength = 15

var in_game = false

func startGame():
	in_game = true

func endGame():
	in_game = false

func _physics_process(delta: float) -> void:
	if in_game:
		aim()
		movement(delta)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		camera_change = event.relative

func aim():
	if camera_change.length() > 0:
		rotate_y(deg2rad(-camera_change.x * mouse_sensitivity))
		var change = -camera_change.y * mouse_sensitivity
		if change + camera_angle < 90 and change + camera_angle > -90:
			$Head/Camera.rotate_x(deg2rad(change))
			camera_angle += change
		camera_change = Vector2.ZERO

func movement(delta: float):
	direction = Vector3.ZERO
	var cam_aim = $Head/Camera.get_global_transform().basis
	var aim = $Head.get_global_transform().basis
	#direction.z = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left")) * speed * delta
	#direction.x = (Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward")) * speed * delta
	
	if Input.is_action_pressed("move_left"):
		direction -= cam_aim.x
	if Input.is_action_pressed("move_right"):
		direction += cam_aim.x
	if Input.is_action_pressed("move_forward"):
		direction += aim.y
	if Input.is_action_pressed("move_backward"):
		direction -= aim.y
	
	var speed
	if Input.is_action_pressed("move_running"):
		speed = running_speed
	else:
		speed = walking_speed
	
	direction = direction.normalized()
	velocity.y += gravity * delta
	velocity.x = direction.x * speed * delta
	velocity.z = direction.z * speed * delta
	velocity = move_and_slide(velocity, Vector3.UP)
