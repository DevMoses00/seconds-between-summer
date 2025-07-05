extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade_tween_out($WhiteScreen)
	await get_tree().create_timer(4).timeout
	fade_tween_in($Thanks)
	await get_tree().create_timer(1).timeout
	fade_tween_in($Thanks2)
	await get_tree().create_timer(4).timeout
	fade_tween_in($Button)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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


func _on_button_pressed() -> void:
	await get_tree().create_timer(0.5).timeout
	SoundManager.play_mfx("Select")
	await get_tree().create_timer(3).timeout
	get_tree().quit()
