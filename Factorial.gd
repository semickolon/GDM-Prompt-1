extends Control

onready var prompt = $Prompt

func _ready():
	prompt.write_line("=== Factorial ===", Color.lightgoldenrod)
	
	while true:
		var n: int = yield(read_int("Enter number: "), "completed")
		prompt.write_line("%d! = %d" % [n, factorial(n)], Color.green)

func factorial(n: int) -> int:
	if n < 2:
		return 1
	# n! = n(n-1)!
	return n * factorial(n - 1)

func read_int(prefix: String):
	while true:
		prompt.write(prefix, Color.gray)
		var s: String = yield(prompt.read_line(), "completed")
		prompt.write_line(s)
		
		if s.is_valid_integer():
			return int(s)
		else:
			prompt.write_line("Invalid number!", Color.red)
