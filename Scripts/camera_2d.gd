extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@onready var player = $"../Player"

func _process(delta):
	global_position = player.global_position
