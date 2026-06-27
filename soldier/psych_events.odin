package soldier

import ut "../utility"

PsychologicalEvent :: enum {
    NearbyShot,
    NearbyExplosion,
    Wounded,
    FriendlyWounded,
    FriendlyKilled,
    LeaderWounded,
    LeaderKilled,
    EnemyKilled,
    ObjectiveCaptured,
    ReinforcementsArrived,
}

apply_event :: proc(psych: ^PsychologicalState, event: PsychologicalEvent, physical_attr: ^PhysicalAttributes, intensity: f32 = 1.0, endurance: f32) {
    if physical_attr^.physical_state == .Dead || physical_attr^.physical_state == .Incapacitated {
        return
    }

    strength := ut.clamp_psychology(intensity) 

    switch event {
        case .NearbyShot:
            psych.suppression += 0.08 * strength
            psych.fear += 0.02 * strength
        
        case .NearbyExplosion:
            psych.suppression += 0.35 * strength
            psych.fear += 0.20 * strength
            psych.confidence -= 0.05 * strength

        case .Wounded:
            psych.fear += 0.30 * strength
            psych.confidence -= 0.20 * strength
            psych.morale -= 0.15 * strength

        case .FriendlyWounded:
            psych.fear += 0.08 * strength
            psych.morale -= 0.05 * strength

        case .FriendlyKilled:
            psych.fear += 0.18 * strength
            psych.confidence -= 0.10 * strength
            psych.morale -= 0.12 * strength

        case .LeaderWounded:
            psych.confidence -= 0.12 * strength
            psych.morale -= 0.10 * strength

        case .LeaderKilled:
            psych.fear += 0.20 * strength
            psych.confidence -= 0.30 * strength
            psych.morale -= 0.25 * strength

        case .EnemyKilled:
            psych.confidence += 0.08 * strength
            psych.morale += 0.20 * strength

        case .ObjectiveCaptured:
            psych.confidence += 0.15 * strength
            psych.morale += 0.20 * strength

        case .ReinforcementsArrived:
            psych.confidence += 0.20 * strength
            psych.morale += 0.15 * strength

    }

    clamp_state(psych, physical_attr)
    
}