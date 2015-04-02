`import Ember from "ember"`

PlayRoute = Ember.Route.extend
	actions:
		willTransition: ->
			this.send 'resetGame'
		resetGame: ->
			controller = this.controller
			board = controller.get('model')
			squares = board.get('squares')

			# Reset level
			controller.set('level', null)

			# Destroy game board
			board.destroyRecord()

			# Destroy game squares
			squares.forEach (square) ->
				square.destroyRecord()

			# Default all the things
			controller.set('turns', 0)
			controller.set('timeSpent', 0)

	setupController: (controller, model) ->
		this._super(controller, model)

		# Make sure no model is set before a level is selected
		controller.set('model', null)

`export default PlayRoute`