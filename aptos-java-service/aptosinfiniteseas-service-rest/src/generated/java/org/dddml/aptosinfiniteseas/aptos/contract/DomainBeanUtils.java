// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.aptos.contract;

import java.math.*;

import com.github.wubuku.aptos.bean.Event;
import com.github.wubuku.aptos.bean.Option;
import org.dddml.aptosinfiniteseas.domain.AptosEvent;
import org.dddml.aptosinfiniteseas.domain.AptosEventGuid;
import org.dddml.aptosinfiniteseas.domain.item.AbstractItemEvent;
import org.dddml.aptosinfiniteseas.aptos.contract.item.ItemCreated;
import org.dddml.aptosinfiniteseas.aptos.contract.item.ItemUpdated;
import org.dddml.aptosinfiniteseas.domain.itemcreation.AbstractItemCreationEvent;
import org.dddml.aptosinfiniteseas.aptos.contract.itemcreation.ItemCreationCreated;
import org.dddml.aptosinfiniteseas.aptos.contract.itemcreation.ItemCreationUpdated;
import org.dddml.aptosinfiniteseas.domain.itemproduction.AbstractItemProductionEvent;
import org.dddml.aptosinfiniteseas.aptos.contract.itemproduction.ItemProductionCreated;
import org.dddml.aptosinfiniteseas.aptos.contract.itemproduction.ItemProductionUpdated;
import org.dddml.aptosinfiniteseas.domain.skillprocess.AbstractSkillProcessEvent;
import org.dddml.aptosinfiniteseas.aptos.contract.skillprocess.SkillProcessCreated;
import org.dddml.aptosinfiniteseas.aptos.contract.skillprocess.ProductionProcessStarted;
import org.dddml.aptosinfiniteseas.aptos.contract.skillprocess.ProductionProcessCompleted;
import org.dddml.aptosinfiniteseas.aptos.contract.skillprocess.ShipProductionProcessStarted;
import org.dddml.aptosinfiniteseas.aptos.contract.skillprocess.ShipProductionProcessCompleted;
import org.dddml.aptosinfiniteseas.aptos.contract.skillprocess.CreationProcessStarted;
import org.dddml.aptosinfiniteseas.aptos.contract.skillprocess.CreationProcessCompleted;
import org.dddml.aptosinfiniteseas.domain.player.AbstractPlayerEvent;
import org.dddml.aptosinfiniteseas.aptos.contract.player.PlayerCreated;
import org.dddml.aptosinfiniteseas.aptos.contract.player.PlayerUpdated;
import org.dddml.aptosinfiniteseas.aptos.contract.player.IslandClaimed;
import org.dddml.aptosinfiniteseas.aptos.contract.player.PlayerAirdropped;
import org.dddml.aptosinfiniteseas.aptos.contract.player.PlayerIslandResourcesGathered;
import org.dddml.aptosinfiniteseas.domain.ship.AbstractShipEvent;
import org.dddml.aptosinfiniteseas.aptos.contract.ship.ShipCreated;
import org.dddml.aptosinfiniteseas.domain.roster.AbstractRosterEvent;
import org.dddml.aptosinfiniteseas.aptos.contract.roster.RosterCreated;
import org.dddml.aptosinfiniteseas.aptos.contract.roster.EnvironmentRosterCreated;
import org.dddml.aptosinfiniteseas.aptos.contract.roster.RosterShipAdded;
import org.dddml.aptosinfiniteseas.aptos.contract.roster.RosterSetSail;
import org.dddml.aptosinfiniteseas.aptos.contract.roster.RosterShipsPositionAdjusted;
import org.dddml.aptosinfiniteseas.aptos.contract.roster.RosterShipTransferred;
import org.dddml.aptosinfiniteseas.aptos.contract.roster.RosterShipInventoryTransferred;
import org.dddml.aptosinfiniteseas.aptos.contract.roster.RosterShipInventoryTakenOut;
import org.dddml.aptosinfiniteseas.aptos.contract.roster.RosterShipInventoryPutIn;
import org.dddml.aptosinfiniteseas.domain.shipbattle.AbstractShipBattleEvent;
import org.dddml.aptosinfiniteseas.aptos.contract.shipbattle.ShipBattleInitiated;
import org.dddml.aptosinfiniteseas.aptos.contract.shipbattle.ShipBattleMoveMade;
import org.dddml.aptosinfiniteseas.aptos.contract.shipbattle.ShipBattleLootTaken;
import org.dddml.aptosinfiniteseas.domain.experiencetable.AbstractExperienceTableEvent;
import org.dddml.aptosinfiniteseas.aptos.contract.experiencetable.ExperienceTableInitialized;
import org.dddml.aptosinfiniteseas.aptos.contract.experiencetable.ExperienceLevelAdded;
import org.dddml.aptosinfiniteseas.aptos.contract.experiencetable.ExperienceLevelUpdated;
import org.dddml.aptosinfiniteseas.domain.map.AbstractMapEvent;
import org.dddml.aptosinfiniteseas.aptos.contract.map.MapInitialized;
import org.dddml.aptosinfiniteseas.aptos.contract.map.IslandAdded;
import org.dddml.aptosinfiniteseas.aptos.contract.map.MapIslandClaimed;
import org.dddml.aptosinfiniteseas.aptos.contract.map.IslandResourcesGathered;

/**
 * Utils that convert beans in the contract package to domain beans.
 */
public class DomainBeanUtils {
    private DomainBeanUtils() {
    }

    public static org.dddml.aptosinfiniteseas.domain.Coin toCoin(Coin contractCoin) {
        if (contractCoin == null) {
            return null;
        }
        org.dddml.aptosinfiniteseas.domain.Coin coin = new org.dddml.aptosinfiniteseas.domain.Coin();
        coin.setValue(contractCoin.getValue());
        return coin;
    }

    public static org.dddml.aptosinfiniteseas.domain.Coordinates toCoordinates(Coordinates contractCoordinates) {
        if (contractCoordinates == null) {
            return null;
        }
        org.dddml.aptosinfiniteseas.domain.Coordinates coordinates = new org.dddml.aptosinfiniteseas.domain.Coordinates();
        coordinates.setX(contractCoordinates.getX());
        coordinates.setY(contractCoordinates.getY());
        return coordinates;
    }

    public static org.dddml.aptosinfiniteseas.domain.ExperienceLevel toExperienceLevel(ExperienceLevel contractExperienceLevel) {
        if (contractExperienceLevel == null) {
            return null;
        }
        org.dddml.aptosinfiniteseas.domain.ExperienceLevel experienceLevel = new org.dddml.aptosinfiniteseas.domain.ExperienceLevel();
        experienceLevel.setLevel(contractExperienceLevel.getLevel());
        experienceLevel.setExperience(contractExperienceLevel.getExperience());
        experienceLevel.setDifference(contractExperienceLevel.getDifference());
        return experienceLevel;
    }

    public static org.dddml.aptosinfiniteseas.domain.FAMetadata toFAMetadata(FAMetadata contractFAMetadata) {
        if (contractFAMetadata == null) {
            return null;
        }
        org.dddml.aptosinfiniteseas.domain.FAMetadata faMetadata = new org.dddml.aptosinfiniteseas.domain.FAMetadata();
        faMetadata.setName(contractFAMetadata.getName());
        faMetadata.setSymbol(contractFAMetadata.getSymbol());
        faMetadata.setDecimals(contractFAMetadata.getDecimals());
        faMetadata.setIconUri(contractFAMetadata.getIconUri());
        faMetadata.setProjectUri(contractFAMetadata.getProjectUri());
        return faMetadata;
    }

    public static org.dddml.aptosinfiniteseas.domain.FungibleStore toFungibleStore(FungibleStore contractFungibleStore) {
        if (contractFungibleStore == null) {
            return null;
        }
        org.dddml.aptosinfiniteseas.domain.FungibleStore fungibleStore = new org.dddml.aptosinfiniteseas.domain.FungibleStore();
        fungibleStore.setMetadata(contractFungibleStore.getMetadata());
        fungibleStore.setBalance(contractFungibleStore.getBalance());
        fungibleStore.setFrozen(contractFungibleStore.getFrozen());
        return fungibleStore;
    }

    public static org.dddml.aptosinfiniteseas.domain.InventoryEntry toInventoryEntry(InventoryEntry contractInventoryEntry) {
        if (contractInventoryEntry == null) {
            return null;
        }
        org.dddml.aptosinfiniteseas.domain.InventoryEntry inventoryEntry = new org.dddml.aptosinfiniteseas.domain.InventoryEntry();
        inventoryEntry.setItemIdAndQuantity(toItemIdQuantityPair(contractInventoryEntry.getItemIdAndQuantity()));
        inventoryEntry.setSign(contractInventoryEntry.getSign());
        return inventoryEntry;
    }

    public static org.dddml.aptosinfiniteseas.domain.ItemIdQuantityPair toItemIdQuantityPair(ItemIdQuantityPair contractItemIdQuantityPair) {
        if (contractItemIdQuantityPair == null) {
            return null;
        }
        org.dddml.aptosinfiniteseas.domain.ItemIdQuantityPair itemIdQuantityPair = new org.dddml.aptosinfiniteseas.domain.ItemIdQuantityPair();
        itemIdQuantityPair.setItemId(contractItemIdQuantityPair.getItemId());
        itemIdQuantityPair.setQuantity(contractItemIdQuantityPair.getQuantity());
        return itemIdQuantityPair;
    }

    public static org.dddml.aptosinfiniteseas.domain.ItemIdQuantityPairs toItemIdQuantityPairs(ItemIdQuantityPairs contractItemIdQuantityPairs) {
        if (contractItemIdQuantityPairs == null) {
            return null;
        }
        org.dddml.aptosinfiniteseas.domain.ItemIdQuantityPairs itemIdQuantityPairs = new org.dddml.aptosinfiniteseas.domain.ItemIdQuantityPairs();
        // todo itemIdQuantityPairs.setItems(contractItemIdQuantityPairs.getItems());
        return itemIdQuantityPairs;
    }

    public static org.dddml.aptosinfiniteseas.domain.ObjectDeleteRef toObjectDeleteRef(ObjectDeleteRef contractObjectDeleteRef) {
        if (contractObjectDeleteRef == null) {
            return null;
        }
        org.dddml.aptosinfiniteseas.domain.ObjectDeleteRef objectDeleteRef = new org.dddml.aptosinfiniteseas.domain.ObjectDeleteRef();
        objectDeleteRef.setSelf(contractObjectDeleteRef.getSelf());
        return objectDeleteRef;
    }

    public static org.dddml.aptosinfiniteseas.domain.ObjectExtendRef toObjectExtendRef(ObjectExtendRef contractObjectExtendRef) {
        if (contractObjectExtendRef == null) {
            return null;
        }
        org.dddml.aptosinfiniteseas.domain.ObjectExtendRef objectExtendRef = new org.dddml.aptosinfiniteseas.domain.ObjectExtendRef();
        objectExtendRef.setSelf(contractObjectExtendRef.getSelf());
        return objectExtendRef;
    }

    public static org.dddml.aptosinfiniteseas.domain.ObjectTransferRef toObjectTransferRef(ObjectTransferRef contractObjectTransferRef) {
        if (contractObjectTransferRef == null) {
            return null;
        }
        org.dddml.aptosinfiniteseas.domain.ObjectTransferRef objectTransferRef = new org.dddml.aptosinfiniteseas.domain.ObjectTransferRef();
        objectTransferRef.setSelf(contractObjectTransferRef.getSelf());
        return objectTransferRef;
    }

    public static org.dddml.aptosinfiniteseas.domain.RosterId toRosterId(RosterId contractRosterId) {
        if (contractRosterId == null) {
            return null;
        }
        org.dddml.aptosinfiniteseas.domain.RosterId rosterId = new org.dddml.aptosinfiniteseas.domain.RosterId();
        rosterId.setPlayerId(contractRosterId.getPlayerId());
        rosterId.setSequenceNumber(contractRosterId.getSequenceNumber());
        return rosterId;
    }

    public static org.dddml.aptosinfiniteseas.domain.SkillProcessId toSkillProcessId(SkillProcessId contractSkillProcessId) {
        if (contractSkillProcessId == null) {
            return null;
        }
        org.dddml.aptosinfiniteseas.domain.SkillProcessId skillProcessId = new org.dddml.aptosinfiniteseas.domain.SkillProcessId();
        skillProcessId.setSkillType(contractSkillProcessId.getSkillType());
        skillProcessId.setPlayerId(contractSkillProcessId.getPlayerId());
        skillProcessId.setSequenceNumber(contractSkillProcessId.getSequenceNumber());
        return skillProcessId;
    }

    public static org.dddml.aptosinfiniteseas.domain.SkillTypeItemIdPair toSkillTypeItemIdPair(SkillTypeItemIdPair contractSkillTypeItemIdPair) {
        if (contractSkillTypeItemIdPair == null) {
            return null;
        }
        org.dddml.aptosinfiniteseas.domain.SkillTypeItemIdPair skillTypeItemIdPair = new org.dddml.aptosinfiniteseas.domain.SkillTypeItemIdPair();
        skillTypeItemIdPair.setSkillType(contractSkillTypeItemIdPair.getSkillType());
        skillTypeItemIdPair.setItemId(contractSkillTypeItemIdPair.getItemId());
        return skillTypeItemIdPair;
    }

    public static org.dddml.aptosinfiniteseas.domain.SkillTypePlayerIdPair toSkillTypePlayerIdPair(SkillTypePlayerIdPair contractSkillTypePlayerIdPair) {
        if (contractSkillTypePlayerIdPair == null) {
            return null;
        }
        org.dddml.aptosinfiniteseas.domain.SkillTypePlayerIdPair skillTypePlayerIdPair = new org.dddml.aptosinfiniteseas.domain.SkillTypePlayerIdPair();
        skillTypePlayerIdPair.setSkillType(contractSkillTypePlayerIdPair.getSkillType());
        skillTypePlayerIdPair.setPlayerId(contractSkillTypePlayerIdPair.getPlayerId());
        return skillTypePlayerIdPair;
    }


    public static AbstractItemEvent.ItemCreated toItemCreated(Event<ItemCreated> eventEnvelope) {
        ItemCreated contractEvent = eventEnvelope.getData();

        AbstractItemEvent.ItemCreated itemCreated = new AbstractItemEvent.ItemCreated();
        itemCreated.setItemId(contractEvent.getItemId());
        itemCreated.setDynamicProperties(contractEvent.getDynamicProperties());
        itemCreated.setVersion(BigInteger.valueOf(-1));

        setAptosEventProperties(itemCreated, eventEnvelope);

        return itemCreated;
    }

    public static AbstractItemEvent.ItemUpdated toItemUpdated(Event<ItemUpdated> eventEnvelope) {
        ItemUpdated contractEvent = eventEnvelope.getData();

        AbstractItemEvent.ItemUpdated itemUpdated = new AbstractItemEvent.ItemUpdated();
        itemUpdated.setItemId(contractEvent.getItemId());
        itemUpdated.setDynamicProperties(contractEvent.getDynamicProperties());
        itemUpdated.setVersion(contractEvent.getVersion());

        setAptosEventProperties(itemUpdated, eventEnvelope);

        return itemUpdated;
    }

    public static AbstractItemCreationEvent.ItemCreationCreated toItemCreationCreated(Event<ItemCreationCreated> eventEnvelope) {
        ItemCreationCreated contractEvent = eventEnvelope.getData();

        AbstractItemCreationEvent.ItemCreationCreated itemCreationCreated = new AbstractItemCreationEvent.ItemCreationCreated();
        itemCreationCreated.setItemCreationId(DomainBeanUtils.toSkillTypeItemIdPair(contractEvent.getItemCreationId()));
        itemCreationCreated.setDynamicProperties(contractEvent.getDynamicProperties());
        itemCreationCreated.setVersion(BigInteger.valueOf(-1));

        setAptosEventProperties(itemCreationCreated, eventEnvelope);

        return itemCreationCreated;
    }

    public static AbstractItemCreationEvent.ItemCreationUpdated toItemCreationUpdated(Event<ItemCreationUpdated> eventEnvelope) {
        ItemCreationUpdated contractEvent = eventEnvelope.getData();

        AbstractItemCreationEvent.ItemCreationUpdated itemCreationUpdated = new AbstractItemCreationEvent.ItemCreationUpdated();
        itemCreationUpdated.setItemCreationId(DomainBeanUtils.toSkillTypeItemIdPair(contractEvent.getItemCreationId()));
        itemCreationUpdated.setDynamicProperties(contractEvent.getDynamicProperties());
        itemCreationUpdated.setVersion(contractEvent.getVersion());

        setAptosEventProperties(itemCreationUpdated, eventEnvelope);

        return itemCreationUpdated;
    }

    public static AbstractItemProductionEvent.ItemProductionCreated toItemProductionCreated(Event<ItemProductionCreated> eventEnvelope) {
        ItemProductionCreated contractEvent = eventEnvelope.getData();

        AbstractItemProductionEvent.ItemProductionCreated itemProductionCreated = new AbstractItemProductionEvent.ItemProductionCreated();
        itemProductionCreated.setItemProductionId(DomainBeanUtils.toSkillTypeItemIdPair(contractEvent.getItemProductionId()));
        itemProductionCreated.setDynamicProperties(contractEvent.getDynamicProperties());
        itemProductionCreated.setVersion(BigInteger.valueOf(-1));

        setAptosEventProperties(itemProductionCreated, eventEnvelope);

        return itemProductionCreated;
    }

    public static AbstractItemProductionEvent.ItemProductionUpdated toItemProductionUpdated(Event<ItemProductionUpdated> eventEnvelope) {
        ItemProductionUpdated contractEvent = eventEnvelope.getData();

        AbstractItemProductionEvent.ItemProductionUpdated itemProductionUpdated = new AbstractItemProductionEvent.ItemProductionUpdated();
        itemProductionUpdated.setItemProductionId(DomainBeanUtils.toSkillTypeItemIdPair(contractEvent.getItemProductionId()));
        itemProductionUpdated.setDynamicProperties(contractEvent.getDynamicProperties());
        itemProductionUpdated.setVersion(contractEvent.getVersion());

        setAptosEventProperties(itemProductionUpdated, eventEnvelope);

        return itemProductionUpdated;
    }

    public static AbstractSkillProcessEvent.SkillProcessCreated toSkillProcessCreated(Event<SkillProcessCreated> eventEnvelope) {
        SkillProcessCreated contractEvent = eventEnvelope.getData();

        AbstractSkillProcessEvent.SkillProcessCreated skillProcessCreated = new AbstractSkillProcessEvent.SkillProcessCreated();
        skillProcessCreated.setId(contractEvent.getId().getVec().get(0));
        skillProcessCreated.setDynamicProperties(contractEvent.getDynamicProperties());
        skillProcessCreated.setVersion(BigInteger.valueOf(-1));

        setAptosEventProperties(skillProcessCreated, eventEnvelope);

        return skillProcessCreated;
    }

    public static AbstractSkillProcessEvent.ProductionProcessStarted toProductionProcessStarted(Event<ProductionProcessStarted> eventEnvelope) {
        ProductionProcessStarted contractEvent = eventEnvelope.getData();

        AbstractSkillProcessEvent.ProductionProcessStarted productionProcessStarted = new AbstractSkillProcessEvent.ProductionProcessStarted();
        productionProcessStarted.setId(contractEvent.getId());
        productionProcessStarted.setDynamicProperties(contractEvent.getDynamicProperties());
        productionProcessStarted.setVersion(contractEvent.getVersion());

        setAptosEventProperties(productionProcessStarted, eventEnvelope);

        return productionProcessStarted;
    }

    public static AbstractSkillProcessEvent.ProductionProcessCompleted toProductionProcessCompleted(Event<ProductionProcessCompleted> eventEnvelope) {
        ProductionProcessCompleted contractEvent = eventEnvelope.getData();

        AbstractSkillProcessEvent.ProductionProcessCompleted productionProcessCompleted = new AbstractSkillProcessEvent.ProductionProcessCompleted();
        productionProcessCompleted.setId(contractEvent.getId());
        productionProcessCompleted.setDynamicProperties(contractEvent.getDynamicProperties());
        productionProcessCompleted.setVersion(contractEvent.getVersion());

        setAptosEventProperties(productionProcessCompleted, eventEnvelope);

        return productionProcessCompleted;
    }

    public static AbstractSkillProcessEvent.ShipProductionProcessStarted toShipProductionProcessStarted(Event<ShipProductionProcessStarted> eventEnvelope) {
        ShipProductionProcessStarted contractEvent = eventEnvelope.getData();

        AbstractSkillProcessEvent.ShipProductionProcessStarted shipProductionProcessStarted = new AbstractSkillProcessEvent.ShipProductionProcessStarted();
        shipProductionProcessStarted.setId(contractEvent.getId());
        shipProductionProcessStarted.setDynamicProperties(contractEvent.getDynamicProperties());
        shipProductionProcessStarted.setVersion(contractEvent.getVersion());

        setAptosEventProperties(shipProductionProcessStarted, eventEnvelope);

        return shipProductionProcessStarted;
    }

    public static AbstractSkillProcessEvent.ShipProductionProcessCompleted toShipProductionProcessCompleted(Event<ShipProductionProcessCompleted> eventEnvelope) {
        ShipProductionProcessCompleted contractEvent = eventEnvelope.getData();

        AbstractSkillProcessEvent.ShipProductionProcessCompleted shipProductionProcessCompleted = new AbstractSkillProcessEvent.ShipProductionProcessCompleted();
        shipProductionProcessCompleted.setId(contractEvent.getId());
        shipProductionProcessCompleted.setDynamicProperties(contractEvent.getDynamicProperties());
        shipProductionProcessCompleted.setVersion(contractEvent.getVersion());

        setAptosEventProperties(shipProductionProcessCompleted, eventEnvelope);

        return shipProductionProcessCompleted;
    }

    public static AbstractSkillProcessEvent.CreationProcessStarted toCreationProcessStarted(Event<CreationProcessStarted> eventEnvelope) {
        CreationProcessStarted contractEvent = eventEnvelope.getData();

        AbstractSkillProcessEvent.CreationProcessStarted creationProcessStarted = new AbstractSkillProcessEvent.CreationProcessStarted();
        creationProcessStarted.setId(contractEvent.getId());
        creationProcessStarted.setDynamicProperties(contractEvent.getDynamicProperties());
        creationProcessStarted.setVersion(contractEvent.getVersion());

        setAptosEventProperties(creationProcessStarted, eventEnvelope);

        return creationProcessStarted;
    }

    public static AbstractSkillProcessEvent.CreationProcessCompleted toCreationProcessCompleted(Event<CreationProcessCompleted> eventEnvelope) {
        CreationProcessCompleted contractEvent = eventEnvelope.getData();

        AbstractSkillProcessEvent.CreationProcessCompleted creationProcessCompleted = new AbstractSkillProcessEvent.CreationProcessCompleted();
        creationProcessCompleted.setId(contractEvent.getId());
        creationProcessCompleted.setDynamicProperties(contractEvent.getDynamicProperties());
        creationProcessCompleted.setVersion(contractEvent.getVersion());

        setAptosEventProperties(creationProcessCompleted, eventEnvelope);

        return creationProcessCompleted;
    }

    public static AbstractPlayerEvent.PlayerCreated toPlayerCreated(Event<PlayerCreated> eventEnvelope) {
        PlayerCreated contractEvent = eventEnvelope.getData();

        AbstractPlayerEvent.PlayerCreated playerCreated = new AbstractPlayerEvent.PlayerCreated();
        playerCreated.setId(contractEvent.getId().getVec().get(0));
        playerCreated.setDynamicProperties(contractEvent.getDynamicProperties());
        playerCreated.setVersion(BigInteger.valueOf(-1));

        setAptosEventProperties(playerCreated, eventEnvelope);

        return playerCreated;
    }

    public static AbstractPlayerEvent.PlayerUpdated toPlayerUpdated(Event<PlayerUpdated> eventEnvelope) {
        PlayerUpdated contractEvent = eventEnvelope.getData();

        AbstractPlayerEvent.PlayerUpdated playerUpdated = new AbstractPlayerEvent.PlayerUpdated();
        playerUpdated.setId(contractEvent.getId());
        playerUpdated.setDynamicProperties(contractEvent.getDynamicProperties());
        playerUpdated.setVersion(contractEvent.getVersion());

        setAptosEventProperties(playerUpdated, eventEnvelope);

        return playerUpdated;
    }

    public static AbstractPlayerEvent.IslandClaimed toIslandClaimed(Event<IslandClaimed> eventEnvelope) {
        IslandClaimed contractEvent = eventEnvelope.getData();

        AbstractPlayerEvent.IslandClaimed islandClaimed = new AbstractPlayerEvent.IslandClaimed();
        islandClaimed.setId(contractEvent.getId());
        islandClaimed.setDynamicProperties(contractEvent.getDynamicProperties());
        islandClaimed.setVersion(contractEvent.getVersion());

        setAptosEventProperties(islandClaimed, eventEnvelope);

        return islandClaimed;
    }

    public static AbstractPlayerEvent.PlayerAirdropped toPlayerAirdropped(Event<PlayerAirdropped> eventEnvelope) {
        PlayerAirdropped contractEvent = eventEnvelope.getData();

        AbstractPlayerEvent.PlayerAirdropped playerAirdropped = new AbstractPlayerEvent.PlayerAirdropped();
        playerAirdropped.setId(contractEvent.getId());
        playerAirdropped.setDynamicProperties(contractEvent.getDynamicProperties());
        playerAirdropped.setVersion(contractEvent.getVersion());

        setAptosEventProperties(playerAirdropped, eventEnvelope);

        return playerAirdropped;
    }

    public static AbstractPlayerEvent.PlayerIslandResourcesGathered toPlayerIslandResourcesGathered(Event<PlayerIslandResourcesGathered> eventEnvelope) {
        PlayerIslandResourcesGathered contractEvent = eventEnvelope.getData();

        AbstractPlayerEvent.PlayerIslandResourcesGathered playerIslandResourcesGathered = new AbstractPlayerEvent.PlayerIslandResourcesGathered();
        playerIslandResourcesGathered.setId(contractEvent.getId());
        playerIslandResourcesGathered.setDynamicProperties(contractEvent.getDynamicProperties());
        playerIslandResourcesGathered.setVersion(contractEvent.getVersion());

        setAptosEventProperties(playerIslandResourcesGathered, eventEnvelope);

        return playerIslandResourcesGathered;
    }

    public static AbstractShipEvent.ShipCreated toShipCreated(Event<ShipCreated> eventEnvelope) {
        ShipCreated contractEvent = eventEnvelope.getData();

        AbstractShipEvent.ShipCreated shipCreated = new AbstractShipEvent.ShipCreated();
        shipCreated.setId(contractEvent.getId().getVec().get(0));
        shipCreated.setDynamicProperties(contractEvent.getDynamicProperties());
        shipCreated.setVersion(BigInteger.valueOf(-1));

        setAptosEventProperties(shipCreated, eventEnvelope);

        return shipCreated;
    }

    public static AbstractRosterEvent.RosterCreated toRosterCreated(Event<RosterCreated> eventEnvelope) {
        RosterCreated contractEvent = eventEnvelope.getData();

        AbstractRosterEvent.RosterCreated rosterCreated = new AbstractRosterEvent.RosterCreated();
        rosterCreated.setId(contractEvent.getId().getVec().get(0));
        rosterCreated.setDynamicProperties(contractEvent.getDynamicProperties());
        rosterCreated.setVersion(BigInteger.valueOf(-1));

        setAptosEventProperties(rosterCreated, eventEnvelope);

        return rosterCreated;
    }

    public static AbstractRosterEvent.EnvironmentRosterCreated toEnvironmentRosterCreated(Event<EnvironmentRosterCreated> eventEnvelope) {
        EnvironmentRosterCreated contractEvent = eventEnvelope.getData();

        AbstractRosterEvent.EnvironmentRosterCreated environmentRosterCreated = new AbstractRosterEvent.EnvironmentRosterCreated();
        environmentRosterCreated.setId(contractEvent.getId().getVec().get(0));
        environmentRosterCreated.setDynamicProperties(contractEvent.getDynamicProperties());
        environmentRosterCreated.setVersion(BigInteger.valueOf(-1));

        setAptosEventProperties(environmentRosterCreated, eventEnvelope);

        return environmentRosterCreated;
    }

    public static AbstractRosterEvent.RosterShipAdded toRosterShipAdded(Event<RosterShipAdded> eventEnvelope) {
        RosterShipAdded contractEvent = eventEnvelope.getData();

        AbstractRosterEvent.RosterShipAdded rosterShipAdded = new AbstractRosterEvent.RosterShipAdded();
        rosterShipAdded.setId(contractEvent.getId());
        rosterShipAdded.setDynamicProperties(contractEvent.getDynamicProperties());
        rosterShipAdded.setVersion(contractEvent.getVersion());

        setAptosEventProperties(rosterShipAdded, eventEnvelope);

        return rosterShipAdded;
    }

    public static AbstractRosterEvent.RosterSetSail toRosterSetSail(Event<RosterSetSail> eventEnvelope) {
        RosterSetSail contractEvent = eventEnvelope.getData();

        AbstractRosterEvent.RosterSetSail rosterSetSail = new AbstractRosterEvent.RosterSetSail();
        rosterSetSail.setId(contractEvent.getId());
        rosterSetSail.setDynamicProperties(contractEvent.getDynamicProperties());
        rosterSetSail.setVersion(contractEvent.getVersion());

        setAptosEventProperties(rosterSetSail, eventEnvelope);

        return rosterSetSail;
    }

    public static AbstractRosterEvent.RosterShipsPositionAdjusted toRosterShipsPositionAdjusted(Event<RosterShipsPositionAdjusted> eventEnvelope) {
        RosterShipsPositionAdjusted contractEvent = eventEnvelope.getData();

        AbstractRosterEvent.RosterShipsPositionAdjusted rosterShipsPositionAdjusted = new AbstractRosterEvent.RosterShipsPositionAdjusted();
        rosterShipsPositionAdjusted.setId(contractEvent.getId());
        rosterShipsPositionAdjusted.setDynamicProperties(contractEvent.getDynamicProperties());
        rosterShipsPositionAdjusted.setVersion(contractEvent.getVersion());

        setAptosEventProperties(rosterShipsPositionAdjusted, eventEnvelope);

        return rosterShipsPositionAdjusted;
    }

    public static AbstractRosterEvent.RosterShipTransferred toRosterShipTransferred(Event<RosterShipTransferred> eventEnvelope) {
        RosterShipTransferred contractEvent = eventEnvelope.getData();

        AbstractRosterEvent.RosterShipTransferred rosterShipTransferred = new AbstractRosterEvent.RosterShipTransferred();
        rosterShipTransferred.setId(contractEvent.getId());
        rosterShipTransferred.setDynamicProperties(contractEvent.getDynamicProperties());
        rosterShipTransferred.setVersion(contractEvent.getVersion());

        setAptosEventProperties(rosterShipTransferred, eventEnvelope);

        return rosterShipTransferred;
    }

    public static AbstractRosterEvent.RosterShipInventoryTransferred toRosterShipInventoryTransferred(Event<RosterShipInventoryTransferred> eventEnvelope) {
        RosterShipInventoryTransferred contractEvent = eventEnvelope.getData();

        AbstractRosterEvent.RosterShipInventoryTransferred rosterShipInventoryTransferred = new AbstractRosterEvent.RosterShipInventoryTransferred();
        rosterShipInventoryTransferred.setId(contractEvent.getId());
        rosterShipInventoryTransferred.setDynamicProperties(contractEvent.getDynamicProperties());
        rosterShipInventoryTransferred.setVersion(contractEvent.getVersion());

        setAptosEventProperties(rosterShipInventoryTransferred, eventEnvelope);

        return rosterShipInventoryTransferred;
    }

    public static AbstractRosterEvent.RosterShipInventoryTakenOut toRosterShipInventoryTakenOut(Event<RosterShipInventoryTakenOut> eventEnvelope) {
        RosterShipInventoryTakenOut contractEvent = eventEnvelope.getData();

        AbstractRosterEvent.RosterShipInventoryTakenOut rosterShipInventoryTakenOut = new AbstractRosterEvent.RosterShipInventoryTakenOut();
        rosterShipInventoryTakenOut.setId(contractEvent.getId());
        rosterShipInventoryTakenOut.setDynamicProperties(contractEvent.getDynamicProperties());
        rosterShipInventoryTakenOut.setVersion(contractEvent.getVersion());

        setAptosEventProperties(rosterShipInventoryTakenOut, eventEnvelope);

        return rosterShipInventoryTakenOut;
    }

    public static AbstractRosterEvent.RosterShipInventoryPutIn toRosterShipInventoryPutIn(Event<RosterShipInventoryPutIn> eventEnvelope) {
        RosterShipInventoryPutIn contractEvent = eventEnvelope.getData();

        AbstractRosterEvent.RosterShipInventoryPutIn rosterShipInventoryPutIn = new AbstractRosterEvent.RosterShipInventoryPutIn();
        rosterShipInventoryPutIn.setId(contractEvent.getId());
        rosterShipInventoryPutIn.setDynamicProperties(contractEvent.getDynamicProperties());
        rosterShipInventoryPutIn.setVersion(contractEvent.getVersion());

        setAptosEventProperties(rosterShipInventoryPutIn, eventEnvelope);

        return rosterShipInventoryPutIn;
    }

    public static AbstractShipBattleEvent.ShipBattleInitiated toShipBattleInitiated(Event<ShipBattleInitiated> eventEnvelope) {
        ShipBattleInitiated contractEvent = eventEnvelope.getData();

        AbstractShipBattleEvent.ShipBattleInitiated shipBattleInitiated = new AbstractShipBattleEvent.ShipBattleInitiated();
        shipBattleInitiated.setId(contractEvent.getId().getVec().get(0));
        shipBattleInitiated.setDynamicProperties(contractEvent.getDynamicProperties());
        shipBattleInitiated.setVersion(BigInteger.valueOf(-1));

        setAptosEventProperties(shipBattleInitiated, eventEnvelope);

        return shipBattleInitiated;
    }

    public static AbstractShipBattleEvent.ShipBattleMoveMade toShipBattleMoveMade(Event<ShipBattleMoveMade> eventEnvelope) {
        ShipBattleMoveMade contractEvent = eventEnvelope.getData();

        AbstractShipBattleEvent.ShipBattleMoveMade shipBattleMoveMade = new AbstractShipBattleEvent.ShipBattleMoveMade();
        shipBattleMoveMade.setId(contractEvent.getId());
        shipBattleMoveMade.setDynamicProperties(contractEvent.getDynamicProperties());
        shipBattleMoveMade.setVersion(contractEvent.getVersion());

        setAptosEventProperties(shipBattleMoveMade, eventEnvelope);

        return shipBattleMoveMade;
    }

    public static AbstractShipBattleEvent.ShipBattleLootTaken toShipBattleLootTaken(Event<ShipBattleLootTaken> eventEnvelope) {
        ShipBattleLootTaken contractEvent = eventEnvelope.getData();

        AbstractShipBattleEvent.ShipBattleLootTaken shipBattleLootTaken = new AbstractShipBattleEvent.ShipBattleLootTaken();
        shipBattleLootTaken.setId(contractEvent.getId());
        shipBattleLootTaken.setDynamicProperties(contractEvent.getDynamicProperties());
        shipBattleLootTaken.setVersion(contractEvent.getVersion());

        setAptosEventProperties(shipBattleLootTaken, eventEnvelope);

        return shipBattleLootTaken;
    }

    public static AbstractExperienceTableEvent.ExperienceTableInitialized toExperienceTableInitialized(Event<ExperienceTableInitialized> eventEnvelope) {
        ExperienceTableInitialized contractEvent = eventEnvelope.getData();

        AbstractExperienceTableEvent.ExperienceTableInitialized experienceTableInitialized = new AbstractExperienceTableEvent.ExperienceTableInitialized();
        experienceTableInitialized.setAccountAddress(contractEvent.getAccountAddress());
        experienceTableInitialized.setDynamicProperties(contractEvent.getDynamicProperties());
        experienceTableInitialized.setVersion(BigInteger.valueOf(-1));

        setAptosEventProperties(experienceTableInitialized, eventEnvelope);

        return experienceTableInitialized;
    }

    public static AbstractExperienceTableEvent.ExperienceLevelAdded toExperienceLevelAdded(Event<ExperienceLevelAdded> eventEnvelope) {
        ExperienceLevelAdded contractEvent = eventEnvelope.getData();

        AbstractExperienceTableEvent.ExperienceLevelAdded experienceLevelAdded = new AbstractExperienceTableEvent.ExperienceLevelAdded();
        experienceLevelAdded.setAccountAddress(contractEvent.getAccountAddress());
        experienceLevelAdded.setDynamicProperties(contractEvent.getDynamicProperties());
        experienceLevelAdded.setVersion(contractEvent.getVersion());

        setAptosEventProperties(experienceLevelAdded, eventEnvelope);

        return experienceLevelAdded;
    }

    public static AbstractExperienceTableEvent.ExperienceLevelUpdated toExperienceLevelUpdated(Event<ExperienceLevelUpdated> eventEnvelope) {
        ExperienceLevelUpdated contractEvent = eventEnvelope.getData();

        AbstractExperienceTableEvent.ExperienceLevelUpdated experienceLevelUpdated = new AbstractExperienceTableEvent.ExperienceLevelUpdated();
        experienceLevelUpdated.setAccountAddress(contractEvent.getAccountAddress());
        experienceLevelUpdated.setDynamicProperties(contractEvent.getDynamicProperties());
        experienceLevelUpdated.setVersion(contractEvent.getVersion());

        setAptosEventProperties(experienceLevelUpdated, eventEnvelope);

        return experienceLevelUpdated;
    }

    public static AbstractMapEvent.MapInitialized toMapInitialized(Event<MapInitialized> eventEnvelope) {
        MapInitialized contractEvent = eventEnvelope.getData();

        AbstractMapEvent.MapInitialized mapInitialized = new AbstractMapEvent.MapInitialized();
        mapInitialized.setAccountAddress(contractEvent.getAccountAddress());
        mapInitialized.setDynamicProperties(contractEvent.getDynamicProperties());
        mapInitialized.setVersion(BigInteger.valueOf(-1));

        setAptosEventProperties(mapInitialized, eventEnvelope);

        return mapInitialized;
    }

    public static AbstractMapEvent.IslandAdded toIslandAdded(Event<IslandAdded> eventEnvelope) {
        IslandAdded contractEvent = eventEnvelope.getData();

        AbstractMapEvent.IslandAdded islandAdded = new AbstractMapEvent.IslandAdded();
        islandAdded.setAccountAddress(contractEvent.getAccountAddress());
        islandAdded.setDynamicProperties(contractEvent.getDynamicProperties());
        islandAdded.setVersion(contractEvent.getVersion());

        setAptosEventProperties(islandAdded, eventEnvelope);

        return islandAdded;
    }

    public static AbstractMapEvent.MapIslandClaimed toMapIslandClaimed(Event<MapIslandClaimed> eventEnvelope) {
        MapIslandClaimed contractEvent = eventEnvelope.getData();

        AbstractMapEvent.MapIslandClaimed mapIslandClaimed = new AbstractMapEvent.MapIslandClaimed();
        mapIslandClaimed.setAccountAddress(contractEvent.getAccountAddress());
        mapIslandClaimed.setDynamicProperties(contractEvent.getDynamicProperties());
        mapIslandClaimed.setVersion(contractEvent.getVersion());

        setAptosEventProperties(mapIslandClaimed, eventEnvelope);

        return mapIslandClaimed;
    }

    public static AbstractMapEvent.IslandResourcesGathered toIslandResourcesGathered(Event<IslandResourcesGathered> eventEnvelope) {
        IslandResourcesGathered contractEvent = eventEnvelope.getData();

        AbstractMapEvent.IslandResourcesGathered islandResourcesGathered = new AbstractMapEvent.IslandResourcesGathered();
        islandResourcesGathered.setAccountAddress(contractEvent.getAccountAddress());
        islandResourcesGathered.setDynamicProperties(contractEvent.getDynamicProperties());
        islandResourcesGathered.setVersion(contractEvent.getVersion());

        setAptosEventProperties(islandResourcesGathered, eventEnvelope);

        return islandResourcesGathered;
    }

    public static org.dddml.aptosinfiniteseas.aptos.contract.persistence.MapLocationTableItemAdded toPersistenceMapLocationTableItemAdded(Event<MapLocationTableItemAdded> eventEnvelope) {
        MapLocationTableItemAdded contractEvent = eventEnvelope.getData();
        org.dddml.aptosinfiniteseas.domain.map.MapLocationId id = new org.dddml.aptosinfiniteseas.domain.map.MapLocationId(contractEvent.getMapAccountAddress(), toCoordinates(contractEvent.getCoordinates()));
        org.dddml.aptosinfiniteseas.aptos.contract.persistence.MapLocationTableItemAdded e = new org.dddml.aptosinfiniteseas.aptos.contract.persistence.MapLocationTableItemAdded();
        e.setMapLocationId(id);
        setAptosEventProperties(e, eventEnvelope);
        return e;
    }

    public static void setAptosEventProperties(AptosEvent.MutableAptosEvent domainAptosEvent, Event<?> eventEnvelope) {
        domainAptosEvent.setAptosEventGuid(toAptosEventGuid(eventEnvelope.getGuid()));
        domainAptosEvent.setAptosEventType(eventEnvelope.getType());
        domainAptosEvent.setAptosEventSequenceNumber(new BigInteger(eventEnvelope.getSequenceNumber()));
        domainAptosEvent.setAptosEventVersion(new BigInteger(eventEnvelope.getVersion()));
    }

    public static AptosEventGuid toAptosEventGuid(com.github.wubuku.aptos.bean.Event.Guid eventGuid) {
        return new AptosEventGuid(new BigInteger(eventGuid.getCreationNumber()), eventGuid.getAccountAddress());
    }

    private static <T> T extractOptionalValue(Option<T> optionView) {
        return optionView == null ? null
                : (optionView.getVec() == null || optionView.getVec().size() == 0) ? null
                : optionView.getVec().get(0);
    }
}
