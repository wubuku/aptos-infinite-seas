// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas::pass_object {
    use std::option::{Self, Option};

    friend infinite_seas::player;
    friend infinite_seas::skill_process;
    friend infinite_seas::ship;
    friend infinite_seas::roster;
    friend infinite_seas::ship_battle;

    const EIncorrectUsage: u64 = 101;
    const ENoneObjectAddress: u64 = 102;

    /// read-only 'hot potato' wrapper.
    struct PassObject<T> {
        value: T,
        object_address: Option<address>,
    }

    public(friend) fun new<T>(value: T): PassObject<T> {
        PassObject { value, object_address: option::none() }
    }

    public(friend) fun new_with_address<T>(value: T, object_address: address): PassObject<T> {
        PassObject { value, object_address: option::some(object_address) }
    }

    public(friend) fun extract<T>(pass_object: PassObject<T>): T {
        let PassObject { value, object_address } = pass_object;
        assert!(option::is_none(&object_address), EIncorrectUsage);
        value
    }

    /// Alias of `extract` function.
    public(friend) fun extract_value<T>(pass_object: PassObject<T>): T {
        extract(pass_object)
    }

    public(friend) fun extract_value_and_address<T>(pass_object: PassObject<T>): (T, address) {
        let PassObject { value, object_address } = pass_object;
        assert!(option::is_some(&object_address), EIncorrectUsage);
        (value, option::extract(&mut object_address))
    }

    public fun borrow<T>(pass_object: &PassObject<T>): &T {
        &pass_object.value
    }

    /// Alias of `borrow` function.
    public fun borrow_value<T>(pass_object: &PassObject<T>): &T {
        borrow(pass_object)
    }

    public(friend) fun borrow_mut<T>(pass_object: &mut PassObject<T>): &mut T {
        &mut pass_object.value
    }

    public fun object_address<T>(pass_object: &PassObject<T>): Option<address> {
        pass_object.object_address
    }

    /// Ensure that the object address is present, and return it.
    public fun ensure_object_address<T>(pass_object: &PassObject<T>): address {
        assert!(option::is_some(&pass_object.object_address), ENoneObjectAddress);
        *option::borrow(&pass_object.object_address)
    }
}

