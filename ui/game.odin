package ui

import rl "vendor:raylib"

import gs "../game_state"
import wld "../world"
import sdr "../soldier"
import cam "../camera"

update_game :: proc(current_state: ^gs.GameState, world: ^wld.World, camera: ^cam.CameraController) {
    if rl.IsKeyPressed(.BACKSPACE) {
        current_state^ = .PauseMenu
        return
    }

    if rl.IsMouseButtonPressed(.LEFT) {
        mouse_position := rl.GetMousePosition()
        world_mouse := cam.screen_to_world(camera, mouse_position)

        world_position := sdr.Position {
            x = world_mouse.x,
            y = world_mouse.y
        }

        wld.select_squad_member_at_position(world, world_position)
    }

    if rl.IsMouseButtonPressed(.RIGHT) {
        mouse_position := rl.GetMousePosition()
        world_mouse := cam.screen_to_world(camera, mouse_position)

        destination := sdr.Position {
            x = world_mouse.x,
            y = world_mouse.y
        }

        wld.issue_squad_movement_order(world, destination)
    }
}