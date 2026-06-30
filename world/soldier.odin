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

get_selected_soldier :: proc(world: ^World) -> ^sdr.Soldier {
    if world.selected_soldier_id == 0 {
        return nil
    }

    return find_active_soldier(world, world.selected_soldier_id)
}

is_soldier_selected :: proc(world: ^World, soldier_id: sdr.SoldierID) -> bool {
    return world.selected_soldier_id == soldier_id
}

is_soldier_in_selected_squad :: proc(world: ^World, soldier_id: sdr.SoldierID) -> bool {
    squad := get_selected_squad(world)

    if squad == nil {
        return false
    }

    return squad_contains_soldier(squad, soldier_id)
}