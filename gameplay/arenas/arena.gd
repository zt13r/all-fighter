class_name Arena
extends Node2D


@onready var player_one_spawn : Marker2D = %Player1Spawn
@onready var player_two_spawn : Marker2D = %Player2Spawn


func get_player_one_spawn_location() -> Vector2:
	return player_one_spawn.global_position


func get_player_two_spawn_location() -> Vector2:
	return player_two_spawn.global_position
