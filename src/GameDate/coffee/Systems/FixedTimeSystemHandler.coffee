class exports.FixedTimeSystemHandler extends System
    constructor: (@systems) ->
        @lastUpdateTime = Time.time
    update: () ->
        delta = Math.min Time.time - @lastUpdateTime, Time.maxDeltaTime
        iterations = Math.floor delta/Time.fixedDeltaTime
        @lastUpdateTime += iterations * Time.fixedDeltaTime
        for i in [0...iterations]
            for system in @systems
                system.fixedUpdate()