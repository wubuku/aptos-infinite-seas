// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.aptos.contract.service;

import com.github.wubuku.aptos.utils.NodeApiClient;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.domain.experiencetable.*;
import org.dddml.aptosinfiniteseas.aptos.contract.repository.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.stream.*;
import java.util.*;
import java.math.*;

@Service
public class AptosExperienceTableService {

    @Autowired
    private ExperienceTableStateRepository experienceTableStateRepository;


    private AptosExperienceTableStateRetriever aptosExperienceTableStateRetriever;

    @Autowired
    public AptosExperienceTableService(
        @Value("${aptos.contract.address}")
        String aptosContractAddress,
        NodeApiClient aptosNodeApiClient,
        AptosAccountRepository aptosAccountRepository
    ) {
        this.aptosExperienceTableStateRetriever = new AptosExperienceTableStateRetriever(
                aptosNodeApiClient,
                aptosContractAddress,
                aptosAccountRepository,
                accountAddress -> {
                    ExperienceTableState.MutableExperienceTableState s = new AbstractExperienceTableState.SimpleExperienceTableState();
                    s.setAccountAddress(accountAddress);
                    return s;
                }
        );
    }

    @Transactional
    public void updateExperienceTableState(String accountAddress) {
        ExperienceTableState experienceTableState = aptosExperienceTableStateRetriever.retrieveExperienceTableState(accountAddress);
        if (experienceTableState == null) {
            return;
        }
        experienceTableStateRepository.merge(experienceTableState);
    }

}

