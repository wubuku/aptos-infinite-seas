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
public class Ship {

    private String id;

    private Long offChainVersion;

    private String owner;

    private Long healthPoints;

    private Long attack;

    private Long protection;

    private Long speed;

    private ItemIdQuantityPairs buildingExpenses;

    private ItemIdQuantityPair[] inventory;

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

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public Long getHealthPoints() {
        return healthPoints;
    }

    public void setHealthPoints(Long healthPoints) {
        this.healthPoints = healthPoints;
    }

    public Long getAttack() {
        return attack;
    }

    public void setAttack(Long attack) {
        this.attack = attack;
    }

    public Long getProtection() {
        return protection;
    }

    public void setProtection(Long protection) {
        this.protection = protection;
    }

    public Long getSpeed() {
        return speed;
    }

    public void setSpeed(Long speed) {
        this.speed = speed;
    }

    public ItemIdQuantityPairs getBuildingExpenses() {
        return buildingExpenses;
    }

    public void setBuildingExpenses(ItemIdQuantityPairs buildingExpenses) {
        this.buildingExpenses = buildingExpenses;
    }

    public ItemIdQuantityPair[] getInventory() {
        return inventory;
    }

    public void setInventory(ItemIdQuantityPair[] inventory) {
        this.inventory = inventory;
    }

    public BigInteger getVersion() {
        return version;
    }

    public void setVersion(BigInteger version) {
        this.version = version;
    }

    @Override
    public String toString() {
        return "Ship{" +
                ", id=" + '\'' + id + '\'' +
                ", offChainVersion=" + offChainVersion +
                ", owner=" + '\'' + owner + '\'' +
                ", healthPoints=" + healthPoints +
                ", attack=" + attack +
                ", protection=" + protection +
                ", speed=" + speed +
                ", buildingExpenses=" + buildingExpenses +
                ", inventory=" + Arrays.toString(inventory) +
                ", version=" + version +
                '}';
    }

    public static class Tables {
        @JsonProperty("ship_table")
        private Table shipTable;

        public Table getShipTable() {
            return shipTable;
        }

        public void setShipTable(Table shipTable) {
            this.shipTable = shipTable;
        }

        @Override
        public String toString() {
            return "Ship.Tables{" +
                    "shipTable=" + shipTable +
                    '}';
        }
    }

}
