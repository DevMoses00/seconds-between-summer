extends Button

var word: String

func _ready():
	text = word
	#draggable = true

func get_drag_data(position):
	var preview = Label.new()
	preview.text = word
	set_drag_preview(preview)
	return word
