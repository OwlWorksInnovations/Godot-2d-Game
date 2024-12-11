extends CharacterBody2D


const SPEED = 700.0
const JUMP_VELOCITY = -500.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = $"."

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_pressed("left"):
		$AnimatedSprite2D.play("walking_right")
		$AnimatedSprite2D.flip_h = true
	elif Input.is_action_pressed("right"):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("walking_right")
	else:
		$AnimatedSprite2D.play("idle")

	if Input.is_action_just_pressed("phase"):
		var visible_ = true
		if visible:	
			$".".visible = false
			visible_ = false
		else:
			$".".visible = true
			visible_ = true
		

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	get_tree().reload_current_scene()
