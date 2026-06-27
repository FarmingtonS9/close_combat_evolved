package soldier

PhysicalState :: enum {
    Healthy,
    Injured,
    Incapacitated,
    Dead
}

PhysicalAttributes :: struct {
    physical_state: PhysicalState,

    strength: f32,
    endurance: f32,
    agility: f32,
}

default_physical_attributes :: proc() -> PhysicalAttributes {
    return PhysicalAttributes {
        physical_state = .Healthy,

        strength = 0.5,
        endurance = 0.5,
        agility = 0.5,
    }
}