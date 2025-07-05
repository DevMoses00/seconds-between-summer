extends Node

@export var two : MarginContainer
@export var three : MarginContainer
@export var four : MarginContainer
@export var five : MarginContainer
@export var six : MarginContainer
@export var seven : MarginContainer

var keyword_start:bool = false

var count_number:int = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Controller.initialize_level()
	if SoundManager.is_playing("BG_Water") == false:
		SoundManager.fade_in_bgs("BG_Water",2.0,0,-20)
	await get_tree().create_timer(2).timeout
	fade_tween_out($WhiteScreen)
	DialogueManager.readJSON("res://Dialogue/SBS_dialogue.json")
	DialogueManager.conclusion_over.connect(show_dossier)
	Controller.dossier_completed.connect(endgame)
	await get_tree().create_timer(2).timeout
	#dialogue_go("Conclusion")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func dialogue_go(dialogue_key):
	DialogueManager.dialogue_player(dialogue_key)
	
func _on_background_timer_timeout() -> void:
	var fadeTween = get_tree().create_tween()
	fadeTween.tween_property($BackgroundPast,"modulate",Color(1.0, 1.0, 1.0, 1.0), 2)
	fadeTween.tween_interval(5)
	fadeTween.tween_property($BackgroundPast,"modulate",Color(1.0, 1.0, 1.0, 0.0), 2)
	await get_tree().create_timer(14).timeout
	$BackgroundTimer.start()

func on_all_keywords_collected():
	if keyword_start == false:
		count_number +=1
		keyword_start = true
		await get_tree().create_timer(5).timeout
		print(count_number)
		if count_number == 2: 
			two.show()
			var sfx_selection = ["Dive1","Dive2","Dive3","Dive4"].pick_random()
			SoundManager.play_sfx(sfx_selection,0,-10)
			keyword_start = false
		elif count_number == 3:
			three.show()
			var sfx_selection = ["Dive1","Dive2","Dive3","Dive4"].pick_random()
			SoundManager.play_sfx(sfx_selection,0,-10)
			keyword_start = false
		elif count_number == 4:
			var sfx_selection = ["Dive1","Dive2","Dive3","Dive4"].pick_random()
			SoundManager.play_sfx(sfx_selection,0,-10)
			four.show()
			keyword_start = false
		elif count_number == 5:
			var sfx_selection = ["Dive1","Dive2","Dive3","Dive4"].pick_random()
			SoundManager.play_sfx(sfx_selection,0,-10)
			five.show()
			keyword_start = false
		elif count_number == 6:
			var sfx_selection = ["Dive1","Dive2","Dive3","Dive4"].pick_random()
			SoundManager.play_sfx(sfx_selection,0,-10)
			six.show()
			keyword_start = false
		elif count_number == 7:
			var sfx_selection = ["Dive1","Dive2","Dive3","Dive4"].pick_random()
			SoundManager.play_sfx(sfx_selection,0,-10)
			seven.show()
			keyword_start = false
		else:
			await get_tree().create_timer(2).timeout
			SoundManager.fade_in_bgm("Conclusion",3.0,0,-20)
			dialogue_go("Conclusion")

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
func show_dossier():
	$EndDossier.show()

func endgame():
	await get_tree().create_timer(2).timeout
	fade_tween_out($EndDossier)
	fade_tween_in($WhiteScreen)
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Scenes/end.tscn")
	pass
