`import Ember from "ember"`

BoardSquare = Ember.Component.extend
	actions:
		checkForMine: ->
			# Mark a turn
			this.sendAction('takeTurn')

			if this.get('model.hasMine')
			# Fire gameOver Action on controller
			then this.sendAction('action')
			# Show mine count in nearby squares
			else console.log('Still kickin...')  
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
	wasClicked: false

`export default BoardSquare`