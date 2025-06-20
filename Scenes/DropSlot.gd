extends Control

var expected_word: String = ""  # what word is correct for this slot
var current_word: String = ""   # what word was placed here

@onready var label = $Label

func _ready():
	label.text = "___"  # placeholder text

func can_drop_data(position, data):
	return typeof(data) == TYPE_STRING

func drop_data(position, data):
	current_word = data
	label.text = "[ " + data + " ]"

	# Optional: mark this slot for validation
	emit_signal("slot_filled", self)
