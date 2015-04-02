createSquare = (board, row) ->
	board.get('squares').createRecord({
		row: row
		col: col
		isFlagged: false
		hasMine: false
		wasClicked: false
	}) for col in [board.get('cols')..1]

makeSquares = (board) ->
	# Create object for each row/col
	# Attach to board object
	createSquare(board, row) for row in [board.get('rows')..1] 
	board

`export default makeSquares`