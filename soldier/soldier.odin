package soldier

// Standard library
import "core:fmt"

// User library
import "weapons"

Soldier :: struct {
    physical_condition: PhysicalCondition,
    stamina: Stamina,
    mental_state: MentalState
}

// Initialiser for Soldier
default_soldier :: proc() -> Soldier {
    soldier := Soldier {
        physical_condition = .Healthy,
        stamina = .Rested,
        mental_state = .Stable
    }

    return soldier
}

// Print state of Soldier
print_state_of_soldier :: proc(soldier: Soldier) {
    fmt.println(soldier.mental_state)
    fmt.println(soldier.physical_condition)
    fmt.println(soldier.stamina)
}

// State of Soldier
state_of_soldier :: proc(soldier: Soldier) -> (mental_state: MentalState, physical_condition: PhysicalCondition, stamina: Stamina) {
    return soldier.mental_state, soldier.physical_condition, soldier.stamina
}