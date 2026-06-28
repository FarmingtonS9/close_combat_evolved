package ui

import rl "vendor:raylib"

import gs "../game_state"
import wld "../world"
import sdr "../soldier"

update_game :: proc(current_state: ^gs.GameState, world: ^wld.World) {
    if rl.IsKeyPressed(.BACKSPACE) {
        current_state^ = .PauseMenu
        return
    }

    if rl.IsMouseButtonPressed(.LEFT) {
        mouse_position := rl.GetMousePosition()

        world_position := sdr.Position {
            x = mouse_position.x,
            y = mouse_position.y
        }

        wld.selected_soldier_at_position(world, world_position)
    }

    if rl.IsMouseButtonPressed(.RIGHT) {
        mouse_position := rl.GetMousePosition()

        destination := sdr.Position {
            x = mouse_position.x,
            y = mouse_position.y
        }

        wld.issue_squad_movement_order(world, destination)
    }
}