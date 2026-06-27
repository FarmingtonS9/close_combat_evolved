package soldier

Identity :: struct {
    first_name: string,
    last_name: string,

    age: u8
}

default_identity:: proc() -> Identity {
    return Identity {
        first_name = "John",
        last_name = "Doe",
        age = 24,
    }
}