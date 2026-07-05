class_name GuyCrossState
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
		 # grounded cross?
		guy.sprite.play("cross")
		guy.redtangle_hitbox.shape.size = guy.cross_hitbox_size
		guy.redtangle_hitbox.global_position = guy.to_global(guy.cross_hitbox_position)

	print("c: ", guy.redtangle_hitbox.global_position)

	guy.hitbox.damage = guy.cross_damage
	guy.hitbox.enable()

	# Can't walk while attacking
	guy.set_physics_process(false)


func exit() -> void:
	guy.basic_attack_combo_timer.stop()
	guy.basic_attack_duration_timer.stop()

	# Walking enabled
	guy.set_physics_process(true)

	guy.hitbox.disable()

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
