extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var isjumping = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		isjumping = false

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		isjumping=true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if !isjumping:
			$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("default")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
