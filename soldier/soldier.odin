package soldier

// Standard library
import "core:fmt"

// User library
// import "weapons" (library)

SoldierID :: distinct u32

Soldier :: struct {
    id: SoldierID,
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
        identity = default_identity(),
        rank = .Private,
        psychology_state = default_psych_state(),
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

    update_psychology(&soldier.psychology_state, &soldier.physical_attributes.physical_state, incoming_fire, exertion, soldier.physical_attributes.endurance, dt)

    if soldier.physical_attributes.physical_state == .Dead {
        soldier.is_active = false
    }
}

// Print state of Soldier
print_state_of_soldier :: proc(soldier: Soldier) {
    // fmt.println(soldier.mental_state)
    // fmt.println(soldier.physical_state)
    // fmt.println(soldier.stamina_state)
}