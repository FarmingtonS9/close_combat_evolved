package render

import rl "vendor:raylib"

draw_pause_menu :: proc() {
    rl.ClearBackground(rl.DARKGRAY)

    rl.DrawText("PAUSED", 330, 150, 40, rl.WHITE)
}