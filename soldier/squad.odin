package soldier

SquadID :: distinct u32
NumSquad :: SquadID(0)

SquadSide :: enum {
    Player,
    Friendly,
    Enemy,
}

SquadMovementMode :: enum {
    Loose,
    Formation,
    Follow_Feature,
}

SquadMovementState :: struct {
    origin: Position,
    destination: Position,
    facing: Position,
    has_destination: bool,
    speed: f32,
    mode: SquadMovementMode,
}

SquadMember :: struct {
    soldier_id: SoldierID,
    offset: Position,
}

Squad :: struct {
    id: SquadID,
    side: SquadSide,
    members: [dynamic]SquadMember,
    leader_id: SoldierID,
    movement_state: SquadMovementState,
    is_active: bool,
}

default_squad :: proc(squad_id: SquadID, origin: Position, side: SquadSide) -> Squad {
    return Squad {
        id = squad_id,
        side = side,
        members = make([dynamic]SquadMember),
        leader_id = SoldierID(0),
        movement_state = SquadMovementState {
            origin = origin,
            destination = origin,
            facing = Position {
                0.0,
                -1.0,
            },
            has_destination = false,
            speed = 65.0,
            mode = .Loose,
        },
        is_active = true,
    }
}

destroy_squad :: proc(squad: ^Squad) {
    delete(squad.members)
}