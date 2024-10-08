// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.aptos.contract.taskservice;

import org.dddml.aptosinfiniteseas.aptos.contract.service.ItemCreationEventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class PullItemCreationEventsTaskService {

    @Autowired
    private ItemCreationEventService itemCreationEventService;

    @Scheduled(fixedDelayString = "${aptos.contract.pull-item-creation-events.item-creation-created.fixed-delay:5000}")
    public void pullItemCreationCreatedEvents() {
        itemCreationEventService.pullItemCreationCreatedEvents();
    }

    @Scheduled(fixedDelayString = "${aptos.contract.pull-item-creation-events.item-creation-updated.fixed-delay:5000}")
    public void pullItemCreationUpdatedEvents() {
        itemCreationEventService.pullItemCreationUpdatedEvents();
    }

}
