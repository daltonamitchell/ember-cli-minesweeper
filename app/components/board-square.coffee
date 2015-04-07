`import Ember from "ember"`

offByOne = (value, target) ->
	true if value is (target + 1) or
			value is (target - 1)

isNearby = (current, target) ->
	# Row off by 1 and cols match
	true if offByOne( current.get('row'), target.get('row') ) and
		current.get('col') is target.get('col') or

		# Col off by 1 and rows match
		offByOne( current.get('col'), target.get('col') ) and
		current.get('row') is target.get('row') or

		# Row and col off by 1 
		offByOne( current.get('row'), target.get('row') ) and
		offByOne( current.get('col'), target.get('col') )

clickIfEmpty = (origSquare) ->
	# Click square if no mine
	origSquare.set('wasClicked', true) unless origSquare.get('hasMine') or origSquare.get('wasClicked')

	# Track nearest squares
	squares = origSquare.get 'board.squares'
	nearbySquares = squares.filter (square) ->
		isNearby( square, origSquare )

	# Holds value of total mines nearby
	nearbyMines = nearbySquares.filterBy 'hasMine'

	# Nearby squares that haven't been clicked yet
	nearbyUnclicked = nearbySquares.filterBy 'wasClicked', false

	# Make a recursive call to all nearby mines
	if nearbyMines.length is 0
		nearbyUnclicked.forEach (square) ->
			clickIfEmpty square

BoardSquare = Ember.Component.extend
	actions:
		checkForMine: ->
			# Mark a turn
			this.sendAction('takeTurn')

			if this.get('model.hasMine')
				# Fire gameOver Action on controller
				this.sendAction('action')
			else
				# Click square and attempt a cascade
				if @get('nearbyMines.length') is 0
					@get('nearbySquares').forEach clickIfEmpty
		setFlag: ->
			# Mark a turn
			this.sendAction('takeTurn')

			# Check flags left
			board = this.get('model').get('board')
			flagsLeft = board.get('flags')
			minesLeft = board.get('mines')

			# Get current flagged state of this square
			currentFlag = this.get('model.isFlagged')

			# Are flags left or are you unsetting a previously set flag?
			if flagsLeft or currentFlag isnt false
				# Set the opposite
				this.set('model.isFlagged', !currentFlag)

				# Update game counts
				if currentFlag
					flagsLeft++
					minesLeft++ if this.get('model.hasMine')
				else
					flagsLeft--
					minesLeft-- if this.get('model.hasMine')
				board.set('flags', flagsLeft)

				# Update mines remaining if flagging a square with a mine
				board.set('mines', minesLeft) if this.get('model.hasMine')
			else
				# Can't flag anymore
				alert("You don't have any flags left!")

	# Change styling when clicked
	classNameBindings: ['wasClicked', 'isFlagged', 'showMine', 'hasMine']

	# Track click events
	click: ->
		# Check if square has already been clicked or currently has a flag
		unless @get('wasClicked') or @get('model.isFlagged') or @get('model.showMine')
			@set('wasClicked', true)
			@send 'checkForMine'
	mouseDown: (event) ->
		if (event.which is 3)
			unless @get('wasClicked') or @get('model.showMine')
				event.preventDefault()
				this.send 'setFlag'

	# Track if this square has been clicked yet
	wasClicked: Ember.computed.alias 'model.wasClicked'
	isFlagged: Ember.computed.alias 'model.isFlagged'
	showMine: Ember.computed.alias 'model.showMine'
	hasMine: Ember.computed.alias 'model.hasMine'

	# Track nearest squares
	squares: Ember.computed.alias 'model.board.squares'
	nearbySquares: Ember.computed.filter 'squares', (square) ->
		isNearby( square, this.get('model') )

	# Holds value of total mines nearby
	nearbyMines: Ember.computed.filterBy 'nearbySquares', 'hasMine'

	# Nearby squares that haven't been clicked yet
	nearbyUnclicked: Ember.computed.filterBy 'nearbySquares', 'wasClicked', false

`export default BoardSquare`