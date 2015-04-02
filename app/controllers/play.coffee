`import Ember from "ember"`
`import makeBoard from "ember-minesweeper/utils/make-board"`
`import makeSquares from "ember-minesweeper/utils/make-squares"`
`import plantMines from "ember-minesweeper/utils/plant-mines"`

PlayController = Ember.Controller.extend
	actions:
		gameOver: ->
			alert 'Boom!!! You lose chump'
			this.transitionToRoute 'game-over'
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
			board = makeBoard.call(this, level)
			board = makeSquares.call(this, board)
			board = plantMines.call(this, board)
			this.set('model', board)
	).observes 'level'

	# Set counters
	minesLeft: Ember.computed.alias 'model.mines'
	flagsLeft: Ember.computed.alias 'model.flags'
	timeSpent: 0
	turns: 0

`export default PlayController`