package soldier

SquadID :: distinct u32
NumSquad :: SquadID(0)

Squad :: struct {
    id: SquadID,
    soldier_ids: [dynamic]SoldierID,
    leader_id: SoldierID,
    is_active: bool,
}

default_squad :: proc(squad_id: SquadID) -> Squad {
    return Squad {
        id = squad_id,
        soldier_ids = make([dynamic]SoldierID),
        leader_id = SoldierID(0),
        is_active = true,
    }
}

destroy_squad :: proc(squad: ^Squad) {
    delete(squad.soldier_ids)
}