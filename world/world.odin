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
    update_squads(world, dt)

    for &soldier in world.soldiers {
        if !soldier.is_active {
            continue
        }

        incoming_fire: f32 = 0.0
        exertion: f32 = 0.0

        sdr.update_soldier(&soldier, incoming_fire, exertion, dt)
    }
}