// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.aptos.contract.repository;

import org.dddml.aptosinfiniteseas.domain.skillprocess.*;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.*;

public interface SkillProcessEventRepository extends JpaRepository<AbstractSkillProcessEvent, SkillProcessEventId> {

    AbstractSkillProcessEvent findFirstByEventStatusIsNull();

    List<AbstractSkillProcessEvent> findByEventStatusIsNull();

    AbstractSkillProcessEvent.SkillProcessCreated findFirstSkillProcessCreatedByOrderByAptosEventSequenceNumber();

    AbstractSkillProcessEvent.ProductionProcessStarted findFirstProductionProcessStartedByOrderByAptosEventSequenceNumber();

    AbstractSkillProcessEvent.ProductionProcessCompleted findFirstProductionProcessCompletedByOrderByAptosEventSequenceNumber();

    AbstractSkillProcessEvent.ShipProductionProcessStarted findFirstShipProductionProcessStartedByOrderByAptosEventSequenceNumber();

    AbstractSkillProcessEvent.ShipProductionProcessCompleted findFirstShipProductionProcessCompletedByOrderByAptosEventSequenceNumber();

    AbstractSkillProcessEvent.CreationProcessStarted findFirstCreationProcessStartedByOrderByAptosEventSequenceNumber();

    AbstractSkillProcessEvent.CreationProcessCompleted findFirstCreationProcessCompletedByOrderByAptosEventSequenceNumber();

}
