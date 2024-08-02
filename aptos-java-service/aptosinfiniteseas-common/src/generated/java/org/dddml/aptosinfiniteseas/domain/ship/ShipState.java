// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.ship;

import java.util.*;
import java.math.*;
import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.specialization.Event;

public interface ShipState extends VersionedAptosMoveObject
{
    Long VERSION_ZERO = 0L;

    Long VERSION_NULL = VERSION_ZERO - 1;

    String getId();

    String getOwner();

    Long getHealthPoints();

    Long getAttack();

    Long getProtection();

    Long getSpeed();

    ItemIdQuantityPairs getBuildingExpenses();

    Long getOffChainVersion();

    String getCreatedBy();

    Date getCreatedAt();

    String getUpdatedBy();

    Date getUpdatedAt();

    Boolean getActive();

    Boolean getDeleted();

    Set<ItemIdQuantityPair> getInventory();

    interface MutableShipState extends ShipState, VersionedAptosMoveObject.MutableVersionedAptosMoveObject {
        void setId(String id);

        void setOwner(String owner);

        void setHealthPoints(Long healthPoints);

        void setAttack(Long attack);

        void setProtection(Long protection);

        void setSpeed(Long speed);

        void setBuildingExpenses(ItemIdQuantityPairs buildingExpenses);

        void setOffChainVersion(Long offChainVersion);

        void setCreatedBy(String createdBy);

        void setCreatedAt(Date createdAt);

        void setUpdatedBy(String updatedBy);

        void setUpdatedAt(Date updatedAt);

        void setActive(Boolean active);

        void setDeleted(Boolean deleted);

        void setInventory(Set<ItemIdQuantityPair> inventory);


        void mutate(Event e);

        //void when(ShipEvent.ShipStateCreated e);

        //void when(ShipEvent.ShipStateMergePatched e);

        //void when(ShipEvent.ShipStateDeleted e);
    }

    interface SqlShipState extends MutableShipState {

        boolean isStateUnsaved();

        boolean getForReapplying();
    }
}

