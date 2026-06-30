package render

import "core:fmt"
import "core:strings"

import rl "vendor:raylib"

import wrd "../world"

draw_selected_soldiers_stats :: proc(world: ^wrd.World) {
    if world.selected_soldier_id == 0 {
        return
    }

    soldier := wrd.find_soldier(world, world.selected_soldier_id)
    if soldier == nil {
        return
    }

    panel_x : i32 = 20
    panel_y : i32 = 60
    panel_w : i32 = 260
    panel_h : i32 = 220

    rl.DrawRectangle(panel_x, panel_y, panel_w, panel_h, rl.LIGHTGRAY)
    rl.DrawRectangleLines(panel_x, panel_y, panel_w, panel_h, rl.BLACK)

    y := panel_y + 10

    draw_stat_line(panel_x + 10, &y, "Name", fmt.tprintf("%s %s", soldier.identity.first_name, soldier.identity.last_name))
    draw_stat_line(panel_x + 10, &y, "Rank", fmt.tprintf("%v", soldier.rank))
    draw_stat_line(panel_x + 10, &y, "Physical", fmt.tprintf("%v", soldier.physical_attributes.physical_state))
    draw_stat_line(panel_x + 10, &y, "Mental", fmt.tprintf("%v", soldier.psychology_state.mental_state))
    draw_stat_line(panel_x + 10, &y, "Stamina", fmt.tprintf("%v", soldier.psychology_state.stamina_state))
    draw_stat_line(panel_x + 10, &y, "Morale", fmt.tprintf("%.2f", soldier.psychology_state.morale))
    draw_stat_line(panel_x + 10, &y, "Fatigue", fmt.tprintf("%.2f", soldier.psychology_state.fatigue))
    draw_stat_line(panel_x + 10, &y, "Suppression", fmt.tprintf("%.2f", soldier.psychology_state.suppression))
    draw_stat_line(panel_x + 10, &y, "Fear", fmt.tprintf("%.2f", soldier.psychology_state.fear))
}

draw_stat_line :: proc(x: i32, y: ^i32, label: string, value: string) {
    text := fmt.tprintf("%s: %s", label, value)
    c_text := strings.clone_to_cstring(text)

    rl.DrawText(c_text, x, y^, 16, rl.BLACK)
    y^ += 22
}