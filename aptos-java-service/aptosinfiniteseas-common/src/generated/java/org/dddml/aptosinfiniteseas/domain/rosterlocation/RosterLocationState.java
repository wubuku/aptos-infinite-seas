// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.rosterlocation;

import java.util.*;
import java.math.*;
import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.specialization.Event;

public interface RosterLocationState extends VersionedAptosMoveObject
{
    Long VERSION_ZERO = 0L;

    Long VERSION_NULL = VERSION_ZERO - 1;

    String getRosterObjectId();

    Coordinates getCoordinates();

    Integer getStatus();

    Long getOffChainVersion();

    String getCreatedBy();

    Date getCreatedAt();

    String getUpdatedBy();

    Date getUpdatedAt();

    Boolean getActive();

    Boolean getDeleted();

    interface MutableRosterLocationState extends RosterLocationState, VersionedAptosMoveObject.MutableVersionedAptosMoveObject {
        void setRosterObjectId(String rosterObjectId);

        void setCoordinates(Coordinates coordinates);

        void setStatus(Integer status);

        void setOffChainVersion(Long offChainVersion);

        void setCreatedBy(String createdBy);

        void setCreatedAt(Date createdAt);

        void setUpdatedBy(String updatedBy);

        void setUpdatedAt(Date updatedAt);

        void setActive(Boolean active);

        void setDeleted(Boolean deleted);


        void mutate(Event e);

        //void when(RosterLocationEvent.RosterLocationStateCreated e);

        //void when(RosterLocationEvent.RosterLocationStateMergePatched e);

        //void when(RosterLocationEvent.RosterLocationStateDeleted e);
    }

    interface SqlRosterLocationState extends MutableRosterLocationState {

        boolean isStateUnsaved();

        boolean getForReapplying();
    }
}

