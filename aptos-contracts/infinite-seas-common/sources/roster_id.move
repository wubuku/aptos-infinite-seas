// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

module infinite_seas_common::roster_id {
    const EDataTooLong: u64 = 102;

    struct RosterId has store, drop, copy {
        player_id: address,
        sequence_number: u32,
    }

    public fun new(
        player_id: address,
        sequence_number: u32,
    ): RosterId {
        let roster_id = RosterId {
            player_id,
            sequence_number,
        };
        validate(&roster_id);
        roster_id
    }

    fun validate(roster_id: &RosterId) {
        let _ = roster_id;
    }

    public fun player_id(roster_id: &RosterId): address {
        roster_id.player_id
    }

    public fun sequence_number(roster_id: &RosterId): u32 {
        roster_id.sequence_number
    }

}
