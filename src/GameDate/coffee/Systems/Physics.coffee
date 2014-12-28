class exports.Physics extends System
    constructor: () ->
        @gravity = new Vector2 0, 400
        @floor = 600
    update: () ->
        rigidbodies = Entity.getAll Rigidbody
        @moveAll rigidbodies
        @collideAll rigidbodies
        @floorCollide rigidbodies
    moveAll: (rigidbodies) ->
        for rigidbody in rigidbodies
            rigidbody.velocity.add @gravity.copy().scale Time.deltaTime
            rigidbody.entity.getTransform().position.add rigidbody.velocity.copy().scale Time.deltaTime
    collideAll: (rigidbodies) ->
        length = rigidbodies.length
        for i in [0..length-1]
            a = rigidbodies[i]
            if i < length-1 then for j in [i+1..length-1]
                b = rigidbodies[j]
                @collide a, b
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
                distributeForce = (normal.copy().scale normal.dot combinedVelocity).scale -2
                combinedMass = a.mass + b.mass
                aPiece = b.mass / combinedMass
                bPiece = (1 - aPiece)
                a.entity.getTransform().position.add distributeMovement.copy().scale aPiece
                b.entity.getTransform().position.add distributeMovement.copy().scale -bPiece
                a.velocity.add distributeForce.copy().scale aPiece
                b.velocity.add distributeForce.copy().scale -bPiece
    floorCollide: (rigidbodies) ->
        for rigidbody in rigidbodies
            if rigidbody.entity.getTransform().position.y > @floor
                rigidbody.velocity.y *= -.6
                rigidbody.entity.getTransform().position.y = @floor
        
            