extends Node2D

@onready var player = $Player
@onready var world_objects = $WorldObjects

var player_max_offset := 80.0  # how far the player can float from center
var player_float_return_speed := 3.0
var world_drift_speed := 100.0

var velocity := Vector2.ZERO

func receive_input(dir: Vector2):
	velocity = dir.normalized()

var drift_velocity := Vector2.ZERO
var drag := 0.92

func _process(delta):
	# Movement physics
	drift_velocity = drift_velocity.lerp(velocity * world_drift_speed, 0.1)
	drift_velocity *= drag

	world_objects.position -= drift_velocity * delta

	# Player float
	var target_offset = velocity * player_max_offset
	player.position = player.position.lerp(target_offset, player_float_return_speed * delta)
