`import Ember from "ember"`

PlayRoute = Ember.Route.extend
	model: ->
		this.store.createRecord 'game-board'

`export default PlayRoute`