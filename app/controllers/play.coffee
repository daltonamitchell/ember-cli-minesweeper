`import Ember from "ember"`

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
		board = this.store.createRecord 'game-board',
			mines: level.mines
			flags: level.flags
			rows: level.rows
			cols: level.cols
		this.set('model', board)
	).observes 'level'

	# Set counters
	minesLeft: Ember.computed.alias 'model.mines'
	flagsLeft: Ember.computed.alias 'model.flags'
	timeSpent: 0
	turns: 0



`export default PlayController`