`import DS from "ember-data"`

attr = DS.attr

SquareModel = DS.Model.extend
	hasMine: attr 'boolean'
	isFlagged: attr 'boolean'
	row: attr 'number'
	col: attr 'number'
	board: DS.belongsTo 'game-board'

`export default SquareModel`