package world

import sdr "../soldier"

World :: struct {
    soldiers: [dynamic]sdr.Soldier,
    next_soldier_id: sdr.SoldierID,
    selected_soldier_id: sdr.SoldierID,
    squads: [dynamic]sdr.Squad,
    next_squad_id: sdr.SquadID,
    selected_squad_id: sdr.SquadID,
}

init_world :: proc() -> World {
    return World {
        soldiers = make([dynamic]sdr.Soldier),
        next_soldier_id = 1,
        selected_soldier_id = 0,
    }
}

destroy_world :: proc(world: ^World) {
    delete(world.soldiers)
}

update_world :: proc(world: ^World, dt: f32) {
    for &soldier in world.soldiers {
        if !soldier.is_active {
            continue
        }

        incoming_fire: f32 = 0.0
        exertion: f32 = 0.0

        sdr.update_soldier(&soldier, incoming_fire, exertion, dt)
    }
}

spawn_soldier :: proc(world: ^World, position: sdr.Position) -> sdr.SoldierID {
    id := world.next_soldier_id
    world.next_soldier_id += 1

    new_soldier := sdr.default_soldier(id)
    new_soldier.position = position

    append(&world.soldiers, new_soldier)

    return id
}

selected_soldier_at_position :: proc(world: ^World, position: sdr.Position, selection_radius: f32 = 12.0) -> bool {
    closest_id: sdr.SoldierID = 0
    closest_distance_squared := selection_radius * selection_radius

    for &soldier in world.soldiers {
        if !soldier.is_active {
            continue
        }

        dx := soldier.position.x - position.x
        dy := soldier.position.y - position.y
        distance_squared := dx * dx + dy * dy

        if distance_squared <= closest_distance_squared {
            closest_distance_squared = distance_squared
            closest_id = soldier.id
        }
    }

    world.selected_soldier_id = closest_id

    return closest_id != 0
}

clear_selected_soldier :: proc(world: ^World) {
    world.selected_soldier_id = 0
}

is_soldier_selected :: proc(world: ^World, soldier_id: sdr.SoldierID) -> bool {
    return world.selected_soldier_id == soldier_id
}

issue_move_order :: proc(world: ^World, destination: sdr.Position,) -> bool {
    if world.selected_soldier_id == 0 {
        return false
    }

    for &soldier in world.soldiers {
        if soldier.id != world.selected_soldier_id {
            continue
        }

        if !soldier.is_active {
            return false
        }

        soldier.movement.destination = destination
        soldier.movement.has_destination = true

        return true
    }

    return false
}