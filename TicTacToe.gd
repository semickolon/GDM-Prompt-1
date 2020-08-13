extends Control

onready var prompt = $Prompt

func _ready():
	prompt.write_line("=== Tic Tac Toe ===", Color.lightcyan)
	
	var board := Board.new()
	var cur_symbol = "O" if randf() < 0.5 else "X"
	
	while true:
		prompt.write_line(board.to_string(), Color.orange)
		
		var message = "Enter coord for %s: " % [cur_symbol]
		var coord = yield(read_coord(message, board), "completed")
		board.place(coord[0], coord[1], cur_symbol)
		
		var winner = board.get_winner()
		if winner != null:
			prompt.write_line("------------")
			prompt.write_line("%s wins!" % [winner], Color.green)
			break
		else:
			cur_symbol = "X" if cur_symbol == "O" else "O"
			prompt.write_line()

func read_coord(prefix: String, board: Board):
	while true:
		prompt.write(prefix, Color.gray)
		var raw_coord: String = yield(prompt.read_line(), "completed")
		prompt.write_line(raw_coord)
		
		var coord: Array = parse_coord(raw_coord)
		if coord.size() == 2:
			if board.is_empty(coord[0], coord[1]):
				return coord
			else:
				prompt.write_line("Slot taken!", Color.red)
		else:
			prompt.write_line("Invalid coord!", Color.red)

func parse_coord(s: String) -> Array:
	var sp := s.split(",")
	if sp.size() < 2:
		return []
	
	var row = int(sp[0].strip_edges()) - 1
	var col = int(sp[1].strip_edges()) - 1
	if row < 0 or row > 2 or col < 0 or col > 2:
		return []
	
	return [row, col]

class Board:
	var _data = [
		[null, null, null],
		[null, null, null],
		[null, null, null]
	]
	
	func is_empty(row: int, col: int) -> bool:
		return _data[row][col] == null
	
	func place(row: int, col: int, symbol: String):
		assert(symbol == "X" or symbol == "O")
		_data[row][col] = symbol
	
	func get_winner():
		var arrays := []
		
		for i in range(0, 3):
			arrays.append(_get_row(i))
			arrays.append(_get_col(i))
		
		arrays.append([_data[0][0], _data[1][1], _data[2][2]])
		arrays.append([_data[2][0], _data[1][1], _data[0][2]])
		
		for arr in arrays:
			if _has_common_element(arr) and arr[0] != null:
				return arr[0]
		
		return null
	
	func to_string() -> String:
		var s := ""
		s += _row_to_string(0)
		s += "\n-----\n"
		s += _row_to_string(1)
		s += "\n-----\n"
		s += _row_to_string(2)
		return s
	
	func _row_to_string(row: int) -> String:
		var s = ""
		for i in range(3):
			var e = _data[row][i]
			s += " " if e == null else e
			if i < 2:
				s += "|"
		return s
	
	func _get_row(i: int) -> Array:
		return _data[i]
	
	func _get_col(i: int) -> Array:
		return [_data[0][i], _data[1][i], _data[2][i]]
	
	func _has_common_element(arr: Array) -> bool:
		if arr.size() < 2:
			return true
		
		for i in range(1, arr.size()):
			if arr[0] != arr[i]:
				return false
		
		return true
