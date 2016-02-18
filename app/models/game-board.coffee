`import DS from "ember-data"`

attr = DS.attr

GameBoardModel = DS.Model.extend
	mines: attr 'number'
	flags: attr 'number'
	rows: attr 'number'
	cols: attr 'number'
	squares: DS.hasMany 'board-square', async: false 

`export default GameBoardModel`
