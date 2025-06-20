extends CanvasLayer

@onready var image = $CenterContainer/PanelContainer/VBoxContainer/TextureRect
@onready var label = $CenterContainer/PanelContainer/VBoxContainer/RichTextLabel

var keyword_targets: Array[String] = []
var keyword_hits: Array[String] = []

signal keyword_clicked(word: String)

func set_content(img: Texture2D, text_bbcode: String):
	print("Image node is:", image)
	image.texture = img
	
	label.bbcode_enabled = true
	label.text = text_bbcode
	
	label.connect("meta_clicked", _on_keyword_clicked)
	
	# Find all keywords from the BBCode
	var regex = RegEx.new()
	regex.compile(r"\[keyword=(.*?)\]")
	for result in regex.search_all(text_bbcode):
		var keyword = result.get_string(1)
		if keyword not in keyword_targets:
			keyword_targets.append(keyword)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		queue_free()


func _on_keyword_clicked(meta):
	print("🟡 Clicked on keyword:", meta)
	var word = str(meta)
	if word in keyword_targets and word not in keyword_hits:
		# Add to word bank
		WordBank.add_word(word)
		keyword_hits.append(word)

		# Emit the signal so other nodes can react
		emit_signal("keyword_clicked", word)

		# Feedback: flash label color
		label.add_theme_color_override("default_color", Color.YELLOW)
		await get_tree().create_timer(0.2).timeout
		label.add_theme_color_override("default_color", Color.WHITE)

		# Optionally: update label text to show progress
		# (could strike through or gray out word)

	if keyword_hits.size() == keyword_targets.size():
		_on_all_keywords_collected()

func _on_all_keywords_collected():
	print("✅ All keywords clicked, closing popup...")
	var tween = create_tween()
	tween.tween_property($ColorRect, "modulate:a",0,2)
	await get_tree().create_timer(2).timeout
	queue_free()  # Or fade out, hide, etc.
