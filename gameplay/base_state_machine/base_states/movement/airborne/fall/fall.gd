class_name FallState 
extends State


var direction : float = 0.0
var gravity_multiplier : float = 0.0

#var actually_falling : bool = false


func enter() -> void:
	_propagate_enter()

	direction = 0.0
	gravity_multiplier = 0.0
	#actually_falling = true

	# Delay before changing animations from "jump" to "fall"
	await get_tree().create_timer(0.04).timeout
	character.sprite.play("fall")


func exit() -> void:
	direction = 0.0
	gravity_multiplier = 0.0
	#actually_falling = false

	_propagate_exit()


func process() -> void:
	_propagate_process()


func physics_process() -> void:
	_propagate_physics_process()

	# Fall faster
	if Input.is_action_pressed("crouch"):
		gravity_multiplier = 5.0
	else:
		gravity_multiplier = 1.0

	# Falling
	character.velocity.y += Util.GRAVITY * gravity_multiplier

	## Play "fall" animation only when actually falling (velocity.y > 0)
	#if character.velocity.y > 0.0 and actually_falling:
		#character.sprite.play("fall")
		#actually_falling = false
		## ^^^ Ensures this code block only runs once
		## Idk, optimization? /probably saves like 1 byte of memory idk

	# Moving
	if has_parent_state():
		direction = parent_state.direction
	character.velocity.x = direction * character.movement_speed

	# Jump buffer
	if Input.is_action_just_pressed("jump"):
		character.jump_buffer_timer.start()

	_handle_transitions()


func _handle_transitions() -> void:
	pass
