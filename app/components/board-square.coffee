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

BoardSquare = Ember.Component.extend
	actions:
		checkForMine: ->
			# Mark a turn
			this.sendAction('takeTurn')

			if this.get('model.hasMine')
			# Fire gameOver Action on controller
			then this.sendAction('action')
			# Show mine count in nearby squares
			else this.send 'showMinesNearby'
		showMinesNearby: ->
			mines = this.get('nearbySquares.length') or 0
			this.set('nearbyMines', mines)
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
	classNameBindings: ['wasClicked', 'isFlagged']

	# Track click events
	click: ->
		# Check if square has already been clicked or currently has a flag
		unless this.get('wasClicked') or this.get('model.isFlagged')
			this.set('wasClicked', true)
			this.send 'checkForMine'
	mouseDown: (event) ->
		if (event.which is 3)
			event.preventDefault()
			this.send 'setFlag'

	# Track if this square has been clicked yet
	wasClicked: Ember.computed.alias 'model.wasClicked'
	isFlagged: Ember.computed.alias 'model.isFlagged'

	# Track nearest squares
	squares: Ember.computed.alias 'model.board.squares'
	nearbySquares: Ember.computed.filter 'squares', (square) ->
		isNearby( square, this.get('model') ) and square.get 'hasMine'

	# Holds value of total mines nearby
	nearbyMines: null

`export default BoardSquare`