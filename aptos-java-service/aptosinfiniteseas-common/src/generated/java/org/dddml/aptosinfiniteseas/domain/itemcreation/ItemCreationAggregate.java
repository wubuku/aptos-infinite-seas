// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.itemcreation;

import java.util.List;
import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.specialization.Event;
import org.dddml.aptosinfiniteseas.domain.Command;

public interface ItemCreationAggregate {
    ItemCreationState getState();

    List<Event> getChanges();

    void create(Long resourceCost, Integer requirementsLevel, Long baseQuantity, Long baseExperience, BigInteger baseCreationTime, BigInteger energyCost, Integer successRate, Long offChainVersion, String commandId, String requesterId, ItemCreationCommands.Create c);

    void update(Long resourceCost, Integer requirementsLevel, Long baseQuantity, Long baseExperience, BigInteger baseCreationTime, BigInteger energyCost, Integer successRate, Long offChainVersion, String commandId, String requesterId, ItemCreationCommands.Update c);

    void throwOnInvalidStateTransition(Command c);
}

