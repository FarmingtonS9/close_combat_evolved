package utility

clamp_psychology :: proc(value: f32) -> f32 {
    return clamp(value, 0.0, 1.0)
}