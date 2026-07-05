class_name GuyCharacter
extends Character


@export_group("Basic Attack Combo Parameters")
@export var combo_window : float = 1.55

@export_subgroup("Damage")
@export var jab_damage : float = 1.0
@export var cross_damage : float = 1.8

@export_subgroup("Duration")
@export var jab_duration : float = 0.01
@export var cross_duration : float = 0.01

@export_subgroup("Hitbox Position")
@export var jab_hitbox_position : Vector2 = Vector2.ZERO
@export var cross_hitbox_position : Vector2 = Vector2.ZERO


@onready var basic_attack_combo_timer : Timer = %BasicAttackComboTimer


func _init_character() -> void:
	super()
	basic_attack_combo_timer.wait_time = combo_window
	basic_attack_combo_timer.one_shot = true

	# test ?
	_print_all_markers($HitboxMarkers)


func _print_all_markers(node : Node) -> void:
	var descendants : Array[Node] = Util.get_descendants(node)
	var markers : Array[Marker2D] = []

	for desc in descendants:
		if desc is Marker2D:
			markers.append(desc)

	print("Hitbox markers: ", markers.size())

	# to-do for all states:
	# - get hitbox marker stuff
	# - set hitbox and hurtbox to hitbox and hurtbox marker's POSITION
	# - set hitbox and hurtbox to hitbox and hurtbox marker's ROTATION
	# - profit


func _on_basic_attack_duration_timer_timeout() -> void:
	basic_attack_cooldown_timer.start()
	basic_attack_combo_timer.start()
