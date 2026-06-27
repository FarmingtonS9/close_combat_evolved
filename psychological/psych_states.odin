package psychological

MentalState :: enum {
    Stable,
    Suppressed,
    Cowering,
    Panicked,
    Broken,
    Berserk,
}

StaminaState :: enum {
    Rested,
    Winded,
    Fatigued,
    Exhausted,
}

PhysicalState :: enum {
    Healthy,
    Injured,
    Incapacitated,
    Dead
}

PsychologicalState :: struct {
    mental_state: MentalState,
    stamina_state: StaminaState,
    physical_state: PhysicalState,

    suppression: f32,
    fear: f32,
    confidence: f32,
    morale: f32,
    fatigue: f32,
}

default_state :: proc() -> PsychologicalState {
    return PsychologicalState {
        mental_state = .Stable,
        stamina_state = .Rested,
        physical_state = .Healthy,

        suppression = 0.0,
        fear = 0.0,
        confidence = 0.5,
        morale = 0.5,
        fatigue = 0.0,
    }
}