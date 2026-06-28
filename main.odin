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
import "world"

// User Library
// import "soldier" => this means we're importing a package

// Constants
GAME_TITLE :: "Close Combat Evolved"

main :: proc() {
    fmt.println("Hello World!")

    rl.InitWindow(1280, 720, GAME_TITLE)
    // rl.SetTargetFPS(60)

    // orange := rl.Color{255, 180, 0, 255} // How to create customs colours in Raylib

    game_world := world.init_world()
    defer world.destroy_world(&game_world)

    soldier1 := world.spawn_soldier(&game_world, {300, 300})
    soldier2 := world.spawn_soldier(&game_world, {330, 300})
    soldier3 := world.spawn_soldier(&game_world, {360, 300})
    soldier4 := world.spawn_soldier(&game_world, {390, 300})

    squad_1 := world.create_squad(&game_world)

    world.add_soldier_to_squad(&game_world, squad_1, soldier1)
    world.add_soldier_to_squad(&game_world, squad_1, soldier2)
    world.add_soldier_to_squad(&game_world, squad_1, soldier3)
    world.add_soldier_to_squad(&game_world, squad_1, soldier4)

    world.set_squad_leader(&game_world, squad_1, soldier1)

    current_state := gs.GameState.MainMenu

    for !rl.WindowShouldClose() {

        dt := rl.GetFrameTime()

        switch current_state {
            case .MainMenu:
                ui.update_main_menu(&current_state)
            case .Game:
                ui.update_game(&current_state, &game_world)
                world.update_world(&game_world, dt)
            case .PauseMenu:
                ui.update_pause_menu(&current_state)
        }

        rl.BeginDrawing()

        switch current_state {
            case .MainMenu:
                render.draw_main_menu()
            case .Game:
                render.draw_game(&game_world)
            case .PauseMenu:
                render.draw_pause_menu()
        }
        ui.display_fps()
        rl.EndDrawing()
    }

    rl.CloseWindow()
}

