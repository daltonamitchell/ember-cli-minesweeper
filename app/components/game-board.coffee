`import Ember from "ember"`

GameBoardComponent = Ember.Component.extend
	actions:
		gameOver: ->
			this.sendAction()
	sortedRows: (->
		# Container to hold sorted rows
		rows = []

		# Sort these into rows, cols ASC
		squares = this.get('model.squares')

		# Sort all the things
		squares.forEach (square, index) ->
			currentRow = square.get 'row'
			if ( rows[ currentRow ] )
				rows[ currentRow ].unshift( square )
			else
				rows[ currentRow ] = [square]

		# Return sorted rows
		rows
	).property('model.squares.@each')

`export default GameBoardComponent`