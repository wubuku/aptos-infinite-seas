// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.aptos.contract.taskservice;

import org.dddml.aptosinfiniteseas.aptos.contract.service.RosterEventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class PullRosterEventsTaskService {

    @Autowired
    private RosterEventService rosterEventService;

    @Scheduled(fixedDelayString = "${aptos.contract.pull-roster-events.roster-created.fixed-delay:5000}")
    public void pullRosterCreatedEvents() {
        rosterEventService.pullRosterCreatedEvents();
    }

    @Scheduled(fixedDelayString = "${aptos.contract.pull-roster-events.environment-roster-created.fixed-delay:5000}")
    public void pullEnvironmentRosterCreatedEvents() {
        rosterEventService.pullEnvironmentRosterCreatedEvents();
    }

    @Scheduled(fixedDelayString = "${aptos.contract.pull-roster-events.roster-ship-added.fixed-delay:5000}")
    public void pullRosterShipAddedEvents() {
        rosterEventService.pullRosterShipAddedEvents();
    }

    @Scheduled(fixedDelayString = "${aptos.contract.pull-roster-events.roster-set-sail.fixed-delay:5000}")
    public void pullRosterSetSailEvents() {
        rosterEventService.pullRosterSetSailEvents();
    }

    @Scheduled(fixedDelayString = "${aptos.contract.pull-roster-events.roster-ships-position-adjusted.fixed-delay:5000}")
    public void pullRosterShipsPositionAdjustedEvents() {
        rosterEventService.pullRosterShipsPositionAdjustedEvents();
    }

    @Scheduled(fixedDelayString = "${aptos.contract.pull-roster-events.roster-ship-transferred.fixed-delay:5000}")
    public void pullRosterShipTransferredEvents() {
        rosterEventService.pullRosterShipTransferredEvents();
    }

    @Scheduled(fixedDelayString = "${aptos.contract.pull-roster-events.roster-ship-inventory-transferred.fixed-delay:5000}")
    public void pullRosterShipInventoryTransferredEvents() {
        rosterEventService.pullRosterShipInventoryTransferredEvents();
    }

    @Scheduled(fixedDelayString = "${aptos.contract.pull-roster-events.roster-ship-inventory-taken-out.fixed-delay:5000}")
    public void pullRosterShipInventoryTakenOutEvents() {
        rosterEventService.pullRosterShipInventoryTakenOutEvents();
    }

    @Scheduled(fixedDelayString = "${aptos.contract.pull-roster-events.roster-ship-inventory-put-in.fixed-delay:5000}")
    public void pullRosterShipInventoryPutInEvents() {
        rosterEventService.pullRosterShipInventoryPutInEvents();
    }

}