package soldier

// Standard library
import "core:fmt"

// User library
// import "weapons" (library)

import psych "../psychological"

SoldierID :: distinct u32

Soldier :: struct {
    id: SoldierID,
    identity: Identity,
    rank: BasicRank,
    psychology: psych.PsychologicalState,
    physical_attributes: PhysicalAttributes,

    is_active: bool,
}

// Initialiser for Soldier
default_soldier :: proc(id: SoldierID) -> Soldier {
    return Soldier {
        id = id,
        identity = default_identity(),
        rank = .Private,
        psychology = psych.default_state(),
        is_active = true,
    }
}

spawn_soldier :: proc() {

}

update_soldier :: proc(soldier: ^Soldier, incoming_fire: f32, exertion: f32, dt: f32) {
    // Checks if soldier is dead
    if !soldier.is_active {
        return
    }

    psych.update_psychology(&soldier.psychology, incoming_fire, exertion, soldier.physical_attributes.endurance, dt)

    if soldier.psychology.physical_state == .Dead {
        soldier.is_active = false
    }
}

// Print state of Soldier
print_state_of_soldier :: proc(soldier: Soldier) {
    // fmt.println(soldier.mental_state)
    // fmt.println(soldier.physical_state)
    // fmt.println(soldier.stamina_state)
}