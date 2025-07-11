extends Area2D

@export var orb_id: String
@export var background: Texture2D
@export var foreground: Texture2D
@export var message_text: RichTextLabel

@onready var prompt = $Label

var is_player_in_area := false
var is_collected := false

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.is_in_group("player") and not is_collected:
		is_player_in_area = true
		prompt.visible = true
		print("Entered by:", body.name)

func _on_body_exited(body):
	if body.is_in_group("player"):
		is_player_in_area = false
		prompt.visible = false

func _process(delta):
	if is_player_in_area and not is_collected and Input.is_action_just_pressed("ui_accept"):
		prompt.visible = false # hide the prompt on use
		var sfx_selection = ["Dive1","Dive2","Dive3","Dive4"].pick_random()
		SoundManager.play_sfx(sfx_selection,0,-10)
		reveal_popup()
		is_collected = true
		queue_free()

func reveal_popup():
	var popup = preload("res://Scenes/orb_popup.tscn").instantiate()
	popup.call_deferred("set_content", background, foreground, message_text)
	var parent = get_parent()
	var popup_holder = parent.get_parent().get_node("PopupHolder")
	popup_holder.add_child(popup)
