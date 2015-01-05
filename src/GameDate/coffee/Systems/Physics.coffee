class exports.Physics extends System
    constructor: () ->
        @gravity = new Vector2 0, 400
        @floor = 600
        @wallNeg = 0
        @wallPos = 600
    fixedUpdate: () ->
        rigidbodies = Entity.getAll Rigidbody
        @moveAll rigidbodies
        @collideAll rigidbodies
        @floorCollide rigidbodies
    moveAll: (rigidbodies) ->
        for rigidbody in rigidbodies
            rigidbody.velocity.add @gravity.copy().scale Time.fixedDeltaTime
            rigidbody.entity.getTransform().position.add rigidbody.velocity.copy().scale Time.fixedDeltaTime
        return
    collideAll: (rigidbodies) ->
        length = rigidbodies.length
        for i in [0...length]
            a = rigidbodies[i]
            for j in [i+1...length]
                b = rigidbodies[j]
                @collide a, b
        return
    collide: (a, b) ->
        aCollider = a.entity.get Collider
        bCollider = b.entity.get Collider
        if aCollider instanceof CircleCollider and bCollider instanceof CircleCollider
            difference = a.entity.getTransform().position.copy().sub b.entity.getTransform().position
            distance = difference.length()
            normal = difference.copy().scale 1/distance
            minDistance = aCollider.radius + bCollider.radius
            if distance < minDistance
                distributeMovement = normal.copy().scale minDistance-distance
                combinedVelocity = a.velocity.copy().sub b.velocity
                bounce = 2 - aCollider.material.bounceAbsorbtion * bCollider.material.bounceAbsorbtion
                distributeForce = (normal.copy().scale normal.dot combinedVelocity).scale -bounce
                combinedMass = a.mass + b.mass
                aPiece = b.mass / combinedMass
                bPiece = (1 - aPiece)
                a.entity.getTransform().position.add distributeMovement.copy().scale aPiece
                b.entity.getTransform().position.add distributeMovement.copy().scale -bPiece
                a.velocity.add distributeForce.copy().scale aPiece
                b.velocity.add distributeForce.copy().scale -bPiece
        return
    floorCollide: (rigidbodies) ->
        for rigidbody in rigidbodies
            position = rigidbody.entity.getTransform().position
            velocity = rigidbody.velocity
            if position.y > @floor
                velocity.y *= -.6
                position.y = @floor
            if position.x < @wallNeg
                velocity.x *= -.6
                position.x = @wallNeg
            if position.x > @wallPos
                velocity.x *= -.6
                position.x = @wallPos
        return