package render

import rl "vendor:raylib"
import gs "../game_state"

draw_pause_menu :: proc() {
    rl.ClearBackground(rl.DARKGRAY)

    rl.DrawText("PAUSED", 330, 150, 40, rl.WHITE)
}

update_pause_menu :: proc(game_state: ^gs.GameState) {
    if rl.IsKeyPressed(.ESCAPE) {
        game_state^ = .Game
        return
    }
}