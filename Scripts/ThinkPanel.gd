extends Control

var paragraph_lines := [
	["The ", "journey", " begins now."],
	["Filled with ", "hope", " and ", "change", "."]
]


# Called when the node enters the scene tree for the first time.
func _ready():
	populate_word_bank()
	setup_paragraph()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func populate_word_bank():
	for word in WordBank.collected_words:
		var word_button = preload("res://Scenes/WordButton.tscn").instantiate()
		word_button.word = word
		$WordBankContainer.add_child(word_button)


func setup_paragraph():
	for line in paragraph_lines:
		var hbox = HBoxContainer.new()
		hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		for part in line:
			if WordBank.collected_words.has(part):  # slot
				var slot = preload("res://Scenes/DropSlot.tscn").instantiate()
				slot.expected_word = part
				hbox.add_child(slot)
			else:  # static label
				var label = Label.new()
				label.text = part
				label.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
				hbox.add_child(label)

		$ParagraphArea.add_child(hbox)



func check_paragraph():
	var all_correct = true

	for row in $ParagraphArea.get_children():
		for child in row.get_children():
			if "current_word" in child and "expected_word" in child:
				if child.current_word != child.expected_word:
					all_correct = false

	if all_correct:
		print("✅ Correct!")
		# You could call: emit_signal("paragraph_completed")
		# Or fade out / show a success message
	else:
		print("❌ Incorrect, try again.")



func _on_validate_button_pressed() -> void:
	check_paragraph()
