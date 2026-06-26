package render

import rl "vendor:raylib"

import ui "../ui"

// Might pass in a Menu struct to save state.
draw_main_menu :: proc() {
    rl.ClearBackground(rl.BLUE)

    rl.DrawText("Close Combat Evolved", 300, 120, 40, rl.WHITE)
    ui.display_fps()

}