package ui

import rl "vendor:raylib"

import gs "../game_state"

update_main_menu :: proc(state: ^gs.GameState) {
    MENU_BOX_HEIGHT :: 100
    MENU_BOX_WIDTH :: 400
    half_height: f32 = f32(rl.GetRenderHeight()) / 2
    half_width: f32 = f32(rl.GetRenderWidth()) / 2
    centre_position_width := half_width - (MENU_BOX_WIDTH / 2)
    centre_position_height := half_height - (MENU_BOX_HEIGHT / 2)
    menu_box := rl.Rectangle {
        centre_position_width,
        centre_position_height,
        MENU_BOX_WIDTH,
        MENU_BOX_HEIGHT
    }
    
    if rl.GuiButton(menu_box, "Play!") {
        state^ = .Game
    }
}

// Menu
menu_play_button :: proc() {
    MENU_BOX_HEIGHT :: 100
    MENU_BOX_WIDTH :: 400
    half_height: f32 = f32(rl.GetRenderHeight()) / 2
    half_width: f32 = f32(rl.GetRenderWidth()) / 2
    centre_position_width := half_width - (MENU_BOX_WIDTH / 2)
    centre_position_height := half_height - (MENU_BOX_HEIGHT / 2)
    menu_box := rl.Rectangle {
        centre_position_width,
        centre_position_height,
        MENU_BOX_WIDTH,
        MENU_BOX_HEIGHT
    }
}

menu_close_program_button :: proc() {
    MENU_BOX_HEIGHT :: 100
    MENU_BOX_WIDTH :: 400
    half_height: f32 = f32(rl.GetRenderHeight()) / 2
    half_width: f32 = f32(rl.GetRenderWidth()) / 2
    position_width := half_width - (MENU_BOX_WIDTH / 2)
    position_height := half_height - (MENU_BOX_HEIGHT / 2) + 100.0
    menu_box := rl.Rectangle {
        position_width,
        position_height,
        MENU_BOX_WIDTH,
        MENU_BOX_HEIGHT
    }
    if rl.GuiButton(menu_box, cstring("CLOSE!")) {
        rl.EndDrawing()
        rl.CloseWindow()
    }
}