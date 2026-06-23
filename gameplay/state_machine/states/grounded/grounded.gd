class_name GroundedState
extends State


func enter() -> void:
	pass


func exit() -> void:
	pass


func process() -> void:
	pass


func physics_process() -> void:
	_handle_transitions()


func _handle_transitions() -> void:
	if not character.is_on_floor(): # Fall
		state_changed.emit(root_fsm.current_state, "fall")
	elif Input.is_action_just_pressed("jump"): # Jump
		state_changed.emit(root_fsm.current_state, "jump")
	elif Input.is_action_just_pressed("crouch"): # Crouch
		state_changed.emit(root_fsm.current_state, "crouch")
