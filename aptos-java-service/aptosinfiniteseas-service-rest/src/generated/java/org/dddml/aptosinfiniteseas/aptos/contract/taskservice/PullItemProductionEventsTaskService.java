// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.aptos.contract.taskservice;

import org.dddml.aptosinfiniteseas.aptos.contract.service.ItemProductionEventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class PullItemProductionEventsTaskService {

    @Autowired
    private ItemProductionEventService itemProductionEventService;

    @Scheduled(fixedDelayString = "${aptos.contract.pull-item-production-events.item-production-created.fixed-delay:5000}")
    public void pullItemProductionCreatedEvents() {
        itemProductionEventService.pullItemProductionCreatedEvents();
    }

    @Scheduled(fixedDelayString = "${aptos.contract.pull-item-production-events.item-production-updated.fixed-delay:5000}")
    public void pullItemProductionUpdatedEvents() {
        itemProductionEventService.pullItemProductionUpdatedEvents();
    }

}
