package ui

import rl "vendor:raylib"

import gs "../game_state"

update_pause_menu :: proc(state: ^gs.GameState) {
    if rl.GuiButton(
        rl.Rectangle{300, 250, 200, 40},
        "Resume",
    ) {
        state^ = .Game
    }

    if rl.GuiButton(
        rl.Rectangle{300, 310, 200, 40},
        "Main Menu",
    ) {
        state^ = .MainMenu
    }
    
}