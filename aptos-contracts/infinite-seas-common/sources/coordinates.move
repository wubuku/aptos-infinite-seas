// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas_common::coordinates {
    const EDataTooLong: u64 = 102;

    struct Coordinates has store, drop, copy {
        x: u32,
        y: u32,
    }

    public fun new(
        x: u32,
        y: u32,
    ): Coordinates {
        let coordinates = Coordinates {
            x,
            y,
        };
        validate(&coordinates);
        coordinates
    }

    fun validate(coordinates: &Coordinates) {
        let _ = coordinates;
    }

    public fun x(coordinates: &Coordinates): u32 {
        coordinates.x
    }

    public fun y(coordinates: &Coordinates): u32 {
        coordinates.y
    }

}
