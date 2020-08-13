extends TextEdit

signal line_entered(line)

func _input(ev: InputEvent):
	if get_focus_owner() != self:
		return
	
	var just_pressed = ev.is_pressed() and not ev.is_echo()
	
	if Input.is_key_pressed(KEY_ENTER) and just_pressed:
		var line = text.strip_edges()
		emit_signal("line_entered", line)
		yield(get_tree(), "idle_frame")
		text = ""

func read_line():
	return yield(self, "line_entered")
