// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.aptos.contract;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.github.wubuku.aptos.bean.*;

import java.math.*;
import java.util.*;

@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class Roster {

    private String id;

    private Long offChainVersion;

    private RosterId rosterId;

    private Integer status;

    private Long speed;

    private String[] shipIds;

    private Coordinates updatedCoordinates;

    private BigInteger coordinatesUpdatedAt;

    private com.github.wubuku.aptos.bean.Option<Coordinates> targetCoordinates;

    private com.github.wubuku.aptos.bean.Option<Coordinates> originCoordinates;

    private BigInteger sailDuration;

    private com.github.wubuku.aptos.bean.Option<String> shipBattleId;

    private Boolean environmentOwned;

    private com.github.wubuku.aptos.bean.Option<Long> baseExperience;

    private BigInteger version;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Long getOffChainVersion() {
        return offChainVersion;
    }

    public void setOffChainVersion(Long offChainVersion) {
        this.offChainVersion = offChainVersion;
    }

    public RosterId getRosterId() {
        return rosterId;
    }

    public void setRosterId(RosterId rosterId) {
        this.rosterId = rosterId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Long getSpeed() {
        return speed;
    }

    public void setSpeed(Long speed) {
        this.speed = speed;
    }

    public String[] getShipIds() {
        return shipIds;
    }

    public void setShipIds(String[] shipIds) {
        this.shipIds = shipIds;
    }

    public Coordinates getUpdatedCoordinates() {
        return updatedCoordinates;
    }

    public void setUpdatedCoordinates(Coordinates updatedCoordinates) {
        this.updatedCoordinates = updatedCoordinates;
    }

    public BigInteger getCoordinatesUpdatedAt() {
        return coordinatesUpdatedAt;
    }

    public void setCoordinatesUpdatedAt(BigInteger coordinatesUpdatedAt) {
        this.coordinatesUpdatedAt = coordinatesUpdatedAt;
    }

    public com.github.wubuku.aptos.bean.Option<Coordinates> getTargetCoordinates() {
        return targetCoordinates;
    }

    public void setTargetCoordinates(com.github.wubuku.aptos.bean.Option<Coordinates> targetCoordinates) {
        this.targetCoordinates = targetCoordinates;
    }

    public com.github.wubuku.aptos.bean.Option<Coordinates> getOriginCoordinates() {
        return originCoordinates;
    }

    public void setOriginCoordinates(com.github.wubuku.aptos.bean.Option<Coordinates> originCoordinates) {
        this.originCoordinates = originCoordinates;
    }

    public BigInteger getSailDuration() {
        return sailDuration;
    }

    public void setSailDuration(BigInteger sailDuration) {
        this.sailDuration = sailDuration;
    }

    public com.github.wubuku.aptos.bean.Option<String> getShipBattleId() {
        return shipBattleId;
    }

    public void setShipBattleId(com.github.wubuku.aptos.bean.Option<String> shipBattleId) {
        this.shipBattleId = shipBattleId;
    }

    public Boolean getEnvironmentOwned() {
        return environmentOwned;
    }

    public void setEnvironmentOwned(Boolean environmentOwned) {
        this.environmentOwned = environmentOwned;
    }

    public com.github.wubuku.aptos.bean.Option<Long> getBaseExperience() {
        return baseExperience;
    }

    public void setBaseExperience(com.github.wubuku.aptos.bean.Option<Long> baseExperience) {
        this.baseExperience = baseExperience;
    }

    public BigInteger getVersion() {
        return version;
    }

    public void setVersion(BigInteger version) {
        this.version = version;
    }

    @Override
    public String toString() {
        return "Roster{" +
                ", id=" + '\'' + id + '\'' +
                ", offChainVersion=" + offChainVersion +
                ", rosterId=" + rosterId +
                ", status=" + status +
                ", speed=" + speed +
                ", shipIds=" + Arrays.toString(shipIds) +
                ", updatedCoordinates=" + updatedCoordinates +
                ", coordinatesUpdatedAt=" + coordinatesUpdatedAt +
                ", targetCoordinates=" + targetCoordinates +
                ", originCoordinates=" + originCoordinates +
                ", sailDuration=" + sailDuration +
                ", shipBattleId=" + shipBattleId +
                ", environmentOwned=" + environmentOwned +
                ", baseExperience=" + baseExperience +
                ", version=" + version +
                '}';
    }

    public static class Tables {
        @JsonProperty("roster_table")
        private Table rosterTable;

        public Table getRosterTable() {
            return rosterTable;
        }

        public void setRosterTable(Table rosterTable) {
            this.rosterTable = rosterTable;
        }

        @Override
        public String toString() {
            return "Roster.Tables{" +
                    "rosterTable=" + rosterTable +
                    '}';
        }
    }

}