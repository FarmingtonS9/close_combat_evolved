package cc_evolved

// Standard Library
import "core:fmt"
import rl "vendor:raylib"

// Custom
import "ui"
import "render"
import gs "game_state"
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

    squad_origin := soldier.Position {
        x = 345,
        y = 300,
    }

    soldier1 := world.spawn_soldier(&game_world, {345, 270})
    soldier2 := world.spawn_soldier(&game_world, {320, 300})
    soldier3 := world.spawn_soldier(&game_world, {370, 300})
    soldier4 := world.spawn_soldier(&game_world, {345, 330})

    squad_1 := world.create_squad(&game_world, squad_origin, .Player)

    world.add_soldier_to_squad(&game_world, squad_1, soldier1, {0, 30})
    world.add_soldier_to_squad(&game_world, squad_1, soldier2, {-25, 0})
    world.add_soldier_to_squad(&game_world, squad_1, soldier3, {25, 0})
    world.add_soldier_to_squad(&game_world, squad_1, soldier4, {0, -30})

    world.set_squad_leader(&game_world, squad_1, soldier1)

    //EN
    en_squad_origin := soldier.Position {
        x = 545,
        y = 500,
    }

    en_soldier1 := world.spawn_soldier(&game_world, {345, 270})
    en_soldier2 := world.spawn_soldier(&game_world, {320, 300})
    en_soldier3 := world.spawn_soldier(&game_world, {370, 300})
    en_soldier4 := world.spawn_soldier(&game_world, {345, 330})

    squad_2 := world.create_squad(&game_world, en_squad_origin, .Enemy)

    world.add_soldier_to_squad(&game_world, squad_2, en_soldier1, {0, 30})
    world.add_soldier_to_squad(&game_world, squad_2, en_soldier2, {-25, 0})
    world.add_soldier_to_squad(&game_world, squad_2, en_soldier3, {25, 0})
    world.add_soldier_to_squad(&game_world, squad_2, en_soldier4, {0, -30})

    world.set_squad_leader(&game_world, squad_2, en_soldier1)

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

