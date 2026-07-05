class_name CrouchState
extends State


var direction : float = 0.0

var moving : bool = false


func enter() -> void:
	_propagate_enter()

	direction = 0.0
	moving = false
	character.sprite.play("crouch_idle")


func exit() -> void:
	direction = 0.0
	moving = false

	_propagate_exit()


func process() -> void:
	_propagate_process()


func physics_process() -> void:
	_propagate_physics_process()

	if has_parent_state():
		direction = parent_state.direction
	character.velocity.x = direction * character.crouch_speed

	# Walking while crouching animation
	if character.velocity.x != 0.0 and not moving:
		character.sprite.play("crouch_walk")
		moving = true
	elif character.velocity.x == 0.0 and moving:
		character.sprite.play("crouch_idle")
		moving = false

	_handle_transitions()


func _handle_transitions() -> void:
	if not Input.is_action_pressed("crouch"):
		state_changed.emit(self, "idle")
