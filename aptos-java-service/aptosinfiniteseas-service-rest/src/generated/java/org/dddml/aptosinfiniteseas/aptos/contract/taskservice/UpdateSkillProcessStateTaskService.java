// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.aptos.contract.taskservice;

import org.dddml.aptosinfiniteseas.domain.skillprocess.AbstractSkillProcessEvent;
import org.dddml.aptosinfiniteseas.aptos.contract.repository.*;
import org.dddml.aptosinfiniteseas.aptos.contract.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UpdateSkillProcessStateTaskService {

    @Autowired
    private AptosSkillProcessService aptosSkillProcessService;

    @Autowired
    private SkillProcessEventRepository skillProcessEventRepository;

    @Autowired
    private SkillProcessEventService skillProcessEventService;

    @Scheduled(fixedDelayString = "${aptos.contract.update-skill-process-states.fixed-delay:5000}")
    @Transactional
    public void updateSkillProcessStates() {
        AbstractSkillProcessEvent e = skillProcessEventRepository.findFirstByEventStatusIsNull();
        if (e != null) {
            aptosSkillProcessService.updateSkillProcessState(e.getId());
            skillProcessEventService.updateStatusToProcessed(e);
        }
    }

}