package world

import "core:mem"
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

        squads = make([dynamic]sdr.Squad),
        next_squad_id = 1,
        selected_squad_id = sdr.NumSquad,
    }
}

destroy_world :: proc(world: ^World) {
    for &squad in world.squads {
        sdr.destroy_squad(&squad)
    }

    delete(world.squads)
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

find_squad :: proc(world: ^World, squad_id: sdr.SquadID) -> ^sdr.Squad {
    for &squad in world.squads {
        if squad.id == squad_id {
            return &squad
        }
    }

    return nil
}

find_soldier :: proc(world: ^World, soldier_id: sdr.SoldierID) -> ^sdr.Soldier {
    for &soldier in world.soldiers {
        if soldier.id == soldier_id {
            return &soldier
        }
    }

    return nil
}

create_squad :: proc(world: ^World, origin: sdr.Position) -> sdr.SquadID {
    squad_id := world.next_squad_id
    world.next_squad_id += 1

    new_squad := sdr.default_squad(squad_id, origin)
    append(&world.squads, new_squad)

    return squad_id
}

find_soldier_squad :: proc(world: ^World, soldier_id: sdr.SoldierID) -> ^sdr.Squad {
    for &squad in world.squads {
        if !squad.is_active {
            continue
        }

        for member in squad.members {
            if member.soldier_id == soldier_id {
                return &squad
            }
        }
    }

    return nil
}

add_soldier_to_squad :: proc(world: ^World, squad_id: sdr.SquadID, soldier_id: sdr.SoldierID, offset: sdr.Position) -> bool {
    squad := find_squad(world, squad_id)

    if squad == nil || !squad.is_active {
        return false
    }

    soldier := find_soldier(world, soldier_id)

    if soldier == nil || !soldier.is_active {
        return false
    }

    existing_squad := find_soldier_squad(world, soldier_id)

    if existing_squad != nil {
        return false
    }

    append(&squad.members, sdr.SquadMember {
        soldier_id = soldier_id,
        offset = offset
    })

    if squad.leader_id == sdr.SoldierID(0) {
        squad.leader_id = soldier_id
    }

    return true
}

set_squad_leader :: proc(world: ^World, squad_id: sdr.SquadID, soldier_id: sdr.SoldierID) -> bool {
    squad := find_squad(world, squad_id)

    if squad == nil {
        return false
    }

    for member in squad.members {
        if member.soldier_id != soldier_id {
            continue
        }

        squad.leader_id =soldier_id
        return true
    }

    return false
}

is_selected_squad_member :: proc(world: ^World, soldier_id: sdr.SoldierID) -> bool {
    if world.selected_squad_id == sdr.NumSquad {
        return false
    }

    squad := find_squad(world, world.selected_squad_id)

    if squad == nil {
        return false
    }

    return squad.leader_id == soldier_id
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

is_squad_leader_selected :: proc(world: ^World, soldier_id: sdr.SoldierID) -> bool {
    if world.selected_squad_id == sdr.NumSquad {
        return false
    }

    squad := find_squad(world, world.selected_squad_id)

    if squad == nil || !squad.is_active {
        return false
    }

    return squad.leader_id == soldier_id
}