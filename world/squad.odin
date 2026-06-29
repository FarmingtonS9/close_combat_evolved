package world

import "core:math"

import sdr "../soldier"

create_squad :: proc(world: ^World, origin: sdr.Position) -> sdr.SquadID {
    squad_id := world.next_squad_id
    world.next_squad_id += 1

    new_squad := sdr.default_squad(squad_id, origin)
    append(&world.squads, new_squad)

    return squad_id
}

find_squad :: proc(world: ^World, squad_id: sdr.SquadID) -> ^sdr.Squad {
    for &squad in world.squads {
        if squad.id == squad_id {
            return &squad
        }
    }

    return nil
}

update_squads :: proc(world: ^World, dt: f32) {
    for &squad in world.squads {
        if !squad.is_active {
            continue
        }

        update_squad_origin(world, &squad, dt)

        assign_loose_squad_members(world, &squad)        
    }
}

update_squad_origin :: proc(world: ^World, squad: ^sdr.Squad, dt: f32) {
    if !squad.movement_state.has_destination {
        return
    }

    leader := find_soldier(world, squad.leader_id)

    if leader == nil || !leader.is_active {
        squad.movement_state.has_destination = false
        return
    }

    dx := squad.movement_state.destination.x - squad.movement_state.origin.x
    dy := squad.movement_state.destination.y - squad.movement_state.origin.y

    distance := math.sqrt(dx * dx + dy * dy)

    if distance <= 1.0 {
        squad.movement_state.origin = squad.movement_state.destination
        squad.movement_state.has_destination = false
        return
    }

    direction_x := dx / distance
    direction_y := dy / distance

    movement_distance := squad.movement_state.speed * dt

    if movement_distance >= distance {
        squad.movement_state.origin = squad.movement_state.destination
        squad.movement_state.has_destination = false
        return
    }

    squad.movement_state.origin.x += direction_x * movement_distance
    squad.movement_state.origin.y += direction_y * movement_distance
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

    existing_squad := find_active_squad_for_soldier(world, soldier_id)

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

issue_squad_movement_order :: proc(world: ^World, destination: sdr.Position) -> bool {
    if world.selected_squad_id == sdr.NumSquad {
        return false
    }

    squad := find_squad(world, world.selected_squad_id)

    if squad == nil || !squad.is_active {
        return false
    }

    leader := find_soldier(world, squad.leader_id)

    if leader == nil || !leader.is_active {
        return false
    }

    dx := destination.x - squad.movement_state.origin.x
    dy := destination.y - squad.movement_state.origin.y

    distance_squared := dx * dx + dy * dy

    if distance_squared <= 0.001 {
        return false
    }

    distance := math.sqrt(distance_squared)

    squad.movement_state.facing = sdr.Position {
        x = dx / distance,
        y = dy / distance,
    }

    squad.movement_state.destination = destination
    squad.movement_state.has_destination = true

    return true
}

assign_loose_squad_members :: proc(world: ^World, squad: ^sdr.Squad) {
    forward := squad.movement_state.facing

    right := sdr.Position {
        x = -forward.y,
        y = forward.x,
    }

    for member in squad.members {
        soldier := find_soldier(world, member.soldier_id)

        if soldier == nil || !soldier.is_active {
            continue
        }

        target := sdr.Position {
            x = squad.movement_state.origin.x + right.x * member.offset.x + forward.x * member.offset.y,
            y = squad.movement_state.origin.y + right.y * member.offset.x + forward.y * member.offset.y,
        }

        dx := target.x - soldier.position.x
        dy := target.y - soldier.position.y

        distance_squared := dx * dx + dy * dy

        if distance_squared <= 1.0 {
            soldier.movement.destination = target
            soldier.movement.has_destination = false
            continue
        }

        soldier.movement.destination = target
        soldier.movement.has_destination = true
    }
}

select_squad_at_position :: proc(world: ^World, position: sdr.Position, selection_radius: f32 = 12.0) -> bool {
    closest_soldier_id := sdr.SoldierID(0)
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
            closest_soldier_id = soldier.id
        }
    }

    if closest_soldier_id == sdr.SoldierID(0) {
        world.selected_soldier_id = 0
        world.selected_squad_id = sdr.NumSquad
        return false
    }

    squad := find_active_squad_for_soldier(
        world,
        closest_soldier_id,
    )

    if squad == nil {
        world.selected_soldier_id = 0
        world.selected_squad_id = sdr.NumSquad
        return false
    }

    world.selected_soldier_id = closest_soldier_id
    world.selected_squad_id = squad.id

    return true
}

find_active_squad_for_soldier :: proc(world: ^World, soldier_id: sdr.SoldierID) -> ^sdr.Squad {
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