`import Ember from "ember"`

BoardSquare = Ember.Component.extend
	actions:
		checkForMine: ->
			coords = "(#{ this.get('model.row') }, #{ this.get('model.col') })"
			if this.get('model.hasMine')
			then console.log('Boom!!! You lose :(', coords)
			else console.log('Still kickin...', coords)  

	click: ->
		this.send 'checkForMine'

`export default BoardSquare`