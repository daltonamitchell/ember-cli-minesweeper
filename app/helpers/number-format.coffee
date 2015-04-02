`import Ember from "ember"`

NumberFormat = Ember.Handlebars.makeBoundHelper (amount) ->
  return 0 unless amount?
  formatted = parseInt amount
  formatted.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")

`export default NumberFormat`
