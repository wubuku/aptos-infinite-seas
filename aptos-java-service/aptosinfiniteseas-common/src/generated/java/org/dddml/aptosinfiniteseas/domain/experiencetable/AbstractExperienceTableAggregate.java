// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.experiencetable;

import java.util.*;
import org.dddml.aptosinfiniteseas.domain.*;
import java.util.Date;
import java.math.BigInteger;
import org.dddml.aptosinfiniteseas.specialization.*;

public abstract class AbstractExperienceTableAggregate extends AbstractAggregate implements ExperienceTableAggregate {
    private ExperienceTableState.MutableExperienceTableState state;

    private List<Event> changes = new ArrayList<Event>();

    public AbstractExperienceTableAggregate(ExperienceTableState state) {
        this.state = (ExperienceTableState.MutableExperienceTableState)state;
    }

    public ExperienceTableState getState() {
        return this.state;
    }

    public List<Event> getChanges() {
        return this.changes;
    }

    public void throwOnInvalidStateTransition(Command c) {
        ExperienceTableCommand.throwOnInvalidStateTransition(this.state, c);
    }

    protected void apply(Event e) {
        onApplying(e);
        state.mutate(e);
        changes.add(e);
    }


    ////////////////////////

    public static class SimpleExperienceTableAggregate extends AbstractExperienceTableAggregate {
        public SimpleExperienceTableAggregate(ExperienceTableState state) {
            super(state);
        }

        @Override
        public void addLevel(Integer level, Long experience, Long difference, Long offChainVersion, String commandId, String requesterId, ExperienceTableCommands.AddLevel c) {
            java.util.function.Supplier<ExperienceTableEvent.ExperienceLevelAdded> eventFactory = () -> newExperienceLevelAdded(level, experience, difference, offChainVersion, commandId, requesterId);
            ExperienceTableEvent.ExperienceLevelAdded e;
            try {
                e = verifyAddLevel(eventFactory, level, experience, difference, c);
            } catch (Exception ex) {
                throw new DomainError("VerificationFailed", ex);
            }

            apply(e);
        }

        @Override
        public void updateLevel(Integer level, Long experience, Long difference, Long offChainVersion, String commandId, String requesterId, ExperienceTableCommands.UpdateLevel c) {
            java.util.function.Supplier<ExperienceTableEvent.ExperienceLevelUpdated> eventFactory = () -> newExperienceLevelUpdated(level, experience, difference, offChainVersion, commandId, requesterId);
            ExperienceTableEvent.ExperienceLevelUpdated e;
            try {
                e = verifyUpdateLevel(eventFactory, level, experience, difference, c);
            } catch (Exception ex) {
                throw new DomainError("VerificationFailed", ex);
            }

            apply(e);
        }

        protected ExperienceTableEvent.ExperienceTableInitialized verify__Init__(java.util.function.Supplier<ExperienceTableEvent.ExperienceTableInitialized> eventFactory, ExperienceTableCommands.__Init__ c) {

            ExperienceTableEvent.ExperienceTableInitialized e = (ExperienceTableEvent.ExperienceTableInitialized) ReflectUtils.invokeStaticMethod(
                    "org.dddml.aptosinfiniteseas.domain.experiencetable.__Init__Logic",
                    "verify",
                    new Class[]{java.util.function.Supplier.class, ExperienceTableState.class, VerificationContext.class},
                    new Object[]{eventFactory, getState(), VerificationContext.forCommand(c)}
            );

//package org.dddml.aptosinfiniteseas.domain.experiencetable;
//
//public class __Init__Logic {
//    public static ExperienceTableEvent.ExperienceTableInitialized verify(java.util.function.Supplier<ExperienceTableEvent.ExperienceTableInitialized> eventFactory, ExperienceTableState experienceTableState, VerificationContext verificationContext) {
//    }
//}

            return e;
        }
           

        protected ExperienceTableEvent.ExperienceLevelAdded verifyAddLevel(java.util.function.Supplier<ExperienceTableEvent.ExperienceLevelAdded> eventFactory, Integer level, Long experience, Long difference, ExperienceTableCommands.AddLevel c) {
            Integer Level = level;
            Long Experience = experience;
            Long Difference = difference;

            ExperienceTableEvent.ExperienceLevelAdded e = (ExperienceTableEvent.ExperienceLevelAdded) ReflectUtils.invokeStaticMethod(
                    "org.dddml.aptosinfiniteseas.domain.experiencetable.AddLevelLogic",
                    "verify",
                    new Class[]{java.util.function.Supplier.class, ExperienceTableState.class, Integer.class, Long.class, Long.class, VerificationContext.class},
                    new Object[]{eventFactory, getState(), level, experience, difference, VerificationContext.forCommand(c)}
            );

//package org.dddml.aptosinfiniteseas.domain.experiencetable;
//
//public class AddLevelLogic {
//    public static ExperienceTableEvent.ExperienceLevelAdded verify(java.util.function.Supplier<ExperienceTableEvent.ExperienceLevelAdded> eventFactory, ExperienceTableState experienceTableState, Integer level, Long experience, Long difference, VerificationContext verificationContext) {
//    }
//}

            return e;
        }
           

        protected ExperienceTableEvent.ExperienceLevelUpdated verifyUpdateLevel(java.util.function.Supplier<ExperienceTableEvent.ExperienceLevelUpdated> eventFactory, Integer level, Long experience, Long difference, ExperienceTableCommands.UpdateLevel c) {
            Integer Level = level;
            Long Experience = experience;
            Long Difference = difference;

            ExperienceTableEvent.ExperienceLevelUpdated e = (ExperienceTableEvent.ExperienceLevelUpdated) ReflectUtils.invokeStaticMethod(
                    "org.dddml.aptosinfiniteseas.domain.experiencetable.UpdateLevelLogic",
                    "verify",
                    new Class[]{java.util.function.Supplier.class, ExperienceTableState.class, Integer.class, Long.class, Long.class, VerificationContext.class},
                    new Object[]{eventFactory, getState(), level, experience, difference, VerificationContext.forCommand(c)}
            );

//package org.dddml.aptosinfiniteseas.domain.experiencetable;
//
//public class UpdateLevelLogic {
//    public static ExperienceTableEvent.ExperienceLevelUpdated verify(java.util.function.Supplier<ExperienceTableEvent.ExperienceLevelUpdated> eventFactory, ExperienceTableState experienceTableState, Integer level, Long experience, Long difference, VerificationContext verificationContext) {
//    }
//}

            return e;
        }
           

        protected AbstractExperienceTableEvent.ExperienceTableInitialized newExperienceTableInitialized(Long offChainVersion, String commandId, String requesterId) {
            ExperienceTableEventId eventId = new ExperienceTableEventId(getState().getAccountAddress(), null);
            AbstractExperienceTableEvent.ExperienceTableInitialized e = new AbstractExperienceTableEvent.ExperienceTableInitialized();

            e.setAptosEventVersion(null);
            e.setAptosEventSequenceNumber(null);
            e.setAptosEventType(null);
            e.setAptosEventGuid(null);
            e.setEventStatus(null);

            e.setCommandId(commandId);
            e.setCreatedBy(requesterId);
            e.setCreatedAt((java.util.Date)ApplicationContext.current.getTimestampService().now(java.util.Date.class));

            e.setExperienceTableEventId(eventId);
            return e;
        }

        protected AbstractExperienceTableEvent.ExperienceLevelAdded newExperienceLevelAdded(Integer level, Long experience, Long difference, Long offChainVersion, String commandId, String requesterId) {
            ExperienceTableEventId eventId = new ExperienceTableEventId(getState().getAccountAddress(), null);
            AbstractExperienceTableEvent.ExperienceLevelAdded e = new AbstractExperienceTableEvent.ExperienceLevelAdded();

            e.getDynamicProperties().put("level", level);
            e.getDynamicProperties().put("experience", experience);
            e.getDynamicProperties().put("difference", difference);
            e.setAptosEventVersion(null);
            e.setAptosEventSequenceNumber(null);
            e.setAptosEventType(null);
            e.setAptosEventGuid(null);
            e.setEventStatus(null);

            e.setCommandId(commandId);
            e.setCreatedBy(requesterId);
            e.setCreatedAt((java.util.Date)ApplicationContext.current.getTimestampService().now(java.util.Date.class));

            e.setExperienceTableEventId(eventId);
            return e;
        }

        protected AbstractExperienceTableEvent.ExperienceLevelUpdated newExperienceLevelUpdated(Integer level, Long experience, Long difference, Long offChainVersion, String commandId, String requesterId) {
            ExperienceTableEventId eventId = new ExperienceTableEventId(getState().getAccountAddress(), null);
            AbstractExperienceTableEvent.ExperienceLevelUpdated e = new AbstractExperienceTableEvent.ExperienceLevelUpdated();

            e.getDynamicProperties().put("level", level);
            e.getDynamicProperties().put("experience", experience);
            e.getDynamicProperties().put("difference", difference);
            e.setAptosEventVersion(null);
            e.setAptosEventSequenceNumber(null);
            e.setAptosEventType(null);
            e.setAptosEventGuid(null);
            e.setEventStatus(null);

            e.setCommandId(commandId);
            e.setCreatedBy(requesterId);
            e.setCreatedAt((java.util.Date)ApplicationContext.current.getTimestampService().now(java.util.Date.class));

            e.setExperienceTableEventId(eventId);
            return e;
        }

    }

}
