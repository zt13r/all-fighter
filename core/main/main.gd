extends Node


# temporaly
const GUY_CHARACTER_UID : String = "uid://d1ksrfbf37nu8"
const TEST_ARENA_UID : String = "uid://3g1xx3na6enq"


var current_arena : Arena = null


@onready var arena_root : Node2D = %ArenaRoot
@onready var entity_root : Node2D = %EntityRoot
@onready var effect_root : Node2D = %EffectRoot

@onready var player_one_hud : Control = %Player1Hud
@onready var player_two_hud : Control = %Player2Hud

@onready var hud_layer : CanvasLayer = %HudLayer
@onready var pause_layer : CanvasLayer = %PauseLayer
@onready var menu_layer : CanvasLayer = %MenuLayer
@onready var transition_layer : CanvasLayer = %TransitionLayer


func _ready() -> void:
	_init_layers()

	# Mode selection
	# - Campaign : singleplayer story mode; "beat 'em up"
	# - PvE      : platform fighter with AI enemy
	# - PvP      : platform fighter with player enemy (local or online)

	# Player selection
	# - Campaign : idk
	# - PvE      : player can choose enemy character or randomize
	# - PvP      : 30s selection time ?

	# Arena selection
	# - Campaign : no
	# - PvE      : select arena
	# - PvP      : random arena

	# temprroroary
	_load_arena(TEST_ARENA_UID)
	_load_player(GUY_CHARACTER_UID)


func _init_layers() -> void:
	hud_layer.hide()
	pause_layer.hide()
	transition_layer.hide()
	menu_layer.show()


func _load_arena(uid : String) -> void:
	_deferred_load_arena.call_deferred(uid)


func _deferred_load_arena(uid : String) -> void:
	if current_arena != null:
		current_arena.queue_free()

	await get_tree().process_frame

	var arena_scene : PackedScene = load(uid)
	if arena_scene == null:
		push_error("Failed to load selected Arena's resource.")
		return

	current_arena = arena_scene.instantiate()
	if current_arena == null:
		push_error("Arena is null.")
		return

	arena_root.add_child(current_arena)


func _load_player(uid : String) -> void:
	_deferred_load_player.call_deferred(uid)


func _deferred_load_player(uid : String) -> void:
	await get_tree().process_frame

	var character_scene : PackedScene = load(uid)
	if character_scene == null:
		push_error("Failed to load selected Character's resource.")
		return

	var character : Character = character_scene.instantiate()
	if character == null:
		push_error("Failed to load selected Character.")
		return

	if current_arena == null:
		push_error("Arena is null.")
		return

	character.global_position = current_arena.get_player_one_spawn_location()
	entity_root.add_child(character)
