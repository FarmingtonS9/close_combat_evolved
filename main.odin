package cc_evolved

// Standard Library
import "core:fmt"
import "core:os"
import "core:strings"
import rl "vendor:raylib"

// Custom
import "ui"
import "render"
import gs "game_state"
import ut "utility"
import "soldier"

// User Library
// import "soldier" => this means we're importing a package

// Constants
GAME_TITLE :: "Close Combat Evolved"

main :: proc() {
    fmt.println("Hello World!")

    solider_id : soldier.SoldierID = 1

    soldier1: soldier.Soldier = soldier.default_soldier(solider_id)

    fmt.println(soldier1)
    soldier.print_state_of_soldier(soldier1)

    rl.InitWindow(1280, 720, GAME_TITLE)
    // rl.SetTargetFPS(60)

    // orange := rl.Color{255, 180, 0, 255} // How to create customs colours in Raylib

    current_state := gs.GameState.MainMenu

    for !rl.WindowShouldClose() {

        switch current_state {
            case .MainMenu:
                ui.update_main_menu(&current_state)
            case .Game:
                ui.update_game(&current_state)
            case .PauseMenu:
                ui.update_pause_menu(&current_state)
        }

        rl.BeginDrawing()

        switch current_state {
            case .MainMenu:
                render.draw_main_menu()
            case .Game:
                render.draw_game()
            case .PauseMenu:
                render.draw_pause_menu()
        }
        ui.display_fps()
        rl.EndDrawing()
    }

    rl.CloseWindow()
}

