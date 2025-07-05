extends Control

@onready var player_1: CharacterBody2D = $SubViewportContainer1/SubViewport1/World1/Player
@onready var player_2: CharacterBody2D = $SubViewportContainer2/SubViewport2/World2/Player

var swim_speed = 50

func _ready():
	if SoundManager.is_playing("Aura") == false: 
		SoundManager.play_bgm("Aura",0,-20)
	if SoundManager.is_playing("BG_Water") == false:
		SoundManager.play_bgm("BG_Water",2.0,0,-20)
	await get_tree().create_timer(2).timeout
	fade_tween_out($UI/WhiteScreen)
	swimmers_appear()

func swimmers_appear():
	fade_tween_in(player_1)
	fade_tween_in(player_2)
	await get_tree().create_timer(2).timeout
	fade_tween_in($UI/TextureButton)

func _process(delta: float) -> void:
	var dir := Vector2.ZERO
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		# Get the facing direction of the player
		var forward = Vector2.RIGHT.rotated(player_1.rotation)
		input_vector += forward * swim_speed
	# Combine world drift and player-facing input
	dir = input_vector * delta
	if Input.is_action_pressed("ui_right"):
		dir.x += 2
	if Input.is_action_pressed("ui_left"):
		dir.x -= 2
	#if Input.is_action_pressed("ui_up"):
		#dir.y -= 20
		#dir = Vector2.RIGHT.rotated(rotation)
		#dir = dir * 20

	$SubViewportContainer1/SubViewport1/World1.receive_input(dir)
	$SubViewportContainer2/SubViewport2/World2.receive_input(dir)


# for the UI Buttons
func _on_texture_button_pressed() -> void:
	var panel = $UI/ThinkPanel
	panel.visible = true
	#panel.raise()  # make sure it's on top
	$UI/TextureButton.visible = false
	SoundManager.play_mfx("Think",0,-10)

func _on_close_button_pressed() -> void:
	var panel = $UI/ThinkPanel
	panel.visible = false
	$UI/TextureButton.visible = true

# HELPER TWEEN 

func fade_tween_in(image) -> void:
	var fadeTween = get_tree().create_tween()
	fadeTween.tween_property(image,"modulate",Color(1.0, 1.0, 1.0, 1.0), 2)

func fade_tween_out(image) -> void:
	var fadeTween = get_tree().create_tween()
	fadeTween.tween_property(image,"modulate",Color(1.0, 1.0, 1.0, 0.0), 2)

func dialogue_go(dialogue_key):
	DialogueManager.dialogue_player(dialogue_key)
