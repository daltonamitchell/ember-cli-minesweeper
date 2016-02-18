`import DS from "ember-data"`

attr = DS.attr

SquareModel = DS.Model.extend
	hasMine: attr 'boolean', default: false
	isFlagged: attr 'boolean', default: false
	wasClicked: attr 'boolean', default: false
	row: attr 'number'
	col: attr 'number'
	board: DS.belongsTo 'game-board', async: false

`export default SquareModel`
