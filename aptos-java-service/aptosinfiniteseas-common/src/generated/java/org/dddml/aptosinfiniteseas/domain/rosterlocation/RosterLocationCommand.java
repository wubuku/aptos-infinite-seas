// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.rosterlocation;

import java.util.*;
import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.domain.Command;
import org.dddml.aptosinfiniteseas.specialization.DomainError;

public interface RosterLocationCommand extends Command {

    String getRosterObjectId();

    void setRosterObjectId(String rosterObjectId);

    Long getOffChainVersion();

    void setOffChainVersion(Long offChainVersion);

    static void throwOnInvalidStateTransition(RosterLocationState state, Command c) {
        if (state.getOffChainVersion() == null) {
            if (isCommandCreate((RosterLocationCommand)c)) {
                return;
            }
            throw DomainError.named("premature", "Can't do anything to unexistent aggregate");
        }
        if (state.getDeleted() != null && state.getDeleted()) {
            throw DomainError.named("zombie", "Can't do anything to deleted aggregate.");
        }
        if (isCommandCreate((RosterLocationCommand)c))
            throw DomainError.named("rebirth", "Can't create aggregate that already exists");
    }

    static boolean isCommandCreate(RosterLocationCommand c) {
        if (c.getOffChainVersion().equals(RosterLocationState.VERSION_NULL))
            return true;
        return false;
    }

}

