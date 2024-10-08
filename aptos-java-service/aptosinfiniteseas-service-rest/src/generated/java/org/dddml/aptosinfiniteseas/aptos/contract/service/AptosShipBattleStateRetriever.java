// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.aptos.contract.service;


import com.github.wubuku.aptos.bean.AccountResource;
import com.github.wubuku.aptos.utils.*;
import org.dddml.aptosinfiniteseas.aptos.contract.AptosAccount;
import org.dddml.aptosinfiniteseas.aptos.contract.ContractConstants;
import org.dddml.aptosinfiniteseas.aptos.contract.DomainBeanUtils;
import org.dddml.aptosinfiniteseas.aptos.contract.repository.AptosAccountRepository;
import org.dddml.aptosinfiniteseas.domain.shipbattle.*;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.aptos.contract.ShipBattle;

import java.io.IOException;
import java.math.*;
import java.util.*;
import java.util.function.*;


public class AptosShipBattleStateRetriever {

    private NodeApiClient aptosNodeApiClient;

    private String aptosContractAddress;

    private AptosAccountRepository aptosAccountRepository;

    private Function<String, ShipBattleState.MutableShipBattleState> shipBattleStateFactory;


    public AptosShipBattleStateRetriever(NodeApiClient aptosNodeApiClient,
                                    String aptosContractAddress,
                                    AptosAccountRepository aptosAccountRepository,
                                    Function<String, ShipBattleState.MutableShipBattleState> shipBattleStateFactory
    ) {
        this.aptosNodeApiClient = aptosNodeApiClient;
        this.aptosContractAddress = aptosContractAddress;
        this.aptosAccountRepository = aptosAccountRepository;
        this.shipBattleStateFactory = shipBattleStateFactory;
    }

    public ShipBattleState retrieveShipBattleState(String id) {
        AccountResource<ShipBattle> accountResource;
        try {
            accountResource = aptosNodeApiClient.getAccountResource(id,
                    this.aptosContractAddress + "::" + ContractConstants.SHIP_BATTLE_MODULE_SHIP_BATTLE,
                    ShipBattle.class,
                    null);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        ShipBattle shipBattle = accountResource.getData();
        if (shipBattle == null) {
            return null;
        }
        shipBattle.setId(id);
        return toShipBattleState(shipBattle);
    }

    private ShipBattleState toShipBattleState(ShipBattle shipBattle) {
        ShipBattleState.MutableShipBattleState shipBattleState = shipBattleStateFactory.apply(shipBattle.getId());
        shipBattleState.setVersion(shipBattle.getVersion());
        shipBattleState.setInitiator(shipBattle.getInitiator());
        shipBattleState.setResponder(shipBattle.getResponder());
        shipBattleState.setStatus(shipBattle.getStatus());
        shipBattleState.setInitiatorExperiences(Arrays.asList(shipBattle.getInitiatorExperiences()));
        shipBattleState.setResponderExperiences(Arrays.asList(shipBattle.getResponderExperiences()));
        shipBattleState.setEndedAt(shipBattle.getEndedAt().getVec().size() == 0 ? null : shipBattle.getEndedAt().getVec().get(0));
        shipBattleState.setWinner(shipBattle.getWinner().getVec().size() == 0 ? null : shipBattle.getWinner().getVec().get(0));
        shipBattleState.setRoundNumber(shipBattle.getRoundNumber());
        shipBattleState.setRoundStartedAt(shipBattle.getRoundStartedAt());
        shipBattleState.setRoundMover(shipBattle.getRoundMover().getVec().size() == 0 ? null : shipBattle.getRoundMover().getVec().get(0));
        shipBattleState.setRoundAttackerShip(shipBattle.getRoundAttackerShip().getVec().size() == 0 ? null : shipBattle.getRoundAttackerShip().getVec().get(0));
        shipBattleState.setRoundDefenderShip(shipBattle.getRoundDefenderShip().getVec().size() == 0 ? null : shipBattle.getRoundDefenderShip().getVec().get(0));
        return shipBattleState;
    }

    private String getResourceAccountAddress() {
        return aptosAccountRepository.findById(ContractConstants.RESOURCE_ACCOUNT_ADDRESS)
                .map(AptosAccount::getAddress).orElse(null);
    }

}

