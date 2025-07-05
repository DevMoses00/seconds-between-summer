extends CanvasLayer

@onready var image_b = $CenterContainer/PanelContainer/VBoxContainer/Control/Background
@onready var image_b_wrapper = $CenterContainer/PanelContainer/VBoxContainer/Control
@onready var image_f = $CenterContainer/PanelContainer/VBoxContainer/ControlFore/Foreground
@onready var image_f_wrapper = $CenterContainer/PanelContainer/VBoxContainer/ControlFore
@onready var label = $CenterContainer/PanelContainer/VBoxContainer/Control2/MarginContainer/SourceDocument
@onready var container = $CenterContainer/PanelContainer/VBoxContainer

var drift_amplitude := 8.0 # pixels
var drift_speed := 1.5 #oscillation speed

signal character_selected

func set_content(background: Texture2D, foreground:Texture2D, text_bbcode: RichTextLabel):
	print("Image node is:", background)
	image_b.texture = background
	image_f.texture = foreground
	
	label.bbcode_enabled = true
	label.text = text_bbcode.text


func _input(event):
	pass

func _process(delta: float) -> void:
	var t = Time.get_ticks_msec() / 1000.0
	#image_b_wrapper.position.x = (sin(t * drift_speed) * drift_amplitude) - 5.0
	image_f_wrapper.position.x = (sin(t * drift_speed * 0.8) * drift_amplitude) -5

func on_all_keywords_collected():
	print("✅ All keywords clicked, closing popup...")
	var tween = create_tween()
	tween.tween_property($ColorRect, "modulate:a",0,3)
	tween.parallel().tween_property(container,"modulate:a",0,3)
	await get_tree().create_timer(5).timeout
	queue_free()  # Or fade out, hide, etc.
