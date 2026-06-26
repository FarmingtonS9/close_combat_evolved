package utility

clamp_physical :: proc(value: f32) -> f32 {
    return clamp(value, 0.0, 1.0)
}