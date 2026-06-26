package ui

import rl "vendor:raylib"

import gs "../game_state"

update_game :: proc(state: ^gs.GameState) {
    if rl.IsKeyPressed(.BACKSPACE) {
        state^ = .PauseMenu
    }
}