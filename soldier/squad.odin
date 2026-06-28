package soldier

SquadID :: distinct u32

Squad :: struct {
    id: SquadID,
    soldier_ids: [dynamic]SoldierID,
    leader_id: SoldierID,
    is_selected: bool,
}

default_squad :: proc() -> Squad {
    
}