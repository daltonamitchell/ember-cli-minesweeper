`import Ember from "ember"`
`import makeBoard from "ember-minesweeper/utils/make-board"`
`import makeSquares from "ember-minesweeper/utils/make-squares"`
`import plantMines from "ember-minesweeper/utils/plant-mines"`

PlayController = Ember.Controller.extend
	actions:
		gameOver: ->
			alert 'Boom!!! You were blown up. No need to cry though. Pick up your limbs and try again.'
			@set 'gameOver', true
		gameWon: ->
			alert 'Winning! Whoop whoop!!! You made it through this level, but can you beat the next?'
			@set 'gameWon', true
		takeTurn: ->
			# Increment turns counter
			@set('turns', @get('turns') + 1)
		startTimer: ->
			# Start the first tick
			@set('timeSpent', 1) if @get('timeSpent') is 0
		resetGame: ->
			board = @get('model')
			squares = board.get('squares')

			# Reset level
			@set('level', null)

			# Destroy game board
			board.destroyRecord()

			# Destroy game squares
			squares.forEach (square) ->
				square.destroyRecord()

			# Default all the things
			@set('model', undefined)
			@set('turns', 0)
			@set('timeSpent', 0)
			@set('gameOver', false)
			@set('gameWon', false)
	levels: [
		{
			name: 'Easy'
			rows: 8
			cols: 8
			mines: 10
			flags: 13
		}
		{
			name: 'Medium'
			rows: 16
			cols: 16
			mines: 40
			flags: 50
		}
		{
			name: 'Hard'
			rows: 16
			cols: 31
			mines: 99
			flags: 125
		}
	]
	level: null
	levelDidChange: (->
		# Set properties on model
		level = @get 'level'

		# Setup the game if a level was actually selected
		if level?
			# Reset the timer if running
			@set('timeSpent', 0)
			board = makeBoard.call(this, level)
			board = makeSquares.call(this, board)
			board = plantMines.call(this, board)
			@set('model', board)
	).observes 'level'

	# Set counters
	minesLeft: Ember.computed.alias 'model.mines'
	flagsLeft: Ember.computed.alias 'model.flags'
	turns: 0
	timeSpent: 0
	tick: (->
		# Don't start unless a model has been set
		# Stop counting if game won or over
		if @get('model')? and !@get('gameWon') and !@get('gameOver')
			current = @get('timeSpent')
			self = this
			Ember.run.later ->
				self.set('timeSpent', current + 1)
			, 1000
	).observes('timeSpent')

	# All squares should be clicked and all bombs flagged
	gameWasWon: (->	
		# Check if game won
		@send('gameWon') if @get('minesLeft') is 0 and @get('allSquaresClicked')
	).observes('minesLeft', 'allSquaresClicked')

	# All square should be clicked or flagged
	allSquaresClicked: (->
		squares = this.get('model.squares')
		squares.every (square) ->
			square.get('wasClicked') or square.get('isFlagged')
	).property('model.squares.@each.wasClicked', 'model.squares.@each.isFlagged')

`export default PlayController`