// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.map;

import java.util.*;
import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.specialization.*;
import org.dddml.aptosinfiniteseas.domain.AbstractEvent;

public abstract class AbstractMapLocationEvent extends AbstractEvent implements MapLocationEvent.SqlMapLocationEvent {
    private MapLocationEventId mapLocationEventId = new MapLocationEventId();

    public MapLocationEventId getMapLocationEventId() {
        return this.mapLocationEventId;
    }

    public void setMapLocationEventId(MapLocationEventId eventId) {
        this.mapLocationEventId = eventId;
    }
    
    public Coordinates getCoordinates() {
        return getMapLocationEventId().getCoordinates();
    }

    public void setCoordinates(Coordinates coordinates) {
        getMapLocationEventId().setCoordinates(coordinates);
    }

    private boolean eventReadOnly;

    public boolean getEventReadOnly() { return this.eventReadOnly; }

    public void setEventReadOnly(boolean readOnly) { this.eventReadOnly = readOnly; }

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


    private String commandId;

    public String getCommandId() {
        return commandId;
    }

    public void setCommandId(String commandId) {
        this.commandId = commandId;
    }

    protected AbstractMapLocationEvent() {
    }

    protected AbstractMapLocationEvent(MapLocationEventId eventId) {
        this.mapLocationEventId = eventId;
    }


    public abstract String getEventClass();


}

