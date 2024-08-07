// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.item;

import java.util.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.domain.Command;
import org.dddml.aptosinfiniteseas.specialization.DomainError;

public interface ItemCommand extends Command {

    Long getItemId();

    void setItemId(Long itemId);

    Long getOffChainVersion();

    void setOffChainVersion(Long offChainVersion);

    static void throwOnInvalidStateTransition(ItemState state, Command c) {
        if (state.getOffChainVersion() == null) {
            if (isCommandCreate((ItemCommand)c)) {
                return;
            }
            throw DomainError.named("premature", "Can't do anything to unexistent aggregate");
        }
        if (state.getDeleted() != null && state.getDeleted()) {
            throw DomainError.named("zombie", "Can't do anything to deleted aggregate.");
        }
        if (isCommandCreate((ItemCommand)c))
            throw DomainError.named("rebirth", "Can't create aggregate that already exists");
    }

    static boolean isCommandCreate(ItemCommand c) {
        if (c.getOffChainVersion().equals(ItemState.VERSION_NULL))
            return true;
        return false;
    }

}

