package ui

import rl "vendor:raylib"

// FPS
display_fps :: proc() {
    rl.DrawFPS(10, 10)
}