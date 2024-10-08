// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.aptos.contract.service;

import com.github.wubuku.aptos.utils.NodeApiClient;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.domain.shipbattle.*;
import org.dddml.aptosinfiniteseas.aptos.contract.repository.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.stream.*;
import java.util.*;
import java.math.*;

@Service
public class AptosShipBattleService {

    @Autowired
    private ShipBattleStateRepository shipBattleStateRepository;


    private AptosShipBattleStateRetriever aptosShipBattleStateRetriever;

    @Autowired
    public AptosShipBattleService(
        @Value("${aptos.contract.address}")
        String aptosContractAddress,
        NodeApiClient aptosNodeApiClient,
        AptosAccountRepository aptosAccountRepository
    ) {
        this.aptosShipBattleStateRetriever = new AptosShipBattleStateRetriever(
                aptosNodeApiClient,
                aptosContractAddress,
                aptosAccountRepository,
                id -> {
                    ShipBattleState.MutableShipBattleState s = new AbstractShipBattleState.SimpleShipBattleState();
                    s.setId(id);
                    return s;
                }
        );
    }

    @Transactional
    public void updateShipBattleState(String id) {
        ShipBattleState shipBattleState = aptosShipBattleStateRetriever.retrieveShipBattleState(id);
        if (shipBattleState == null) {
            return;
        }
        shipBattleStateRepository.merge(shipBattleState);
    }

}

