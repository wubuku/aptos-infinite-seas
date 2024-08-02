// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.aptos.contract.taskservice;

import org.dddml.aptosinfiniteseas.domain.roster.AbstractRosterEvent;
import org.dddml.aptosinfiniteseas.aptos.contract.repository.*;
import org.dddml.aptosinfiniteseas.aptos.contract.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UpdateRosterStateTaskService {

    @Autowired
    private AptosRosterService aptosRosterService;

    @Autowired
    private RosterEventRepository rosterEventRepository;

    @Autowired
    private RosterEventService rosterEventService;

    @Scheduled(fixedDelayString = "${aptos.contract.update-roster-states.fixed-delay:5000}")
    @Transactional
    public void updateRosterStates() {
        AbstractRosterEvent e = rosterEventRepository.findFirstByEventStatusIsNull();
        if (e != null) {
            aptosRosterService.updateRosterState(e.getId());
            rosterEventService.updateStatusToProcessed(e);
        }
    }

}