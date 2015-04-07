`import Ember from "ember"`

NumberFormat = Ember.Handlebars.makeBoundHelper (amount) ->
  return '' unless amount
  formatted = parseInt amount
  formatted.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")

`export default NumberFormat`
