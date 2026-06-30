package render

import "core:fmt"
import "core:strings"
import "core:math"

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

    y += 8

    draw_stat_bar(panel_x + 10, &y, "Morale", soldier.psychology_state.morale, rl.GREEN)
    draw_stat_bar(panel_x + 10, &y, "Fatigue", soldier.psychology_state.fatigue, rl.ORANGE)
    draw_stat_bar(panel_x + 10, &y, "Suppression", soldier.psychology_state.suppression, rl.RED)
    draw_stat_bar(panel_x + 10, &y, "Fear", soldier.psychology_state.fear, rl.MAROON)
}

draw_stat_line :: proc(x: i32, y: ^i32, label: string, value: string) {
    text := fmt.tprintf("%s: %s", label, value)
    c_text := strings.clone_to_cstring(text)

    rl.DrawText(c_text, x, y^, 16, rl.BLACK)
    y^ += 22
}

draw_progress_bar :: proc(x: i32, y: i32, width: i32, height: i32, value: f32, fill_colour: rl.Color) {
    clamped := math.clamp(value, 0.0, 1.0)

    rl.DrawRectangle(x, y, width, height, rl.DARKGRAY)

    // Fill
    fill_width := i32(f32(width) * clamped)
    rl.DrawRectangle(x, y, fill_width, height, fill_colour)

    // Border
    rl.DrawRectangleLines(x, y, width, height, rl.BLACK)
}

draw_stat_bar :: proc(x: i32, y: ^i32, label: cstring, value: f32, colour: rl.Color) {
    rl.DrawText(label, x, y^, 16, rl.BLACK)

    bar_x : i32 = x + 100
    bar_y : i32 = y^ + 3
    bar_w : i32 = 120
    bar_h : i32 = 12

    draw_progress_bar(bar_x, bar_y, bar_w, bar_h, value, colour)

    y^ += 24
}