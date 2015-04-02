`import Ember from "ember"`
`import makeBoard from "ember-minesweeper/utils/make-board"`
`import makeSquares from "ember-minesweeper/utils/make-squares"`
`import plantMines from "ember-minesweeper/utils/plant-mines"`

PlayController = Ember.Controller.extend
	actions:
		gameOver: ->
			alert 'Boom!!! You were blown up. No need to cry though. Pick up your limbs and try again.'
			this.transitionToRoute 'game-over'
		gameWon: ->
			alert 'Winning! Whoop whoop!!! You made it through this level, but can you beat the next?'
			this.transitionToRoute 'game-over'
		takeTurn: ->
			# Increment turns counter
			this.set('turns', this.get('turns') + 1)
		startTimer: ->
			# Start the first tick
			this.set('timeSpent', 1) if this.get('timeSpent') is 0
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
		level = this.get 'level'

		# Setup the game if a level was actually selected
		if level?
			# Reset the timer if running
			this.set('timeSpent', 0)
			board = makeBoard.call(this, level)
			board = makeSquares.call(this, board)
			board = plantMines.call(this, board)
			this.set('model', board)
	).observes 'level'

	# Set counters
	minesLeft: Ember.computed.alias 'model.mines'
	flagsLeft: Ember.computed.alias 'model.flags'
	turns: 0
	timeSpent: 0
	tick: (->
		# Don't start unless a model has been set
		if this.get('model')?
			current = this.get('timeSpent')
			self = this
			Ember.run.later ->
				self.set('timeSpent', current + 1)
			, 1000
	).observes('timeSpent')

	# All squares should be clicked and all bombs flagged
	gameWasWon: (->	
		# Check if game won
		this.send('gameWon') if this.get('minesLeft') is 0 and this.get('allSquaresClicked')
	).observes('minesLeft', 'allSquaresClicked')

	# All square should be clicked or flagged
	allSquaresClicked: (->
		squares = this.get('model.squares')
		squares.every (square) ->
			square.get('wasClicked') or square.get('isFlagged')
	).property('model.squares.@each.wasClicked', 'model.squares.@each.isFlagged')

`export default PlayController`