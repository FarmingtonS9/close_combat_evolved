package render

import rl "vendor:raylib"

draw_game :: proc() {
    rl.ClearBackground(rl.RAYWHITE)

    // draw world
    rl.DrawRectangle(350, 250, 50, 50, rl.BLUE)

    // draw HUD
    rl.DrawText("Game running...", 20, 20, 20, rl.BLACK)
}