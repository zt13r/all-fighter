class_name GuyWalkState
extends WalkState


var guy : GuyCharacter = null


func enter() -> void:
	super()
	guy = character as GuyCharacter


func _handle_transitions() -> void:
	super()
	if Input.is_action_just_pressed("basic_attack") and guy.basic_attack_cooldown_timer.is_stopped():
		state_changed.emit(self, "jab")
