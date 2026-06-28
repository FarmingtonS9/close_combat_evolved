package render

import "core:fmt"
import "core:strings"
import rl "vendor:raylib"

import wrd "../world"

draw_game :: proc(world: ^wrd.World) {
    rl.ClearBackground(rl.RAYWHITE)

    for &soldier in world.soldiers {
        if !soldier.is_active {
            continue
        }

        x := i32(soldier.position.x)
        y := i32(soldier.position.y)

        soldier_colour := rl.BLUE

        if world.selected_soldier_id == soldier.id {
            soldier_colour = rl.RED

            if soldier.movement.has_destination {
                destination_x := i32(soldier.movement.destination.x)
                destination_y := i32(soldier.movement.destination.y)

                rl.DrawCircleLines(destination_x, destination_y, 6.0, rl.RED)

                rl.DrawLine(x, y, destination_x, destination_y, rl.GRAY)
            }

            rl.DrawCircleLines(x, y, 13.0, rl.RED)
            
        }

        rl.DrawCircle(x, y, 8.0, rl.BLUE)

        id_text : string = fmt.tprintf("%v", soldier.id)
        id_text_cstring := strings.clone_to_cstring(id_text)

        rl.DrawText(id_text_cstring, x + 10, y - 8, 14, rl.BLACK)

        delete(id_text_cstring)
    }

    count_string := fmt.tprintf("Soldiers: %d", len(world.soldiers))
    count_cstring := strings.clone_to_cstring(count_string)

    defer delete(count_cstring)

    rl.DrawText(count_cstring, 20, 20, 20, rl.BLACK)
}