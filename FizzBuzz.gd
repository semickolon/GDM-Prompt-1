extends Control

onready var prompt = $Prompt

func _ready():
	prompt.write_line("=== Fizz Buzz ===", Color.blanchedalmond)
	
	while true:
		var n: int = yield(read_int("Enter number: "), "completed")
		var words := []
		
		if n % 3 == 0:
			words.append("Fizz")
		if n % 5 == 0:
			words.append("Buzz")
		if words.empty():
			words.append(str(n))
		
		var line := PoolStringArray(words).join(" ")
		prompt.write_line(line, Color.green)

func read_int(prefix: String):
	while true:
		prompt.write(prefix, Color.gray)
		var s: String = yield(prompt.read_line(), "completed")
		prompt.write_line(s)
		
		if s.is_valid_integer():
			return int(s)
		else:
			prompt.write_line("Invalid number!", Color.red)
