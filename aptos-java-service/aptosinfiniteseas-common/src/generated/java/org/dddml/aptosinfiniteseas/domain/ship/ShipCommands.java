// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.ship;

import java.util.*;
import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;

public class ShipCommands {
    private ShipCommands() {
    }

    public static class Create extends AbstractShipCommand implements ShipCommand {

        public String getCommandType() {
            return "Create";
        }

        public void setCommandType(String commandType) {
            //do nothing
        }

        /**
         * Id
         */
        private String id;

        public String getId() {
            return this.id;
        }

        public void setId(String id) {
            this.id = id;
        }

        /**
         * Owner
         */
        private String owner;

        public String getOwner() {
            return this.owner;
        }

        public void setOwner(String owner) {
            this.owner = owner;
        }

        /**
         * Health Points
         */
        private Long healthPoints;

        public Long getHealthPoints() {
            return this.healthPoints;
        }

        public void setHealthPoints(Long healthPoints) {
            this.healthPoints = healthPoints;
        }

        /**
         * Attack
         */
        private Long attack;

        public Long getAttack() {
            return this.attack;
        }

        public void setAttack(Long attack) {
            this.attack = attack;
        }

        /**
         * Protection
         */
        private Long protection;

        public Long getProtection() {
            return this.protection;
        }

        public void setProtection(Long protection) {
            this.protection = protection;
        }

        /**
         * Speed
         */
        private Long speed;

        public Long getSpeed() {
            return this.speed;
        }

        public void setSpeed(Long speed) {
            this.speed = speed;
        }

        /**
         * Building Expenses
         */
        private ItemIdQuantityPairs buildingExpenses;

        public ItemIdQuantityPairs getBuildingExpenses() {
            return this.buildingExpenses;
        }

        public void setBuildingExpenses(ItemIdQuantityPairs buildingExpenses) {
            this.buildingExpenses = buildingExpenses;
        }

        /**
         * Off Chain Version
         */
        private Long offChainVersion;

        public Long getOffChainVersion() {
            return this.offChainVersion;
        }

        public void setOffChainVersion(Long offChainVersion) {
            this.offChainVersion = offChainVersion;
        }

    }

}

