class_name GuyCrosstate
extends State


var guy : GuyCharacter = null


func enter() -> void:
	_propagate_enter()
	guy = character as GuyCharacter
	guy.basic_attack_duration_timer.wait_time = guy.cross_duration
	guy.basic_attack_duration_timer.start()

	guy.hitbox.damage = guy.cross_damage

	if root_fsm.previous_state.parent_state is AirborneState:
		pass # play "airborne cross"
	else:
		guy.sprite.play("cross") # grounded cross?

	# Can't walk while attacking
	guy.set_physics_process(false)


func exit() -> void:
	guy.basic_attack_combo_timer.stop()
	guy.basic_attack_duration_timer.stop()

	# Walking enabled
	guy.set_physics_process(true)

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
