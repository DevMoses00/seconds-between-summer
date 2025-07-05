extends CharacterBody2D

@onready var sprite = $Sprite
@onready var shadow_sprite = $ShadowSprite


enum SwimState { IDLE, STRETCH1, SIDE1, STRETCH2, SIDE2 }
var swim_state = SwimState.IDLE
var stretch_timer = 0.0
var stretch_frame_time = 0.20


var rotate_speed = 30.0  # Degrees/sec
var swim_speed = 100.0   # Movement speed

func _process(delta):
	var rotating = false

	# Rotation input
	if Input.is_action_pressed("ui_left"):
		rotation_degrees -= rotate_speed * delta
		SoundManager.play_sfx("Stretch",0,-10)
		play_stretch_loop(true)
		rotating = true
	elif Input.is_action_pressed("ui_right"):
		rotation_degrees += rotate_speed * delta
		play_stretch_loop(false)
		rotating = true

	# Swim forward
	if Input.is_action_pressed("ui_up"):
		play_swim_sequence(delta)
		var dir = Vector2.RIGHT.rotated(rotation)
		velocity = dir * swim_speed
		#move_and_slide()
	elif not rotating:
		sprite.stop()
		shadow_sprite.stop()
		velocity = Vector2.ZERO
		swim_state = SwimState.IDLE
		stretch_timer = 0.0

	# Sync shadow position and rotation
	#shadow_sprite.global_position = global_position + Vector2(0, 4)
	#shadow_sprite.rotation_degrees = rotation_degrees

func play_stretch_loop(left: bool):
	
	sprite.animation = "stretch_pingpong"
	sprite.flip_h = left
	sprite.play()

	shadow_sprite.animation = sprite.animation
	shadow_sprite.flip_h = sprite.flip_h
	shadow_sprite.play()

func play_swim_sequence(delta):
	match swim_state:
		SwimState.IDLE:
			show_stretch()
			swim_state = SwimState.STRETCH1

		SwimState.STRETCH1:
			stretch_timer += delta
			if stretch_timer >= stretch_frame_time:
				sprite.animation = "swim_side"
				sprite.flip_h = false
				sprite.play()
				var sfx = ["Swim1","Swim2","Swim3","Swim4"].pick_random()
				SoundManager.play_sfx(sfx)
				shadow_sprite.animation = sprite.animation
				shadow_sprite.flip_h = sprite.flip_h
				shadow_sprite.play()
				swim_state = SwimState.SIDE1

		SwimState.SIDE1:
			if not sprite.is_playing():
				show_stretch()
				swim_state = SwimState.STRETCH2

		SwimState.STRETCH2:
			stretch_timer += delta
			if stretch_timer >= stretch_frame_time:
				sprite.animation = "swim_side"
				sprite.flip_h = true
				sprite.play()
				var sfx = ["Swim1","Swim2","Swim3","Swim4"].pick_random()
				SoundManager.play_sfx(sfx)
				shadow_sprite.animation = sprite.animation
				shadow_sprite.flip_h = sprite.flip_h
				shadow_sprite.play()
				swim_state = SwimState.SIDE2

		SwimState.SIDE2:
			if not sprite.is_playing():
				show_stretch()
				swim_state = SwimState.STRETCH1

func show_stretch():
	sprite.animation = "stretch_pingpong"
	sprite.frame = 0
	sprite.play()
	stretch_timer = 0

	shadow_sprite.animation = "stretch_pingpong"
	shadow_sprite.frame = 0
	shadow_sprite.play()
