package world

import sdr "../soldier"

spawn_soldier :: proc(world: ^World, position: sdr.Position) -> sdr.SoldierID {
    id := world.next_soldier_id
    world.next_soldier_id += 1

    new_soldier := sdr.default_soldier(id)
    new_soldier.position = position

    append(&world.soldiers, new_soldier)

    return id
}

find_soldier :: proc(world: ^World, soldier_id: sdr.SoldierID) -> ^sdr.Soldier {
    for &soldier in world.soldiers {
        if soldier.id == soldier_id {
            return &soldier
        }
    }

    return nil
}

find_active_soldier :: proc(world: ^World, soldier_id: sdr.SoldierID) -> ^sdr.Soldier {
    soldier := find_soldier(world, soldier_id)

    if soldier == nil || !soldier.is_active {
        return nil
    }

    return soldier
}

clear_selected_soldier :: proc(world: ^World) {
    world.selected_soldier_id = 0
}

get_selected_soldier :: proc(world: ^World) -> ^sdr.Soldier {
    if world.selected_soldier_id == 0 {
        return nil
    }

    return find_active_soldier(world, world.selected_soldier_id)
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

    if closest_id == sdr.SoldierID(0) {
        world.selected_soldier_id = 0
        world.selected_squad_id = sdr.NumSquad
        return false
    }

    squad := find_active_squad_for_soldier(world, closest_id)

    if squad == nil {
        world.selected_soldier_id = 0
        world.selected_squad_id = sdr.NumSquad
        return false
    }

    world.selected_soldier_id = closest_id
    world.selected_squad_id = squad.id

    return true
}

is_soldier_selected :: proc(world: ^World, soldier_id: sdr.SoldierID) -> bool {
    return world.selected_soldier_id == soldier_id
}

is_soldier_in_selected_squad :: proc(world: ^World, soldier_id: sdr.SoldierID) -> bool {
    if world.selected_squad_id == sdr.NumSquad {
        return false
    }

    squad := find_squad(world, world.selected_squad_id)

    if squad == nil || !squad.is_active {
        return false
    }

    for member in squad.members {
        if member.soldier_id == soldier_id {
            return true
        }
    }

    return false
}