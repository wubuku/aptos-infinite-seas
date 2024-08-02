// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.player;

import java.util.List;
import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.specialization.Event;
import org.dddml.aptosinfiniteseas.domain.Command;

public interface PlayerAggregate {
    PlayerState getState();

    List<Event> getChanges();

    void create(String name, Long offChainVersion, String commandId, String requesterId, PlayerCommands.Create c);

    void claimIsland(Coordinates coordinates, Long offChainVersion, String commandId, String requesterId, PlayerCommands.ClaimIsland c);

    void airdrop(Long itemId, Long quantity, Long offChainVersion, String commandId, String requesterId, PlayerCommands.Airdrop c);

    void gatherIslandResources(Long offChainVersion, String commandId, String requesterId, PlayerCommands.GatherIslandResources c);

    void throwOnInvalidStateTransition(Command c);
}

