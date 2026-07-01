package camera

import rl "vendor:raylib"

CameraController :: struct {
    camera: rl.Camera2D,
    move_speed: f32,
    zoom_speed: f32,
    min_zoom: f32,
    max_zoom: f32,
}

init_camera :: proc(screen_width: i32, screen_height: i32) -> CameraController {
    return CameraController {
        camera = rl.Camera2D {
            target = {0, 0},
            offset = {f32(screen_width) / 2, f32(screen_height) / 2},
            rotation = 0,
            zoom = 1.0
        },
        move_speed = 500.0,
        zoom_speed = 0.1,
        min_zoom = 0.25,
        max_zoom = 3.0,
    }
}

update_camera :: proc(camera: ^CameraController, dt: f32) {
    speed := camera.move_speed * dt / camera.camera.zoom

    if rl.IsKeyDown(.W) { camera.camera.target.y -= speed }
    if rl.IsKeyDown(.S) { camera.camera.target.y += speed }
    if rl.IsKeyDown(.A) { camera.camera.target.x -= speed }
    if rl.IsKeyDown(.D) { camera.camera.target.x += speed }

    wheel :=  rl.GetMouseWheelMove()
    if wheel != 0 {
        camera.camera.zoom += wheel * camera.zoom_speed
        camera.camera.zoom = rl.Clamp(camera.camera.zoom, camera.min_zoom, camera.max_zoom)
    }
}

screen_to_world :: proc(camera: ^CameraController, screen_position: rl.Vector2) -> rl.Vector2 {
    return rl.GetScreenToWorld2D(screen_position, camera.camera)
}