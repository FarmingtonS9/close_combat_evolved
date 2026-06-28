package soldier

Position :: struct {
    x: f32,
    y: f32,
}

default_position :: proc() -> Position {
    return Position {
        x = 0.0,
        y = 0.0
    }
}