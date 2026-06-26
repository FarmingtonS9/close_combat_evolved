package soldier

// Standard library
import "core:fmt"

// User library
// import "weapons" (library)

import psych "../psychological"

Soldier :: struct {
    physical_state: psych.PhysicalState,
    stamina_state: psych.StaminaState,
    mental_state: psych.MentalState
}

// Initialiser for Soldier
default_soldier :: proc() -> Soldier {
    soldier := Soldier {
        physical_state = .Healthy,
        stamina_state = .Rested,
        mental_state = .Stable
    }

    return soldier
}

spawn_soldier :: proc() {

}

// Print state of Soldier
print_state_of_soldier :: proc(soldier: Soldier) {
    fmt.println(soldier.mental_state)
    fmt.println(soldier.physical_state)
    fmt.println(soldier.stamina_state)
}

// State of Soldier
state_of_soldier :: proc(soldier: Soldier) -> (mental_state: psych.MentalState, physical_state: psych.PhysicalState, stamina_state: psych.StaminaState) {
    return soldier.mental_state, soldier.physical_state, soldier.stamina_state
}