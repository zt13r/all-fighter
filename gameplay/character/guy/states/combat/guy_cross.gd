class_name GuyCrosstate
extends State


var guy : GuyCharacter = null


func enter() -> void:
	_propagate_enter()
	guy = character as GuyCharacter
	guy.basic_attack_duration_timer.wait_time = guy.cross_duration
	guy.basic_attack_duration_timer.start()

	if root_fsm.previous_state.parent_state is AirborneState:
		pass # play "airborne cross"
	else:
		guy.sprite.play("cross") # grounded cross?


func exit() -> void:
	guy.basic_attack_combo_timer.stop()
	guy.basic_attack_duration_timer.stop()
	_propagate_exit()


func process() -> void:
	_propagate_process()


func physics_process() -> void:
	_propagate_physics_process()

	guy.hitbox.global_position = guy.cross_hitbox_position

	await guy.basic_attack_duration_timer.timeout

	_handle_transitions()


func _handle_transitions() -> void:
	state_changed.emit(self, "idle")
