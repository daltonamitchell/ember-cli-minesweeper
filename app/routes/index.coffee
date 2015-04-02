`import Ember from "ember"`

IndexRoute = Ember.Route.extend
	redirect: ->
		@transitionTo "play"

`export default IndexRoute`