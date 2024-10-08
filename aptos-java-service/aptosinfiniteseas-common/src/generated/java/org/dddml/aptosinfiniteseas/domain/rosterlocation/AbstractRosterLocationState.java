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
import org.dddml.aptosinfiniteseas.specialization.*;
import org.dddml.aptosinfiniteseas.domain.rosterlocation.RosterLocationEvent.*;

public abstract class AbstractRosterLocationState implements RosterLocationState.SqlRosterLocationState {

    private String rosterObjectId;

    public String getRosterObjectId() {
        return this.rosterObjectId;
    }

    public void setRosterObjectId(String rosterObjectId) {
        this.rosterObjectId = rosterObjectId;
    }

    private Coordinates coordinates;

    public Coordinates getCoordinates() {
        return this.coordinates;
    }

    public void setCoordinates(Coordinates coordinates) {
        this.coordinates = coordinates;
    }

    private Integer status;

    public Integer getStatus() {
        return this.status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    private BigInteger version;

    public BigInteger getVersion() {
        return this.version;
    }

    public void setVersion(BigInteger version) {
        this.version = version;
    }

    private Long offChainVersion;

    public Long getOffChainVersion() {
        return this.offChainVersion;
    }

    public void setOffChainVersion(Long offChainVersion) {
        this.offChainVersion = offChainVersion;
    }

    private String createdBy;

    public String getCreatedBy() {
        return this.createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    private Date createdAt;

    public Date getCreatedAt() {
        return this.createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    private String updatedBy;

    public String getUpdatedBy() {
        return this.updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    private Date updatedAt;

    public Date getUpdatedAt() {
        return this.updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    private Boolean active;

    public Boolean getActive() {
        return this.active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    private Boolean deleted;

    public Boolean getDeleted() {
        return this.deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }

    public boolean isStateUnsaved() {
        return this.getOffChainVersion() == null;
    }

    private Boolean stateReadOnly;

    public Boolean getStateReadOnly() { return this.stateReadOnly; }

    public void setStateReadOnly(Boolean readOnly) { this.stateReadOnly = readOnly; }

    private boolean forReapplying;

    public boolean getForReapplying() {
        return forReapplying;
    }

    public void setForReapplying(boolean forReapplying) {
        this.forReapplying = forReapplying;
    }

    public AbstractRosterLocationState(List<Event> events) {
        initializeForReapplying();
        if (events != null && events.size() > 0) {
            this.setRosterObjectId(((RosterLocationEvent.SqlRosterLocationEvent) events.get(0)).getRosterLocationEventId().getRosterObjectId());
            for (Event e : events) {
                mutate(e);
                this.setOffChainVersion((this.getOffChainVersion() == null ? RosterLocationState.VERSION_NULL : this.getOffChainVersion()) + 1);
            }
        }
    }


    public AbstractRosterLocationState() {
        initializeProperties();
    }

    protected void initializeForReapplying() {
        this.forReapplying = true;

        initializeProperties();
    }
    
    protected void initializeProperties() {
    }

    @Override
    public int hashCode() {
        return getRosterObjectId().hashCode();
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) { return true; }
        if (obj instanceof RosterLocationState) {
            return Objects.equals(this.getRosterObjectId(), ((RosterLocationState)obj).getRosterObjectId());
        }
        return false;
    }


    public void mutate(Event e) {
        setStateReadOnly(false);
        if (false) { 
            ;
        } else {
            throw new UnsupportedOperationException(String.format("Unsupported event type: %1$s", e.getClass().getName()));
        }
    }

    public void merge(RosterLocationState s) {
        if (s == this) {
            return;
        }
        this.setCoordinates(s.getCoordinates());
        this.setStatus(s.getStatus());
        this.setVersion(s.getVersion());
        this.setActive(s.getActive());
    }

    public void save() {
    }

    protected void throwOnWrongEvent(RosterLocationEvent event) {
        String stateEntityId = this.getRosterObjectId(); // Aggregate Id
        String eventEntityId = ((RosterLocationEvent.SqlRosterLocationEvent)event).getRosterLocationEventId().getRosterObjectId(); // EntityBase.Aggregate.GetEventIdPropertyIdName();
        if (!stateEntityId.equals(eventEntityId)) {
            throw DomainError.named("mutateWrongEntity", "Entity Id %1$s in state but entity id %2$s in event", stateEntityId, eventEntityId);
        }


        Long stateVersion = this.getOffChainVersion();

    }


    public static class SimpleRosterLocationState extends AbstractRosterLocationState {

        public SimpleRosterLocationState() {
        }

        public SimpleRosterLocationState(List<Event> events) {
            super(events);
        }

        public static SimpleRosterLocationState newForReapplying() {
            SimpleRosterLocationState s = new SimpleRosterLocationState();
            s.initializeForReapplying();
            return s;
        }

    }



}

