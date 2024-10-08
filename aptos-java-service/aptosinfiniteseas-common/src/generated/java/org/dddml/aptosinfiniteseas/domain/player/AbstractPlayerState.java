// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.player;

import java.util.*;
import java.math.*;
import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.specialization.*;
import org.dddml.aptosinfiniteseas.domain.player.PlayerEvent.*;

public abstract class AbstractPlayerState implements PlayerState.SqlPlayerState {

    private String id;

    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }

    private String owner;

    public String getOwner() {
        return this.owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    private Integer level;

    public Integer getLevel() {
        return this.level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    private Long experience;

    public Long getExperience() {
        return this.experience;
    }

    public void setExperience(Long experience) {
        this.experience = experience;
    }

    private String name;

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    private Coordinates claimedIsland;

    public Coordinates getClaimedIsland() {
        return this.claimedIsland;
    }

    public void setClaimedIsland(Coordinates claimedIsland) {
        this.claimedIsland = claimedIsland;
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

    private Set<ItemIdQuantityPair> inventory;

    public Set<ItemIdQuantityPair> getInventory() {
        return this.inventory;
    }

    public void setInventory(Set<ItemIdQuantityPair> inventory) {
        this.inventory = inventory;
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

    public AbstractPlayerState(List<Event> events) {
        initializeForReapplying();
        if (events != null && events.size() > 0) {
            this.setId(((PlayerEvent.SqlPlayerEvent) events.get(0)).getPlayerEventId().getId());
            for (Event e : events) {
                mutate(e);
                this.setOffChainVersion((this.getOffChainVersion() == null ? PlayerState.VERSION_NULL : this.getOffChainVersion()) + 1);
            }
        }
    }


    public AbstractPlayerState() {
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
        return getId().hashCode();
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) { return true; }
        if (obj instanceof PlayerState) {
            return Objects.equals(this.getId(), ((PlayerState)obj).getId());
        }
        return false;
    }


    public void mutate(Event e) {
        setStateReadOnly(false);
        if (false) { 
            ;
        } else if (e instanceof AbstractPlayerEvent.PlayerAirdropped) {
            when((AbstractPlayerEvent.PlayerAirdropped)e);
        } else {
            throw new UnsupportedOperationException(String.format("Unsupported event type: %1$s", e.getClass().getName()));
        }
    }

    public void merge(PlayerState s) {
        if (s == this) {
            return;
        }
        this.setOwner(s.getOwner());
        this.setLevel(s.getLevel());
        this.setExperience(s.getExperience());
        this.setName(s.getName());
        this.setClaimedIsland(s.getClaimedIsland());
        this.setInventory(s.getInventory());
        this.setVersion(s.getVersion());
        this.setActive(s.getActive());
    }

    public void when(AbstractPlayerEvent.PlayerCreated e) {
        throwOnWrongEvent(e);

        String name = e.getName();
        String Name = name;
        String owner = e.getOwner();
        String Owner = owner;
        BigInteger aptosEventVersion = e.getAptosEventVersion();
        BigInteger AptosEventVersion = aptosEventVersion;
        BigInteger aptosEventSequenceNumber = e.getAptosEventSequenceNumber();
        BigInteger AptosEventSequenceNumber = aptosEventSequenceNumber;
        String aptosEventType = e.getAptosEventType();
        String AptosEventType = aptosEventType;
        AptosEventGuid aptosEventGuid = e.getAptosEventGuid();
        AptosEventGuid AptosEventGuid = aptosEventGuid;
        String eventStatus = e.getEventStatus();
        String EventStatus = eventStatus;

        if (this.getCreatedBy() == null){
            this.setCreatedBy(e.getCreatedBy());
        }
        if (this.getCreatedAt() == null){
            this.setCreatedAt(e.getCreatedAt());
        }
        this.setUpdatedBy(e.getCreatedBy());
        this.setUpdatedAt(e.getCreatedAt());

        PlayerState updatedPlayerState = (PlayerState) ReflectUtils.invokeStaticMethod(
                    "org.dddml.aptosinfiniteseas.domain.player.CreateLogic",
                    "mutate",
                    new Class[]{PlayerState.class, String.class, String.class, BigInteger.class, BigInteger.class, String.class, AptosEventGuid.class, String.class, MutationContext.class},
                    new Object[]{this, name, owner, aptosEventVersion, aptosEventSequenceNumber, aptosEventType, aptosEventGuid, eventStatus, MutationContext.forEvent(e, s -> {if (s == this) {return this;} else {throw new UnsupportedOperationException();}})}
            );

//package org.dddml.aptosinfiniteseas.domain.player;
//
//public class CreateLogic {
//    public static PlayerState mutate(PlayerState playerState, String name, String owner, BigInteger aptosEventVersion, BigInteger aptosEventSequenceNumber, String aptosEventType, AptosEventGuid aptosEventGuid, String eventStatus, MutationContext<PlayerState, PlayerState.MutablePlayerState> mutationContext) {
//    }
//}

        if (this != updatedPlayerState) { merge(updatedPlayerState); } //else do nothing

    }

    public void when(AbstractPlayerEvent.PlayerUpdated e) {
        throwOnWrongEvent(e);

        Long experienceGained = e.getExperienceGained();
        Long ExperienceGained = experienceGained;
        Integer newLevel = e.getNewLevel();
        Integer NewLevel = newLevel;
        InventoryEntry[] inventoryEntries = e.getInventoryEntries();
        InventoryEntry[] InventoryEntries = inventoryEntries;
        BigInteger aptosEventVersion = e.getAptosEventVersion();
        BigInteger AptosEventVersion = aptosEventVersion;
        BigInteger aptosEventSequenceNumber = e.getAptosEventSequenceNumber();
        BigInteger AptosEventSequenceNumber = aptosEventSequenceNumber;
        String aptosEventType = e.getAptosEventType();
        String AptosEventType = aptosEventType;
        AptosEventGuid aptosEventGuid = e.getAptosEventGuid();
        AptosEventGuid AptosEventGuid = aptosEventGuid;
        String eventStatus = e.getEventStatus();
        String EventStatus = eventStatus;

        if (this.getCreatedBy() == null){
            this.setCreatedBy(e.getCreatedBy());
        }
        if (this.getCreatedAt() == null){
            this.setCreatedAt(e.getCreatedAt());
        }
        this.setUpdatedBy(e.getCreatedBy());
        this.setUpdatedAt(e.getCreatedAt());

        PlayerState updatedPlayerState = (PlayerState) ReflectUtils.invokeStaticMethod(
                    "org.dddml.aptosinfiniteseas.domain.player.UpdateLogic",
                    "mutate",
                    new Class[]{PlayerState.class, Long.class, Integer.class, InventoryEntry[].class, BigInteger.class, BigInteger.class, String.class, AptosEventGuid.class, String.class, MutationContext.class},
                    new Object[]{this, experienceGained, newLevel, inventoryEntries, aptosEventVersion, aptosEventSequenceNumber, aptosEventType, aptosEventGuid, eventStatus, MutationContext.forEvent(e, s -> {if (s == this) {return this;} else {throw new UnsupportedOperationException();}})}
            );

//package org.dddml.aptosinfiniteseas.domain.player;
//
//public class UpdateLogic {
//    public static PlayerState mutate(PlayerState playerState, Long experienceGained, Integer newLevel, InventoryEntry[] inventoryEntries, BigInteger aptosEventVersion, BigInteger aptosEventSequenceNumber, String aptosEventType, AptosEventGuid aptosEventGuid, String eventStatus, MutationContext<PlayerState, PlayerState.MutablePlayerState> mutationContext) {
//    }
//}

        if (this != updatedPlayerState) { merge(updatedPlayerState); } //else do nothing

    }

    public void when(AbstractPlayerEvent.IslandClaimed e) {
        throwOnWrongEvent(e);

        Coordinates coordinates = e.getCoordinates();
        Coordinates Coordinates = coordinates;
        BigInteger claimedAt = e.getClaimedAt();
        BigInteger ClaimedAt = claimedAt;
        BigInteger aptosEventVersion = e.getAptosEventVersion();
        BigInteger AptosEventVersion = aptosEventVersion;
        BigInteger aptosEventSequenceNumber = e.getAptosEventSequenceNumber();
        BigInteger AptosEventSequenceNumber = aptosEventSequenceNumber;
        String aptosEventType = e.getAptosEventType();
        String AptosEventType = aptosEventType;
        AptosEventGuid aptosEventGuid = e.getAptosEventGuid();
        AptosEventGuid AptosEventGuid = aptosEventGuid;
        String eventStatus = e.getEventStatus();
        String EventStatus = eventStatus;

        if (this.getCreatedBy() == null){
            this.setCreatedBy(e.getCreatedBy());
        }
        if (this.getCreatedAt() == null){
            this.setCreatedAt(e.getCreatedAt());
        }
        this.setUpdatedBy(e.getCreatedBy());
        this.setUpdatedAt(e.getCreatedAt());

        PlayerState updatedPlayerState = (PlayerState) ReflectUtils.invokeStaticMethod(
                    "org.dddml.aptosinfiniteseas.domain.player.ClaimIslandLogic",
                    "mutate",
                    new Class[]{PlayerState.class, Coordinates.class, BigInteger.class, BigInteger.class, BigInteger.class, String.class, AptosEventGuid.class, String.class, MutationContext.class},
                    new Object[]{this, coordinates, claimedAt, aptosEventVersion, aptosEventSequenceNumber, aptosEventType, aptosEventGuid, eventStatus, MutationContext.forEvent(e, s -> {if (s == this) {return this;} else {throw new UnsupportedOperationException();}})}
            );

//package org.dddml.aptosinfiniteseas.domain.player;
//
//public class ClaimIslandLogic {
//    public static PlayerState mutate(PlayerState playerState, Coordinates coordinates, BigInteger claimedAt, BigInteger aptosEventVersion, BigInteger aptosEventSequenceNumber, String aptosEventType, AptosEventGuid aptosEventGuid, String eventStatus, MutationContext<PlayerState, PlayerState.MutablePlayerState> mutationContext) {
//    }
//}

        if (this != updatedPlayerState) { merge(updatedPlayerState); } //else do nothing

    }

    public void when(AbstractPlayerEvent.PlayerAirdropped e) {
        throwOnWrongEvent(e);

        Long itemId = e.getItemId();
        Long ItemId = itemId;
        Long quantity = e.getQuantity();
        Long Quantity = quantity;
        BigInteger aptosEventVersion = e.getAptosEventVersion();
        BigInteger AptosEventVersion = aptosEventVersion;
        BigInteger aptosEventSequenceNumber = e.getAptosEventSequenceNumber();
        BigInteger AptosEventSequenceNumber = aptosEventSequenceNumber;
        String aptosEventType = e.getAptosEventType();
        String AptosEventType = aptosEventType;
        AptosEventGuid aptosEventGuid = e.getAptosEventGuid();
        AptosEventGuid AptosEventGuid = aptosEventGuid;
        String eventStatus = e.getEventStatus();
        String EventStatus = eventStatus;

        if (this.getCreatedBy() == null){
            this.setCreatedBy(e.getCreatedBy());
        }
        if (this.getCreatedAt() == null){
            this.setCreatedAt(e.getCreatedAt());
        }
        this.setUpdatedBy(e.getCreatedBy());
        this.setUpdatedAt(e.getCreatedAt());

        PlayerState updatedPlayerState = (PlayerState) ReflectUtils.invokeStaticMethod(
                    "org.dddml.aptosinfiniteseas.domain.player.AirdropLogic",
                    "mutate",
                    new Class[]{PlayerState.class, Long.class, Long.class, BigInteger.class, BigInteger.class, String.class, AptosEventGuid.class, String.class, MutationContext.class},
                    new Object[]{this, itemId, quantity, aptosEventVersion, aptosEventSequenceNumber, aptosEventType, aptosEventGuid, eventStatus, MutationContext.forEvent(e, s -> {if (s == this) {return this;} else {throw new UnsupportedOperationException();}})}
            );

//package org.dddml.aptosinfiniteseas.domain.player;
//
//public class AirdropLogic {
//    public static PlayerState mutate(PlayerState playerState, Long itemId, Long quantity, BigInteger aptosEventVersion, BigInteger aptosEventSequenceNumber, String aptosEventType, AptosEventGuid aptosEventGuid, String eventStatus, MutationContext<PlayerState, PlayerState.MutablePlayerState> mutationContext) {
//    }
//}

        if (this != updatedPlayerState) { merge(updatedPlayerState); } //else do nothing

    }

    public void when(AbstractPlayerEvent.PlayerIslandResourcesGathered e) {
        throwOnWrongEvent(e);

        BigInteger aptosEventVersion = e.getAptosEventVersion();
        BigInteger AptosEventVersion = aptosEventVersion;
        BigInteger aptosEventSequenceNumber = e.getAptosEventSequenceNumber();
        BigInteger AptosEventSequenceNumber = aptosEventSequenceNumber;
        String aptosEventType = e.getAptosEventType();
        String AptosEventType = aptosEventType;
        AptosEventGuid aptosEventGuid = e.getAptosEventGuid();
        AptosEventGuid AptosEventGuid = aptosEventGuid;
        String eventStatus = e.getEventStatus();
        String EventStatus = eventStatus;

        if (this.getCreatedBy() == null){
            this.setCreatedBy(e.getCreatedBy());
        }
        if (this.getCreatedAt() == null){
            this.setCreatedAt(e.getCreatedAt());
        }
        this.setUpdatedBy(e.getCreatedBy());
        this.setUpdatedAt(e.getCreatedAt());

        PlayerState updatedPlayerState = (PlayerState) ReflectUtils.invokeStaticMethod(
                    "org.dddml.aptosinfiniteseas.domain.player.GatherIslandResourcesLogic",
                    "mutate",
                    new Class[]{PlayerState.class, BigInteger.class, BigInteger.class, String.class, AptosEventGuid.class, String.class, MutationContext.class},
                    new Object[]{this, aptosEventVersion, aptosEventSequenceNumber, aptosEventType, aptosEventGuid, eventStatus, MutationContext.forEvent(e, s -> {if (s == this) {return this;} else {throw new UnsupportedOperationException();}})}
            );

//package org.dddml.aptosinfiniteseas.domain.player;
//
//public class GatherIslandResourcesLogic {
//    public static PlayerState mutate(PlayerState playerState, BigInteger aptosEventVersion, BigInteger aptosEventSequenceNumber, String aptosEventType, AptosEventGuid aptosEventGuid, String eventStatus, MutationContext<PlayerState, PlayerState.MutablePlayerState> mutationContext) {
//    }
//}

        if (this != updatedPlayerState) { merge(updatedPlayerState); } //else do nothing

    }

    public void save() {
    }

    protected void throwOnWrongEvent(PlayerEvent event) {
        String stateEntityId = this.getId(); // Aggregate Id
        String eventEntityId = ((PlayerEvent.SqlPlayerEvent)event).getPlayerEventId().getId(); // EntityBase.Aggregate.GetEventIdPropertyIdName();
        if (!stateEntityId.equals(eventEntityId)) {
            throw DomainError.named("mutateWrongEntity", "Entity Id %1$s in state but entity id %2$s in event", stateEntityId, eventEntityId);
        }


        Long stateVersion = this.getOffChainVersion();

    }


    public static class SimplePlayerState extends AbstractPlayerState {

        public SimplePlayerState() {
        }

        public SimplePlayerState(List<Event> events) {
            super(events);
        }

        public static SimplePlayerState newForReapplying() {
            SimplePlayerState s = new SimplePlayerState();
            s.initializeForReapplying();
            return s;
        }

    }



}

