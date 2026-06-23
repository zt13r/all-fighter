class_name JumpState
extends State


func enter() -> void:
	pass


func exit() -> void:
	pass


func process() -> void:
	_propagate_state()


func physics_process() -> void:
	character.velocity.y -= character.jump_velocity
	_propagate_state()
	_handle_transitions()


func _handle_transitions() -> void:
	pass
