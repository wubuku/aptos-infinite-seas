// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.ship;

import java.util.*;
import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.specialization.*;

public abstract class AbstractShipAggregate extends AbstractAggregate implements ShipAggregate {
    private ShipState.MutableShipState state;

    private List<Event> changes = new ArrayList<Event>();

    public AbstractShipAggregate(ShipState state) {
        this.state = (ShipState.MutableShipState)state;
    }

    public ShipState getState() {
        return this.state;
    }

    public List<Event> getChanges() {
        return this.changes;
    }

    public void throwOnInvalidStateTransition(Command c) {
        ShipCommand.throwOnInvalidStateTransition(this.state, c);
    }

    protected void apply(Event e) {
        onApplying(e);
        state.mutate(e);
        changes.add(e);
    }


    ////////////////////////

    public static class SimpleShipAggregate extends AbstractShipAggregate {
        public SimpleShipAggregate(ShipState state) {
            super(state);
        }

        @Override
        public void create(String owner, Long healthPoints, Long attack, Long protection, Long speed, ItemIdQuantityPairs buildingExpenses, Long offChainVersion, String commandId, String requesterId, ShipCommands.Create c) {
            java.util.function.Supplier<ShipEvent.ShipCreated> eventFactory = () -> newShipCreated(owner, healthPoints, attack, protection, speed, buildingExpenses, offChainVersion, commandId, requesterId);
            ShipEvent.ShipCreated e;
            try {
                e = verifyCreate(eventFactory, owner, healthPoints, attack, protection, speed, buildingExpenses, c);
            } catch (Exception ex) {
                throw new DomainError("VerificationFailed", ex);
            }

            apply(e);
        }

        protected ShipEvent.ShipCreated verifyCreate(java.util.function.Supplier<ShipEvent.ShipCreated> eventFactory, String owner, Long healthPoints, Long attack, Long protection, Long speed, ItemIdQuantityPairs buildingExpenses, ShipCommands.Create c) {
            String Owner = owner;
            Long HealthPoints = healthPoints;
            Long Attack = attack;
            Long Protection = protection;
            Long Speed = speed;
            ItemIdQuantityPairs BuildingExpenses = buildingExpenses;

            ShipEvent.ShipCreated e = (ShipEvent.ShipCreated) ReflectUtils.invokeStaticMethod(
                    "org.dddml.aptosinfiniteseas.domain.ship.CreateLogic",
                    "verify",
                    new Class[]{java.util.function.Supplier.class, ShipState.class, String.class, Long.class, Long.class, Long.class, Long.class, ItemIdQuantityPairs.class, VerificationContext.class},
                    new Object[]{eventFactory, getState(), owner, healthPoints, attack, protection, speed, buildingExpenses, VerificationContext.forCommand(c)}
            );

//package org.dddml.aptosinfiniteseas.domain.ship;
//
//public class CreateLogic {
//    public static ShipEvent.ShipCreated verify(java.util.function.Supplier<ShipEvent.ShipCreated> eventFactory, ShipState shipState, String owner, Long healthPoints, Long attack, Long protection, Long speed, ItemIdQuantityPairs buildingExpenses, VerificationContext verificationContext) {
//    }
//}

            return e;
        }
           

        protected AbstractShipEvent.ShipCreated newShipCreated(String owner, Long healthPoints, Long attack, Long protection, Long speed, ItemIdQuantityPairs buildingExpenses, Long offChainVersion, String commandId, String requesterId) {
            ShipEventId eventId = new ShipEventId(getState().getId(), null);
            AbstractShipEvent.ShipCreated e = new AbstractShipEvent.ShipCreated();

            e.getDynamicProperties().put("owner", owner);
            e.getDynamicProperties().put("healthPoints", healthPoints);
            e.getDynamicProperties().put("attack", attack);
            e.getDynamicProperties().put("protection", protection);
            e.getDynamicProperties().put("speed", speed);
            e.getDynamicProperties().put("buildingExpenses", buildingExpenses);
            e.setAptosEventVersion(null);
            e.setAptosEventSequenceNumber(null);
            e.setAptosEventType(null);
            e.setAptosEventGuid(null);
            e.setEventStatus(null);

            e.setCommandId(commandId);
            e.setCreatedBy(requesterId);
            e.setCreatedAt((java.util.Date)ApplicationContext.current.getTimestampService().now(java.util.Date.class));

            e.setShipEventId(eventId);
            return e;
        }

    }

}
