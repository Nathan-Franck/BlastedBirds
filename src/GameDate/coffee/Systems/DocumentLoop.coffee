class exports.DocumentLoop extends System
	constructor: (@update) ->
		#window.onfocus = @mainLoop
		@mainLoop()
	mainLoop: () =>
		@update()
		#if document.hasFocus()
		requestAnimationFrame(@mainLoop)