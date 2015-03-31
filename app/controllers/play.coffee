`import Ember from "ember"`
`import makeBoard from "ember-minesweeper/utils/make-board"`
`import makeSquares from "ember-minesweeper/utils/make-squares"`

PlayController = Ember.Controller.extend
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
		board = makeBoard.call(this, level)
		board = makeSquares.call(this, board)

		this.set('model', board)
	).observes 'level'

	# Set counters
	minesLeft: Ember.computed.alias 'model.mines'
	flagsLeft: Ember.computed.alias 'model.flags'
	timeSpent: 0
	turns: 0

`export default PlayController`