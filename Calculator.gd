extends Control

onready var prompt = $Prompt

func _ready():
	while true:
		prompt.clear()
		prompt.write_line("=== Calculator PRO ===", Color.aqua)
		
		var a: int = yield(read_int("Enter first number: "), "completed")
		var b: int = yield(read_int("Enter second number: "), "completed")
		var op: Operation = yield(read_op(), "completed")
		var symbol: String = op.get_symbol()
		var result: int = op.get_result(a, b)
		
		prompt.write_line("%d %s %d = %d" % [a, symbol, b, result], Color.green)
		prompt.write_line("Press Enter to restart...")
		yield(prompt.read_enter(), "completed")

func read_int(prefix: String):
	while true:
		prompt.write(prefix, Color.gray)
		var s: String = yield(prompt.read_line(), "completed")
		prompt.write_line(s)
		
		if s.is_valid_integer():
			return int(s)
		else:
			prompt.write_line("Invalid number!", Color.red)

func read_op() -> Operation:
	while true:
		prompt.write_line("(1) Add")
		prompt.write_line("(2) Subtract")
		prompt.write_line("(3) Multiply")
		prompt.write_line("(4) Divide")
		
		prompt.write("Select operation: ")
		var s: String = yield(prompt.read_line(), "completed")
		prompt.write_line(s)
		
		if s.is_valid_integer():
			var n := int(s)
			
			if n == 1:
				return AddOperation.new()
			elif n == 2:
				return SubtractOperation.new()
			elif n == 3:
				return MultiplyOperation.new()
			elif n == 4:
				return DivideOperation.new()
		
		prompt.write_line("Invalid choice!", Color.red)
	
	return Operation.new()

class Operation:
	func get_symbol() -> String:
		return ""
	
	func get_result(a, b) -> int:
		return 0

class AddOperation extends Operation:
	func get_symbol() -> String:
		return "+"
	
	func get_result(a, b) -> int:
		return a + b

class SubtractOperation extends Operation:
	func get_symbol() -> String:
		return "-"
	
	func get_result(a, b) -> int:
		return a - b

class MultiplyOperation extends Operation:
	func get_symbol() -> String:
		return "*"
	
	func get_result(a, b) -> int:
		return a * b

class DivideOperation extends Operation:
	func get_symbol() -> String:
		return "/"
	
	func get_result(a, b) -> int:
		return a / b
