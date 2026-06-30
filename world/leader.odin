package world

import sdr "../soldier"

set_squad_leader :: proc(world: ^World, squad_id: sdr.SquadID, soldier_id: sdr.SoldierID) -> bool {
    squad := find_active_squad(world, squad_id)

    if squad == nil {
        return false
    }

    soldier := find_active_soldier(world, soldier_id)

    if soldier == nil {
        return false
    }

    if !squad_contains_soldier(squad, soldier_id) {
        return false
    }

    squad.leader_id = soldier_id

    return true
}

is_squad_leader_selected :: proc(world: ^World, soldier_id: sdr.SoldierID) -> bool {
    squad := get_selected_squad(world)

    if squad == nil {
        return false
    }

    return is_squad_leader(squad, soldier_id)
}