// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.shipbattle;

import java.util.*;
import java.math.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.specialization.*;
import org.dddml.aptosinfiniteseas.domain.shipbattle.ShipBattleEvent.*;

public abstract class AbstractShipBattleState implements ShipBattleState.SqlShipBattleState {

    private String id;

    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }

    private String initiator;

    public String getInitiator() {
        return this.initiator;
    }

    public void setInitiator(String initiator) {
        this.initiator = initiator;
    }

    private String responder;

    public String getResponder() {
        return this.responder;
    }

    public void setResponder(String responder) {
        this.responder = responder;
    }

    private Integer status;

    public Integer getStatus() {
        return this.status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    private BigInteger endedAt;

    public BigInteger getEndedAt() {
        return this.endedAt;
    }

    public void setEndedAt(BigInteger endedAt) {
        this.endedAt = endedAt;
    }

    private Integer winner;

    public Integer getWinner() {
        return this.winner;
    }

    public void setWinner(Integer winner) {
        this.winner = winner;
    }

    private Long roundNumber;

    public Long getRoundNumber() {
        return this.roundNumber;
    }

    public void setRoundNumber(Long roundNumber) {
        this.roundNumber = roundNumber;
    }

    private BigInteger roundStartedAt;

    public BigInteger getRoundStartedAt() {
        return this.roundStartedAt;
    }

    public void setRoundStartedAt(BigInteger roundStartedAt) {
        this.roundStartedAt = roundStartedAt;
    }

    private Integer roundMover;

    public Integer getRoundMover() {
        return this.roundMover;
    }

    public void setRoundMover(Integer roundMover) {
        this.roundMover = roundMover;
    }

    private String roundAttackerShip;

    public String getRoundAttackerShip() {
        return this.roundAttackerShip;
    }

    public void setRoundAttackerShip(String roundAttackerShip) {
        this.roundAttackerShip = roundAttackerShip;
    }

    private String roundDefenderShip;

    public String getRoundDefenderShip() {
        return this.roundDefenderShip;
    }

    public void setRoundDefenderShip(String roundDefenderShip) {
        this.roundDefenderShip = roundDefenderShip;
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

    private List<Long> initiatorExperiences;

    public List<Long> getInitiatorExperiences() {
        return this.initiatorExperiences;
    }

    public void setInitiatorExperiences(List<Long> initiatorExperiences) {
        this.initiatorExperiences = initiatorExperiences;
    }

    private List<Long> responderExperiences;

    public List<Long> getResponderExperiences() {
        return this.responderExperiences;
    }

    public void setResponderExperiences(List<Long> responderExperiences) {
        this.responderExperiences = responderExperiences;
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

    public AbstractShipBattleState(List<Event> events) {
        initializeForReapplying();
        if (events != null && events.size() > 0) {
            this.setId(((ShipBattleEvent.SqlShipBattleEvent) events.get(0)).getShipBattleEventId().getId());
            for (Event e : events) {
                mutate(e);
                this.setOffChainVersion((this.getOffChainVersion() == null ? ShipBattleState.VERSION_NULL : this.getOffChainVersion()) + 1);
            }
        }
    }


    public AbstractShipBattleState() {
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
        if (obj instanceof ShipBattleState) {
            return Objects.equals(this.getId(), ((ShipBattleState)obj).getId());
        }
        return false;
    }


    public void mutate(Event e) {
        setStateReadOnly(false);
        if (false) { 
            ;
        } else if (e instanceof AbstractShipBattleEvent.ShipBattleInitiated) {
            when((AbstractShipBattleEvent.ShipBattleInitiated)e);
        } else if (e instanceof AbstractShipBattleEvent.ShipBattleMoveMade) {
            when((AbstractShipBattleEvent.ShipBattleMoveMade)e);
        } else if (e instanceof AbstractShipBattleEvent.ShipBattleLootTaken) {
            when((AbstractShipBattleEvent.ShipBattleLootTaken)e);
        } else {
            throw new UnsupportedOperationException(String.format("Unsupported event type: %1$s", e.getClass().getName()));
        }
    }

    public void merge(ShipBattleState s) {
        if (s == this) {
            return;
        }
        this.setInitiator(s.getInitiator());
        this.setResponder(s.getResponder());
        this.setStatus(s.getStatus());
        this.setInitiatorExperiences(s.getInitiatorExperiences());
        this.setResponderExperiences(s.getResponderExperiences());
        this.setEndedAt(s.getEndedAt());
        this.setWinner(s.getWinner());
        this.setRoundNumber(s.getRoundNumber());
        this.setRoundStartedAt(s.getRoundStartedAt());
        this.setRoundMover(s.getRoundMover());
        this.setRoundAttackerShip(s.getRoundAttackerShip());
        this.setRoundDefenderShip(s.getRoundDefenderShip());
        this.setVersion(s.getVersion());
        this.setActive(s.getActive());
    }

    public void when(AbstractShipBattleEvent.ShipBattleInitiated e) {
        throwOnWrongEvent(e);

        String playerId = e.getPlayerId();
        String PlayerId = playerId;
        String initiatorId = e.getInitiatorId();
        String InitiatorId = initiatorId;
        String responderId = e.getResponderId();
        String ResponderId = responderId;
        Coordinates initiatorCoordinates = e.getInitiatorCoordinates();
        Coordinates InitiatorCoordinates = initiatorCoordinates;
        Coordinates responderCoordinates = e.getResponderCoordinates();
        Coordinates ResponderCoordinates = responderCoordinates;
        BigInteger startedAt = e.getStartedAt();
        BigInteger StartedAt = startedAt;
        Integer firstRoundMover = e.getFirstRoundMover();
        Integer FirstRoundMover = firstRoundMover;
        String firstRoundAttackerShip = e.getFirstRoundAttackerShip();
        String FirstRoundAttackerShip = firstRoundAttackerShip;
        String firstRoundDefenderShip = e.getFirstRoundDefenderShip();
        String FirstRoundDefenderShip = firstRoundDefenderShip;
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

        ShipBattleState updatedShipBattleState = (ShipBattleState) ReflectUtils.invokeStaticMethod(
                    "org.dddml.aptosinfiniteseas.domain.shipbattle.InitiateBattleLogic",
                    "mutate",
                    new Class[]{ShipBattleState.class, String.class, String.class, String.class, Coordinates.class, Coordinates.class, BigInteger.class, Integer.class, String.class, String.class, BigInteger.class, BigInteger.class, String.class, AptosEventGuid.class, String.class, MutationContext.class},
                    new Object[]{this, playerId, initiatorId, responderId, initiatorCoordinates, responderCoordinates, startedAt, firstRoundMover, firstRoundAttackerShip, firstRoundDefenderShip, aptosEventVersion, aptosEventSequenceNumber, aptosEventType, aptosEventGuid, eventStatus, MutationContext.forEvent(e, s -> {if (s == this) {return this;} else {throw new UnsupportedOperationException();}})}
            );

//package org.dddml.aptosinfiniteseas.domain.shipbattle;
//
//public class InitiateBattleLogic {
//    public static ShipBattleState mutate(ShipBattleState shipBattleState, String playerId, String initiatorId, String responderId, Coordinates initiatorCoordinates, Coordinates responderCoordinates, BigInteger startedAt, Integer firstRoundMover, String firstRoundAttackerShip, String firstRoundDefenderShip, BigInteger aptosEventVersion, BigInteger aptosEventSequenceNumber, String aptosEventType, AptosEventGuid aptosEventGuid, String eventStatus, MutationContext<ShipBattleState, ShipBattleState.MutableShipBattleState> mutationContext) {
//    }
//}

        if (this != updatedShipBattleState) { merge(updatedShipBattleState); } //else do nothing

    }

    public void when(AbstractShipBattleEvent.ShipBattleMoveMade e) {
        throwOnWrongEvent(e);

        String playerId = e.getPlayerId();
        String PlayerId = playerId;
        String initiatorId = e.getInitiatorId();
        String InitiatorId = initiatorId;
        String responderId = e.getResponderId();
        String ResponderId = responderId;
        Integer attackerCommand = e.getAttackerCommand();
        Integer AttackerCommand = attackerCommand;
        Integer defenderCommand = e.getDefenderCommand();
        Integer DefenderCommand = defenderCommand;
        Long roundNumber = e.getRoundNumber();
        Long RoundNumber = roundNumber;
        Long defenderDamageTaken = e.getDefenderDamageTaken();
        Long DefenderDamageTaken = defenderDamageTaken;
        Long attackerDamageTaken = e.getAttackerDamageTaken();
        Long AttackerDamageTaken = attackerDamageTaken;
        Boolean isBattleEnded = e.getIsBattleEnded();
        Boolean IsBattleEnded = isBattleEnded;
        Integer winner = e.getWinner();
        Integer Winner = winner;
        BigInteger nextRoundStartedAt = e.getNextRoundStartedAt();
        BigInteger NextRoundStartedAt = nextRoundStartedAt;
        Integer nextRoundMover = e.getNextRoundMover();
        Integer NextRoundMover = nextRoundMover;
        String nextRoundAttackerShip = e.getNextRoundAttackerShip();
        String NextRoundAttackerShip = nextRoundAttackerShip;
        String nextRoundDefenderShip = e.getNextRoundDefenderShip();
        String NextRoundDefenderShip = nextRoundDefenderShip;
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

        ShipBattleState updatedShipBattleState = (ShipBattleState) ReflectUtils.invokeStaticMethod(
                    "org.dddml.aptosinfiniteseas.domain.shipbattle.MakeMoveLogic",
                    "mutate",
                    new Class[]{ShipBattleState.class, String.class, String.class, String.class, Integer.class, Integer.class, Long.class, Long.class, Long.class, Boolean.class, Integer.class, BigInteger.class, Integer.class, String.class, String.class, BigInteger.class, BigInteger.class, String.class, AptosEventGuid.class, String.class, MutationContext.class},
                    new Object[]{this, playerId, initiatorId, responderId, attackerCommand, defenderCommand, roundNumber, defenderDamageTaken, attackerDamageTaken, isBattleEnded, winner, nextRoundStartedAt, nextRoundMover, nextRoundAttackerShip, nextRoundDefenderShip, aptosEventVersion, aptosEventSequenceNumber, aptosEventType, aptosEventGuid, eventStatus, MutationContext.forEvent(e, s -> {if (s == this) {return this;} else {throw new UnsupportedOperationException();}})}
            );

//package org.dddml.aptosinfiniteseas.domain.shipbattle;
//
//public class MakeMoveLogic {
//    public static ShipBattleState mutate(ShipBattleState shipBattleState, String playerId, String initiatorId, String responderId, Integer attackerCommand, Integer defenderCommand, Long roundNumber, Long defenderDamageTaken, Long attackerDamageTaken, Boolean isBattleEnded, Integer winner, BigInteger nextRoundStartedAt, Integer nextRoundMover, String nextRoundAttackerShip, String nextRoundDefenderShip, BigInteger aptosEventVersion, BigInteger aptosEventSequenceNumber, String aptosEventType, AptosEventGuid aptosEventGuid, String eventStatus, MutationContext<ShipBattleState, ShipBattleState.MutableShipBattleState> mutationContext) {
//    }
//}

        if (this != updatedShipBattleState) { merge(updatedShipBattleState); } //else do nothing

    }

    public void when(AbstractShipBattleEvent.ShipBattleLootTaken e) {
        throwOnWrongEvent(e);

        String playerId = e.getPlayerId();
        String PlayerId = playerId;
        String loserPlayerId = e.getLoserPlayerId();
        String LoserPlayerId = loserPlayerId;
        String initiatorId = e.getInitiatorId();
        String InitiatorId = initiatorId;
        String responderId = e.getResponderId();
        String ResponderId = responderId;
        Integer choice = e.getChoice();
        Integer Choice = choice;
        ItemIdQuantityPair[] loot = e.getLoot();
        ItemIdQuantityPair[] Loot = loot;
        BigInteger lootedAt = e.getLootedAt();
        BigInteger LootedAt = lootedAt;
        Long increasedExperience = e.getIncreasedExperience();
        Long IncreasedExperience = increasedExperience;
        Integer newLevel = e.getNewLevel();
        Integer NewLevel = newLevel;
        Long loserIncreasedExperience = e.getLoserIncreasedExperience();
        Long LoserIncreasedExperience = loserIncreasedExperience;
        Integer loserNewLevel = e.getLoserNewLevel();
        Integer LoserNewLevel = loserNewLevel;
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

        ShipBattleState updatedShipBattleState = (ShipBattleState) ReflectUtils.invokeStaticMethod(
                    "org.dddml.aptosinfiniteseas.domain.shipbattle.TakeLootLogic",
                    "mutate",
                    new Class[]{ShipBattleState.class, String.class, String.class, String.class, String.class, Integer.class, ItemIdQuantityPair[].class, BigInteger.class, Long.class, Integer.class, Long.class, Integer.class, BigInteger.class, BigInteger.class, String.class, AptosEventGuid.class, String.class, MutationContext.class},
                    new Object[]{this, playerId, loserPlayerId, initiatorId, responderId, choice, loot, lootedAt, increasedExperience, newLevel, loserIncreasedExperience, loserNewLevel, aptosEventVersion, aptosEventSequenceNumber, aptosEventType, aptosEventGuid, eventStatus, MutationContext.forEvent(e, s -> {if (s == this) {return this;} else {throw new UnsupportedOperationException();}})}
            );

//package org.dddml.aptosinfiniteseas.domain.shipbattle;
//
//public class TakeLootLogic {
//    public static ShipBattleState mutate(ShipBattleState shipBattleState, String playerId, String loserPlayerId, String initiatorId, String responderId, Integer choice, ItemIdQuantityPair[] loot, BigInteger lootedAt, Long increasedExperience, Integer newLevel, Long loserIncreasedExperience, Integer loserNewLevel, BigInteger aptosEventVersion, BigInteger aptosEventSequenceNumber, String aptosEventType, AptosEventGuid aptosEventGuid, String eventStatus, MutationContext<ShipBattleState, ShipBattleState.MutableShipBattleState> mutationContext) {
//    }
//}

        if (this != updatedShipBattleState) { merge(updatedShipBattleState); } //else do nothing

    }

    public void save() {
    }

    protected void throwOnWrongEvent(ShipBattleEvent event) {
        String stateEntityId = this.getId(); // Aggregate Id
        String eventEntityId = ((ShipBattleEvent.SqlShipBattleEvent)event).getShipBattleEventId().getId(); // EntityBase.Aggregate.GetEventIdPropertyIdName();
        if (!stateEntityId.equals(eventEntityId)) {
            throw DomainError.named("mutateWrongEntity", "Entity Id %1$s in state but entity id %2$s in event", stateEntityId, eventEntityId);
        }


        Long stateVersion = this.getOffChainVersion();

    }


    public static class SimpleShipBattleState extends AbstractShipBattleState {

        public SimpleShipBattleState() {
        }

        public SimpleShipBattleState(List<Event> events) {
            super(events);
        }

        public static SimpleShipBattleState newForReapplying() {
            SimpleShipBattleState s = new SimpleShipBattleState();
            s.initializeForReapplying();
            return s;
        }

    }



}
