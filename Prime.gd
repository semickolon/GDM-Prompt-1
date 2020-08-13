extends Node

onready var prompt = $Prompt

func _ready():
	prompt.write_line("=== Prime? ===", Color.lightpink)
	
	while true:
		var n: int = yield(read_int("Enter number: "), "completed")
		prompt.write_line("YES" if is_prime(n) else "NO", Color.green)

func is_prime(n: int) -> bool:
	if n < 2:
		return false
	
	for i in range(2, int(ceil(sqrt(n)))):
		if n % i == 0:
			return false
	
	return true

func read_int(prefix: String):
	while true:
		prompt.write(prefix, Color.gray)
		var s: String = yield(prompt.read_line(), "completed")
		prompt.write_line(s)
		
		if s.is_valid_integer():
			return int(s)
		else:
			prompt.write_line("Invalid number!", Color.red)
