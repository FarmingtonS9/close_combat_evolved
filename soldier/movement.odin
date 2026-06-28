package soldier

import "core:math"

MovementState :: struct {
    destination: Position,
    has_destination: bool,
    speed: f32,
}

default_movement_state :: proc() -> MovementState {
    return MovementState {
        destination = Position {},
        has_destination = false,
        speed = 80.0
    }
}

update_movement :: proc(soldier: ^Soldier, dt: f32) {
    if !soldier.movement.has_destination {
        return
    }

    dx := soldier.movement.destination.x - soldier.position.x
    dy := soldier.movement.destination.y - soldier.position.y

    distance := math.sqrt(dx * dx + dy * dy)

    if distance <= 1.0 {
        soldier.position = soldier.movement.destination
        soldier.movement.has_destination = false
        return
    }

    direction_x := dx / distance
    direction_y := dy / distance

    movement_distance := soldier.movement.speed * dt

    if movement_distance >= distance {
        soldier.position = soldier.movement.destination
        soldier.movement.has_destination = false
        return
    }

    soldier.position.x += direction_x * movement_distance
    soldier.position.y += direction_y * movement_distance
}