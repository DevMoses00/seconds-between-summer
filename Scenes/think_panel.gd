extends Control

var locked_wall:bool = false
var wall_count = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Controller.dossier_completed.connect(locked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func locked():
	if locked_wall == false:
		wall_count += 1
		SoundManager.play_mfx("Correct")
		print(wall_count)
		locked_wall = true
		await get_tree().create_timer(0.5).timeout
		SoundManager.play_mfx("Correct")
		locked_wall = false
	if wall_count == 2: 
		await get_tree().create_timer(2).timeout
		fade_tween_out($"ResearchArea/Past Dossier")
		fade_tween_out($"ResearchArea/Future Dossier")
		await get_tree().create_timer(2).timeout
		fade_tween_in($WhiteScreen)
		SoundManager.fade_out("Aura",3.0)
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://Scenes/conclusion.tscn")




# HELPER FUNCTIONS
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
