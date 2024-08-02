// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.skillprocess;

import java.util.*;
import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;

public class SkillProcessCommands {
    private SkillProcessCommands() {
    }

    public static class Create extends AbstractSkillProcessCommand implements SkillProcessCommand {

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
         * Skill Process Id
         */
        private SkillProcessId skillProcessId;

        public SkillProcessId getSkillProcessId() {
            return this.skillProcessId;
        }

        public void setSkillProcessId(SkillProcessId skillProcessId) {
            this.skillProcessId = skillProcessId;
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

    public static class StartProduction extends AbstractSkillProcessCommand implements SkillProcessCommand {

        public String getCommandType() {
            return "StartProduction";
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
         * Batch Size
         */
        private Long batchSize;

        public Long getBatchSize() {
            return this.batchSize;
        }

        public void setBatchSize(Long batchSize) {
            this.batchSize = batchSize;
        }

        /**
         * Player Id
         */
        private String playerId;

        public String getPlayerId() {
            return this.playerId;
        }

        public void setPlayerId(String playerId) {
            this.playerId = playerId;
        }

        /**
         * Player Level
         */
        private Integer playerLevel;

        public Integer getPlayerLevel() {
            return this.playerLevel;
        }

        public void setPlayerLevel(Integer playerLevel) {
            this.playerLevel = playerLevel;
        }

        /**
         * Item Production Id
         */
        private SkillTypeItemIdPair itemProductionId;

        public SkillTypeItemIdPair getItemProductionId() {
            return this.itemProductionId;
        }

        public void setItemProductionId(SkillTypeItemIdPair itemProductionId) {
            this.itemProductionId = itemProductionId;
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

    public static class CompleteProduction extends AbstractSkillProcessCommand implements SkillProcessCommand {

        public String getCommandType() {
            return "CompleteProduction";
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
         * Player Id
         */
        private String playerId;

        public String getPlayerId() {
            return this.playerId;
        }

        public void setPlayerId(String playerId) {
            this.playerId = playerId;
        }

        /**
         * Player Level
         */
        private Integer playerLevel;

        public Integer getPlayerLevel() {
            return this.playerLevel;
        }

        public void setPlayerLevel(Integer playerLevel) {
            this.playerLevel = playerLevel;
        }

        /**
         * Player Experience
         */
        private Long playerExperience;

        public Long getPlayerExperience() {
            return this.playerExperience;
        }

        public void setPlayerExperience(Long playerExperience) {
            this.playerExperience = playerExperience;
        }

        /**
         * Item Production Id
         */
        private SkillTypeItemIdPair itemProductionId;

        public SkillTypeItemIdPair getItemProductionId() {
            return this.itemProductionId;
        }

        public void setItemProductionId(SkillTypeItemIdPair itemProductionId) {
            this.itemProductionId = itemProductionId;
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

    public static class StartShipProduction extends AbstractSkillProcessCommand implements SkillProcessCommand {

        public String getCommandType() {
            return "StartShipProduction";
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
         * Production Materials
         */
        private ItemIdQuantityPairs productionMaterials;

        public ItemIdQuantityPairs getProductionMaterials() {
            return this.productionMaterials;
        }

        public void setProductionMaterials(ItemIdQuantityPairs productionMaterials) {
            this.productionMaterials = productionMaterials;
        }

        /**
         * Player Id
         */
        private String playerId;

        public String getPlayerId() {
            return this.playerId;
        }

        public void setPlayerId(String playerId) {
            this.playerId = playerId;
        }

        /**
         * Player Level
         */
        private Integer playerLevel;

        public Integer getPlayerLevel() {
            return this.playerLevel;
        }

        public void setPlayerLevel(Integer playerLevel) {
            this.playerLevel = playerLevel;
        }

        /**
         * Item Production Id
         */
        private SkillTypeItemIdPair itemProductionId;

        public SkillTypeItemIdPair getItemProductionId() {
            return this.itemProductionId;
        }

        public void setItemProductionId(SkillTypeItemIdPair itemProductionId) {
            this.itemProductionId = itemProductionId;
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

    public static class CompleteShipProduction extends AbstractSkillProcessCommand implements SkillProcessCommand {

        public String getCommandType() {
            return "CompleteShipProduction";
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
         * Unassigned Ships
         */
        private String unassignedShips;

        public String getUnassignedShips() {
            return this.unassignedShips;
        }

        public void setUnassignedShips(String unassignedShips) {
            this.unassignedShips = unassignedShips;
        }

        /**
         * Player Id
         */
        private String playerId;

        public String getPlayerId() {
            return this.playerId;
        }

        public void setPlayerId(String playerId) {
            this.playerId = playerId;
        }

        /**
         * Player Level
         */
        private Integer playerLevel;

        public Integer getPlayerLevel() {
            return this.playerLevel;
        }

        public void setPlayerLevel(Integer playerLevel) {
            this.playerLevel = playerLevel;
        }

        /**
         * Player Experience
         */
        private Long playerExperience;

        public Long getPlayerExperience() {
            return this.playerExperience;
        }

        public void setPlayerExperience(Long playerExperience) {
            this.playerExperience = playerExperience;
        }

        /**
         * Item Production Id
         */
        private SkillTypeItemIdPair itemProductionId;

        public SkillTypeItemIdPair getItemProductionId() {
            return this.itemProductionId;
        }

        public void setItemProductionId(SkillTypeItemIdPair itemProductionId) {
            this.itemProductionId = itemProductionId;
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

    public static class StartCreation extends AbstractSkillProcessCommand implements SkillProcessCommand {

        public String getCommandType() {
            return "StartCreation";
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
         * Batch Size
         */
        private Long batchSize;

        public Long getBatchSize() {
            return this.batchSize;
        }

        public void setBatchSize(Long batchSize) {
            this.batchSize = batchSize;
        }

        /**
         * Player Id
         */
        private String playerId;

        public String getPlayerId() {
            return this.playerId;
        }

        public void setPlayerId(String playerId) {
            this.playerId = playerId;
        }

        /**
         * Player Level
         */
        private Integer playerLevel;

        public Integer getPlayerLevel() {
            return this.playerLevel;
        }

        public void setPlayerLevel(Integer playerLevel) {
            this.playerLevel = playerLevel;
        }

        /**
         * Item Creation Id
         */
        private SkillTypeItemIdPair itemCreationId;

        public SkillTypeItemIdPair getItemCreationId() {
            return this.itemCreationId;
        }

        public void setItemCreationId(SkillTypeItemIdPair itemCreationId) {
            this.itemCreationId = itemCreationId;
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

    public static class CompleteCreation extends AbstractSkillProcessCommand implements SkillProcessCommand {

        public String getCommandType() {
            return "CompleteCreation";
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
         * Player Id
         */
        private String playerId;

        public String getPlayerId() {
            return this.playerId;
        }

        public void setPlayerId(String playerId) {
            this.playerId = playerId;
        }

        /**
         * Player Level
         */
        private Integer playerLevel;

        public Integer getPlayerLevel() {
            return this.playerLevel;
        }

        public void setPlayerLevel(Integer playerLevel) {
            this.playerLevel = playerLevel;
        }

        /**
         * Player Experience
         */
        private Long playerExperience;

        public Long getPlayerExperience() {
            return this.playerExperience;
        }

        public void setPlayerExperience(Long playerExperience) {
            this.playerExperience = playerExperience;
        }

        /**
         * Item Creation Id
         */
        private SkillTypeItemIdPair itemCreationId;

        public SkillTypeItemIdPair getItemCreationId() {
            return this.itemCreationId;
        }

        public void setItemCreationId(SkillTypeItemIdPair itemCreationId) {
            this.itemCreationId = itemCreationId;
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

