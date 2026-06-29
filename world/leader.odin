package world

import sdr "../soldier"

set_squad_leader :: proc(world: ^World, squad_id: sdr.SquadID, soldier_id: sdr.SoldierID) -> bool {
    squad := find_squad(world, squad_id)

    if squad == nil {
        return false
    }

    for member in squad.members {
        if member.soldier_id != soldier_id {
            continue
        }

        squad.leader_id = soldier_id
        return true
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