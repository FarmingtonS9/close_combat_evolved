package cc_evolved

// Standard Library
import "core:fmt"
import rl "vendor:raylib"

// User Library
import "soldier"

main :: proc() {
    fmt.println("Hello World!")

    soldier1: soldier.Soldier = soldier.default_soldier()

    fmt.println(soldier1)
    soldier.print_state_of_soldier(soldier1)

    rl.InitWindow(1280, 720, "Close Combat Evolved")
    rl.SetTargetFPS(120)

    for !rl.WindowShouldClose() {
        rl.BeginDrawing()
        rl.ClearBackground(rl.BLUE)
        rl.EndDrawing()
    }

    rl.CloseWindow()
}