`import Ember from "ember"`

BoardSquare = Ember.Component.extend
	actions:
		checkForMine: ->
			coords = "(#{ this.get('model.row') }, #{ this.get('model.col') })"
			if this.get('model.hasMine')
			then console.log('Boom!!! You lose :(', coords)
			else console.log('Still kickin...', coords)  
		checkForFlag: ->
			console.log 'Checking for flag...'

	click: ->
		this.send 'checkForMine'
	mouseDown: (event) ->
		if (event.which is 3)
			event.preventDefault()
			this.send 'checkForFlag'


`export default BoardSquare`