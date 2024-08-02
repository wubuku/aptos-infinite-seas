// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.aptos.contract.taskservice;

import org.dddml.aptosinfiniteseas.aptos.contract.service.MapEventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class PullMapEventsTaskService {

    @Autowired
    private MapEventService mapEventService;

    @Scheduled(fixedDelayString = "${aptos.contract.pull-map-events.island-added.fixed-delay:5000}")
    public void pullIslandAddedEvents() {
        mapEventService.pullIslandAddedEvents();
    }

    @Scheduled(fixedDelayString = "${aptos.contract.pull-map-events.map-island-claimed.fixed-delay:5000}")
    public void pullMapIslandClaimedEvents() {
        mapEventService.pullMapIslandClaimedEvents();
    }

    @Scheduled(fixedDelayString = "${aptos.contract.pull-map-events.island-resources-gathered.fixed-delay:5000}")
    public void pullIslandResourcesGatheredEvents() {
        mapEventService.pullIslandResourcesGatheredEvents();
    }

}
