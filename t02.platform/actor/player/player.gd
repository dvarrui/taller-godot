extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -250.0
var state = "idle"
@onready var anim = $anim

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$sound/jump.pitch_scale = randf_range(0.8, 1.2)
		$sound/jump.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("player_left", "player_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	update_anim(direction)
	move_and_slide()

func update_anim(direction):
	if !is_on_floor():
		if velocity.y < 0:
			state = "jump"
		else:
			state = "fall"
	else:
		state= "idle"
		if direction:
			state = "run"

	if direction > 0:
		anim.flip_h = false
	elif direction < 0:
		anim.flip_h = true

	anim.play(state)
