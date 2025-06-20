extends Control



func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event):
	var dir := Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		dir.x += 20
	if Input.is_action_pressed("ui_left"):
		dir.x -= 20
	if Input.is_action_pressed("ui_down"):
		dir.y += 20
	if Input.is_action_pressed("ui_up"):
		dir.y -= 20

	$SubViewportContainer1/SubViewport1/World1.receive_input(dir)
	$SubViewportContainer2/SubViewport2/World2.receive_input(dir)


# for the UI Buttons
func _on_texture_button_pressed() -> void:
	var panel = $UI/ThinkPanel
	panel.visible = true
	#panel.raise()  # make sure it's on top


func _on_close_button_pressed() -> void:
	var panel = $UI/ThinkPanel
	panel.visible = false
