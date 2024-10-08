// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.aptos.contract.persistence;

import org.dddml.aptosinfiniteseas.domain.AptosEvent;
import org.dddml.aptosinfiniteseas.domain.AptosEventGuid;
import org.dddml.aptosinfiniteseas.domain.map.*;

import java.math.*;
import java.util.*;

public class MapLocationTableItemAdded implements AptosEvent, AptosEvent.MutableAptosEvent {
    private MapLocationId mapLocationId;

    public MapLocationId getMapLocationId() {
        return this.mapLocationId;
    }

    public void setMapLocationId(MapLocationId mapLocationId) {
        this.mapLocationId = mapLocationId;
    }

    private BigInteger aptosEventVersion;

    public BigInteger getAptosEventVersion() {
        return this.aptosEventVersion;
    }

    public void setAptosEventVersion(BigInteger aptosEventVersion) {
        this.aptosEventVersion = aptosEventVersion;
    }

    private BigInteger aptosEventSequenceNumber;

    public BigInteger getAptosEventSequenceNumber() {
        return this.aptosEventSequenceNumber;
    }

    public void setAptosEventSequenceNumber(BigInteger aptosEventSequenceNumber) {
        this.aptosEventSequenceNumber = aptosEventSequenceNumber;
    }

    private String aptosEventType;

    public String getAptosEventType() {
        return this.aptosEventType;
    }

    public void setAptosEventType(String aptosEventType) {
        this.aptosEventType = aptosEventType;
    }

    private AptosEventGuid aptosEventGuid;

    public AptosEventGuid getAptosEventGuid() {
        return this.aptosEventGuid;
    }

    public void setAptosEventGuid(AptosEventGuid aptosEventGuid) {
        this.aptosEventGuid = aptosEventGuid;
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

    private Boolean deleted;

    public Boolean getDeleted() {
        return this.deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }

    @Override
    public String toString() {
        return "MapLocationTableItemAdded{" +
                "mapLocationId=" + mapLocationId +
                ", aptosEventVersion=" + aptosEventVersion +
                ", aptosEventSequenceNumber=" + aptosEventSequenceNumber +
                ", aptosEventType=" + '\'' + aptosEventType + '\'' +
                ", aptosEventGuid=" + aptosEventGuid +
                ", createdBy=" + '\'' + createdBy + '\'' +
                ", createdAt=" + createdAt +
                ", updatedBy=" + '\'' + updatedBy + '\'' +
                ", updatedAt=" + updatedAt +
                ", deleted=" + deleted +
                '}';
    }
    
}

