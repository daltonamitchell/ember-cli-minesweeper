randomIze = (num) ->
	# Returns a random whole number given a specified range
	Math.ceil( Math.random() * num )

plantMines = (board) ->
	# Get mines & square to set them on
	mines = board.get('mines')
	squares = board.get('squares')

	while ( mines )
		# Pick a random square (row, col)
	    rowTarget = randomIze( board.get('rows') )
	    colTarget = randomIze( board.get('cols') )

	    # Filter by row, col with no mine
	    selectedSquare = squares.filter (sq) ->
	    	(sq.get('col') is colTarget) and
	    	(sq.get('row') is rowTarget) and
	    	not sq.get('hasMine')

	    # place the mine & decrement
	    if ( selectedSquare?.get('firstObject')? )
	    	selectedSquare.get('firstObject').set('hasMine', true)
	    	mines--

	board

`export default plantMines`



