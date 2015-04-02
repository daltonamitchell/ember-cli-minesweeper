`import Ember from "ember"`

BoardSquare = Ember.Component.extend
	actions:
		checkForMine: ->
			coords = "(#{ this.get('model.row') }, #{ this.get('model.col') })"
			if this.get('model.hasMine')
			# Fire gameOver Action on controller
			then this.sendAction('action')
			# Show mine count in nearby squares
			else console.log('Still kickin...', coords)  
		setFlag: ->
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

	click: ->
		this.send 'checkForMine'
	mouseDown: (event) ->
		if (event.which is 3)
			event.preventDefault()
			this.send 'setFlag'


`export default BoardSquare`