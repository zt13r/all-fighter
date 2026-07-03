class_name GuyWalkState
extends WalkState


var guy : GuyCharacter = null


func enter() -> void:
	super()
	guy = character as GuyCharacter
	guy.sprite.play("walk")


func _handle_transitions() -> void:
	super()
	if Input.is_action_just_pressed("basic_attack") and (guy.basic_attack_cooldown_timer.is_stopped() and not guy.basic_attack_combo_timer.is_stopped()):
		state_changed.emit(self, "cross")
	elif Input.is_action_just_pressed("basic_attack") and guy.basic_attack_cooldown_timer.is_stopped():
		state_changed.emit(self, "jab")
