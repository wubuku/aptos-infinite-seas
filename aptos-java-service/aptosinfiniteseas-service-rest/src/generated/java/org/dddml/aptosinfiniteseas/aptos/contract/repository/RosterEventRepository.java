// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.aptos.contract.repository;

import org.dddml.aptosinfiniteseas.domain.roster.*;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.*;

public interface RosterEventRepository extends JpaRepository<AbstractRosterEvent, RosterEventId> {

    AbstractRosterEvent findFirstByEventStatusIsNull();

    List<AbstractRosterEvent> findByEventStatusIsNull();

    AbstractRosterEvent.RosterCreated findFirstRosterCreatedByOrderByAptosEventSequenceNumber();

    AbstractRosterEvent.EnvironmentRosterCreated findFirstEnvironmentRosterCreatedByOrderByAptosEventSequenceNumber();

    AbstractRosterEvent.RosterShipAdded findFirstRosterShipAddedByOrderByAptosEventSequenceNumber();

    AbstractRosterEvent.RosterSetSail findFirstRosterSetSailByOrderByAptosEventSequenceNumber();

    AbstractRosterEvent.RosterShipsPositionAdjusted findFirstRosterShipsPositionAdjustedByOrderByAptosEventSequenceNumber();

    AbstractRosterEvent.RosterShipTransferred findFirstRosterShipTransferredByOrderByAptosEventSequenceNumber();

    AbstractRosterEvent.RosterShipInventoryTransferred findFirstRosterShipInventoryTransferredByOrderByAptosEventSequenceNumber();

    AbstractRosterEvent.RosterShipInventoryTakenOut findFirstRosterShipInventoryTakenOutByOrderByAptosEventSequenceNumber();

    AbstractRosterEvent.RosterShipInventoryPutIn findFirstRosterShipInventoryPutInByOrderByAptosEventSequenceNumber();

}
