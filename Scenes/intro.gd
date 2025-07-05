extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# read the dialogue JSON file
	DialogueManager.readJSON("res://Dialogue/SBS_dialogue.json")
	SoundManager.fade_in_bgs("BG_Water",2.0,0,-20)
	signals_connect()
	fade_tween_out($WhiteScreen)
	await get_tree().create_timer(4).timeout
	fade_tween($Logo)
	await get_tree().create_timer(7).timeout
	dialogue_go("Intro")


func signals_connect():
	DialogueManager.intro_over.connect(start_screen)
	DialogueManager.main_over.connect(next_scene)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# HELPER FADES
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
	
func dialogue_go(dialogue_key):
	DialogueManager.dialogue_player(dialogue_key)

func _on_background_timer_timeout() -> void:
	var fadeTween = get_tree().create_tween()
	fadeTween.tween_property($BackgroundPast,"modulate",Color(1.0, 1.0, 1.0, 1.0), 2)
	fadeTween.tween_interval(5)
	fadeTween.tween_property($BackgroundPast,"modulate",Color(1.0, 1.0, 1.0, 0.0), 2)
	await get_tree().create_timer(14).timeout
	$BackgroundTimer.start()


func start_screen():
	await get_tree().create_timer(2).timeout
	SoundManager.play_bgm("Main",0,-10)
	move_title()
	#fade_tween_in($Title)
	fade_tween_in($Button)
	await get_tree().create_timer(1).timeout
	$Button.disabled = false

func move_title():
	var tween = get_tree().create_tween()
	tween.tween_property($Background/Yellow,"position:y",-60,4).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property($BackgroundPast/Orange,"position:y",-60,4).set_ease(Tween.EASE_IN_OUT)
func move_title_back():
	var tween = get_tree().create_tween()
	tween.tween_property($Background/Yellow,"position:y",-600,4).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property($BackgroundPast/Orange,"position:y",-600,4).set_ease(Tween.EASE_IN_OUT)

func next_scene():
	await get_tree().create_timer(2).timeout
	fade_tween_in($WhiteScreen)
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_button_pressed() -> void:
	await get_tree().create_timer(0.5).timeout
	SoundManager.play_mfx("Select")
	fade_tween_out($Button)
	$Button.disabled = true
	move_title_back()
	await get_tree().create_timer(4).timeout
	SoundManager.fade_into_bgm("Aura","Main",4.0,0,-20)
	dialogue_go("Main")
	pass # Repl
