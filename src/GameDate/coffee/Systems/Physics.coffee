class Physics extends System
    constructor: () ->
        @gravity = new Vector2 0, -9.81
    update: () ->
        rigidbodies = Entity.getAll Rigidbody
        @moveAll rigidbodies
        @collideAll rigidbodies
    moveAll: (rigidbodies) ->
        for rigidbody in rigidbodies
            rigidbody.velocity.add @gravity.copy().scale Time.deltaTime
            rigidbody.entity.getTransform().position.add rigidbody.velocity.copy().scale Time.deltaTime
    collideAll: (rigidbodies) ->
        length = rigidbodies.length
        for i in [0..length-1]
            a = rigidbodies[i]
            for j in [i+1..length-1]
                b = rigidbodies[j]
                @collide a, b
    collide: (a, b) ->
        console.log "there will be a collision between " + a + " and " + b
            