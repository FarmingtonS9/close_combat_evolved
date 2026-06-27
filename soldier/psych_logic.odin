package soldier

import ut "../utility"

update_psychology :: proc(psych: ^PsychologicalState, physical_state: ^PhysicalState, incoming_fire: f32, exertion: f32, endurance: f32, dt: f32) {
    // Checks for states of soldiers which should not be updated.
    if physical_state^ == .Dead || physical_state^ == .Incapacitated {
        return
    }

    fire_pressure: f32 = ut.clamp_physical(incoming_fire)
    exertion_level: f32 = ut.clamp_physical(exertion)

    suppression_gain: f32 = fire_pressure * 0.25
    suppression_recovery: f32 = 0.08

    psych.suppression += (suppression_gain - suppression_recovery) * dt

    fear_gain: f32 = psych.suppression * 0.10
    fear_recovery: f32 = psych.confidence * 0.05

    psych.fear += (fear_gain - fear_recovery) * dt


    // Add later 
    // load_level: f32 = ut.clamp_psychology(carried_load)
    // load_modifier: f32 = 1.0 + load_level * 0.75

    endurance: f32 = ut.clamp_physical(endurance)
    endurance_modifier: f32 = 1.25 - endurance * 0.50
    
    fatigue_gain: f32 = exertion_level * 0.08 * endurance_modifier
    fatigue_recovery: f32 = 0.015 + endurance * 0.010

    psych.fatigue += (fatigue_gain - fatigue_recovery) * dt

    clamp_state(psych, endurance)

    update_morale(psych, dt)
    update_mental_state(psych)
    update_stamina_state(psych)
}

update_morale :: proc(psych: ^PsychologicalState, dt: f32) {
    adjustment_rate: f32 = 0.75

    target_morale: f32 = ut.clamp_psychology(0.35 + psych.confidence * 0.65 - psych.fear * 0.25 - psych.fatigue * 0.15)

    psych.morale += (target_morale - psych.morale) * adjustment_rate * dt

    psych.morale = ut.clamp_psychology(psych.morale)
}

update_mental_state :: proc(psych: ^PsychologicalState) {

    // Only to handle certain states. Hysteresis
    #partial switch psych.mental_state {
        case .Broken:
            if psych.morale > 0.30 && psych.fear < 0.55 {
                psych.mental_state = .Panicked
            }
            return
        
        case .Panicked:
            if psych.morale < 0.15 && psych.fear > 0.75 {
                psych.mental_state = .Broken
                return
            }

            if psych.fear < 0.60 {
                psych.mental_state = .Cowering
            }
            return
    }

    if psych.morale < 0.15 && psych.fear > 0.75 {
        psych.mental_state = .Broken
    } else if psych.fear > 0.80 {
        psych.mental_state = .Panicked
    } else if psych.suppression > 0.85 {
        psych.mental_state = .Cowering
    } else if psych.suppression > 0.45 {
        psych.mental_state = .Suppressed
    } else {
        psych.mental_state = .Stable
    }
}

update_stamina_state :: proc(psych: ^PsychologicalState) {
    if psych.fatigue >= 0.85 {
        psych.stamina_state = .Exhausted
    } else if psych.fatigue >= 0.60 {
        psych.stamina_state = .Fatigued
    } else if psych.fatigue >= 0.30 {
        psych.stamina_state = .Winded
    } else {
        psych.stamina_state = .Rested
    }
}

clamp_state :: proc(psych: ^PsychologicalState, endurance: f32) {
    psych.suppression = ut.clamp_psychology(psych.suppression)
    psych.fear = ut.clamp_psychology(psych.fear)
    psych.confidence = ut.clamp_psychology(psych.confidence)
    psych.morale = ut.clamp_psychology(psych.morale)
    psych.fatigue = ut.clamp_physical(psych.fatigue)
    endurance := ut.clamp_physical(endurance)
}