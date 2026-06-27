package soldier

PhysicalAttributes :: struct {
    strength: f32,
    endurance: f32,
    agility: f32,
}

default_physical_attributes :: proc() -> PhysicalAttributes {
    return PhysicalAttributes {
        strength = 0.5,
        endurance = 0.5,
        agility = 0.5,
    }
}