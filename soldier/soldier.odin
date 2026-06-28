package soldier

// Standard library
import "core:fmt"

// User library
// import "weapons" (library)

SoldierID :: distinct u32

Soldier :: struct {
    id: SoldierID,
    position: Position,
    movement: MovementState,
    identity: Identity,
    rank: BasicRank,
    psychology_state: PsychologicalState,
    physical_attributes: PhysicalAttributes,

    is_active: bool,
}

// Initialiser for Soldier
default_soldier :: proc(id: SoldierID) -> Soldier {
    return Soldier {
        id = id,
        position = default_position(),
        movement = default_movement_state(),
        identity = default_identity(),
        rank = .Private,
        psychology_state = default_psych_state(),
        physical_attributes = default_physical_attributes(),
        is_active = true,
    }
}

update_soldier :: proc(soldier: ^Soldier, incoming_fire: f32, exertion: f32, dt: f32) {
    // Checks if soldier is dead
    if !soldier.is_active {
        return
    }

    update_movement(soldier, dt)

    update_psychology(&soldier.psychology_state, &soldier.physical_attributes, incoming_fire, exertion, dt)

    if soldier.physical_attributes.physical_state == .Dead {
        soldier.is_active = false
    }
}