extends Node2D

@onready var player = $Player
@onready var world_objects = $WorldObjects
@onready var water_material : ShaderMaterial = $Background/ParallaxLayer/Sprite2D.material

@onready var arrow = $ArrowIndicator
@export var orb_group_name := "Orbs1"  # tag or group name used on orbs

var player_max_offset := 20.0  # how far the player can float from center
var player_float_return_speed := 8.0
var world_drift_speed := 120.0

var velocity := Vector2.ZERO

func receive_input(dir: Vector2):
	velocity = dir.normalized()

var drift_velocity := Vector2.ZERO
var drag := 0.92

func _ready() -> void:
	pass

func _process(delta):
	# orb
	var nearest_orb = get_nearest_orb()
	if nearest_orb:
		var dir = (nearest_orb.global_position - player.global_position).normalized()
		arrow.rotation = dir.angle()
		arrow.global_position = player.global_position - Vector2(0,200)
	#tracking orb
	$Camera2D/Label.text = "Orbs Left: %d" % get_remaining_orbs()
	if get_remaining_orbs() == 0:
		$ArrowIndicator.visible = false
		$Camera2D/Label.visible = false
	var vel = player.get("velocity") if player.has_method("get") else Vector2.ZERO
	water_material.set_shader_parameter("player_velocity", vel)
	# Movement physics
	drift_velocity = drift_velocity.lerp(velocity * world_drift_speed, 0.1)
	drift_velocity *= drag

	world_objects.position -= drift_velocity * delta

	# Player float
	var target_offset = velocity * player_max_offset
	player.position = player.position.lerp(target_offset, player_float_return_speed * delta)

func get_nearest_orb() -> Node2D:
	var nearest: Node2D = null
	var min_dist = INF
	for orb in get_tree().get_nodes_in_group(orb_group_name):
		var dist = global_position.distance_to(orb.global_position)
		if dist < min_dist:
			min_dist = dist
			nearest = orb
	return nearest
	
func get_remaining_orbs() -> int:
	var count = 0
	for orb in get_tree().get_nodes_in_group(orb_group_name): # or whatever flag you're using
		count += 1
	return count

# HELPER TWEENS
func fade_tween(image) -> void:
	var fadeTween = get_tree().create_tween()
	fadeTween.tween_property(image,"modulate",Color(1.0, 1.0, 1.0, 1.0), 2)
	fadeTween.tween_interval(3)
	fadeTween.tween_property(image,"modulate",Color(1.0, 1.0, 1.0, 0.0), 2)

func fade_tween_in(image) -> void:
	var fadeTween = get_tree().create_tween()
	fadeTween.tween_property(image,"modulate",Color(1.0, 1.0, 1.0, 1.0), 2)

func fade_tween_out(image) -> void:
	var fadeTween = get_tree().create_tween()
	fadeTween.tween_property(image,"modulate",Color(1.0, 1.0, 1.0, 0.0), 2)
