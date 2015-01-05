class exports.Time extends System
	@time: 0
	@deltaTime: 0
	@fixedDeltaTime: 1 / 60
	@maxDeltaTime: 1 / 10
	constructor: ->
		@update()
	update: ->
		lastTime = Time.time
		Time.time = new Date().getTime() / 1000
		Time.deltaTime = Math.min Time.time - lastTime, Time.maxDeltaTime