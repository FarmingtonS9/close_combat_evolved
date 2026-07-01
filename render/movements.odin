package render

import rl "vendor:raylib"

import wrd "../world"

draw_selected_squad_destination :: proc(world: ^wrd.World) {
    squad := wrd.get_selected_squad(world)

    if squad == nil {
        return
    }

    if !squad.movement_state.has_destination {
        return
    }

    x := i32(squad.movement_state.destination.x)
    y := i32(squad.movement_state.destination.y)

    rl.DrawCircleLines(x, y, 10.0, rl.DARKGREEN)
    rl.DrawLine(x - 6, y, x + 6, y, rl.DARKGREEN)
    rl.DrawLine(x, y - 6, x, y + 6, rl.DARKGREEN)
}