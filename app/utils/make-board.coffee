makeBoard = (level) ->
	this.store.createRecord 'game-board',
		mines: level.mines
		flags: level.flags
		rows: level.rows
		cols: level.cols

`export default makeBoard`
