extends Control

onready var display = $VBox/PanelDisplay/Display
onready var input = $VBox/PanelInput/Input

func write(s: String, color: Color = Color.white):
	display.push_color(color)
	display.add_text(s)
	display.pop()

func write_line(line: String = "", color: Color = Color.white):
	write(line + "\n", color)

func read_line():
	var line = ""
	while line.empty():
		line = yield(input.read_line(), "completed")
	return line

func read_enter():
	return yield(input.read_line(), "completed")

func clear():
	display.clear()
