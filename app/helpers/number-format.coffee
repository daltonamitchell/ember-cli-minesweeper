`import Ember from "ember"`

NumberFormat = Ember.Helper.helper (amount) ->
  return '' unless amount
  formatted = parseInt amount
  formatted.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")

`export default NumberFormat`
