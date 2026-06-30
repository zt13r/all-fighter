class_name FallState 
extends State


var direction : float = 0.0
var gravity_multiplier : float = 0.0


func enter() -> void:
	direction = 0.0
	gravity_multiplier = 0.0


func exit() -> void:
	direction = 0.0
	gravity_multiplier = 0.0


func process() -> void:
	_propagate_state()


func physics_process() -> void:
	# Fall faster
	if Input.is_action_pressed("crouch"):
		gravity_multiplier = 5.0
	else:
		gravity_multiplier = 1.0

	# Falling
	character.velocity.y += Util.GRAVITY * gravity_multiplier

	# Moving
	direction = Input.get_axis("move_left", "move_right")
	character.velocity.x = direction * character.movement_speed
	_character_facing()

	# Jump buffer
	if Input.is_action_just_pressed("jump"):
		character.jump_buffer_timer.start()

	_propagate_state()
	_handle_transitions()


func _handle_transitions() -> void:
	pass


func _character_facing() -> void:
	match direction:
		-1: character.facing_right = false
		1: character.facing_right = true
		0: pass
		_: pass
