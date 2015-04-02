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

			# Get current flagged state of this square
			currentFlag = this.get('model.isFlagged')

			# Are flags left or are you unsetting a previously set flag?
			if flagsLeft or currentFlag isnt false
				# Set the opposite
				this.set('model.isFlagged', !currentFlag)

				# Update flags count
				if currentFlag
					value = flagsLeft + 1
				else
					value = flagsLeft - 1
				board.set('flags', value)
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