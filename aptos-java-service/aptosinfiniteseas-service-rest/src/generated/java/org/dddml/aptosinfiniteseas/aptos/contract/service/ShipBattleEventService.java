// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.aptos.contract.service;

import com.github.wubuku.aptos.bean.Event;
import com.github.wubuku.aptos.utils.NodeApiClient;

import org.dddml.aptosinfiniteseas.domain.shipbattle.AbstractShipBattleEvent;
import org.dddml.aptosinfiniteseas.aptos.contract.ContractConstants;
import org.dddml.aptosinfiniteseas.aptos.contract.DomainBeanUtils;
import org.dddml.aptosinfiniteseas.aptos.contract.AptosAccount;

import org.dddml.aptosinfiniteseas.aptos.contract.shipbattle.ShipBattleInitiated;
import org.dddml.aptosinfiniteseas.aptos.contract.shipbattle.ShipBattleMoveMade;
import org.dddml.aptosinfiniteseas.aptos.contract.shipbattle.ShipBattleLootTaken;
import org.dddml.aptosinfiniteseas.aptos.contract.repository.ShipBattleEventRepository;
import org.dddml.aptosinfiniteseas.aptos.contract.repository.AptosAccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.math.*;
import java.util.*;


@Service
public class ShipBattleEventService {

    @Value("${aptos.contract.address}")
    private String aptosContractAddress;

    @Autowired
    private AptosAccountRepository aptosAccountRepository;

    @Autowired
    private NodeApiClient aptosNodeApiClient;

    @Autowired
    private ShipBattleEventRepository shipBattleEventRepository;

    @Transactional
    public void updateStatusToProcessed(AbstractShipBattleEvent event) {
        event.setEventStatus("D");
        shipBattleEventRepository.save(event);
    }

    @Transactional
    public void pullShipBattleInitiatedEvents() {
        String resourceAccountAddress = getResourceAccountAddress();
        if (resourceAccountAddress == null) {
            return;
        }
        int limit = 1;
        BigInteger cursor = getShipBattleInitiatedEventNextCursor();
        if (cursor == null) {
            cursor = BigInteger.ZERO;
        }
        while (true) {
            List<Event<ShipBattleInitiated>> eventPage;
            try {
                eventPage = aptosNodeApiClient.getEventsByEventHandle(
                        resourceAccountAddress,
                        this.aptosContractAddress + "::" + ContractConstants.SHIP_BATTLE_MODULE_EVENTS,
                        ContractConstants.SHIP_BATTLE_MODULE_SHIP_BATTLE_INITIATED_HANDLE_FIELD,
                        ShipBattleInitiated.class,
                        cursor.longValue(),
                        limit
                );
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

            if (eventPage != null && eventPage.size() > 0) {
                cursor = cursor.add(BigInteger.ONE);
                for (Event<ShipBattleInitiated> eventEnvelope : eventPage) {
                    saveShipBattleInitiated(eventEnvelope);
                }
            } else {
                break;
            }
        }
    }

    private BigInteger getShipBattleInitiatedEventNextCursor() {
        AbstractShipBattleEvent.ShipBattleInitiated lastEvent = shipBattleEventRepository.findFirstShipBattleInitiatedByOrderByAptosEventSequenceNumber();
        return lastEvent != null ? lastEvent.getAptosEventSequenceNumber() : null;
    }

    private void saveShipBattleInitiated(Event<ShipBattleInitiated> eventEnvelope) {
        AbstractShipBattleEvent.ShipBattleInitiated shipBattleInitiated = DomainBeanUtils.toShipBattleInitiated(eventEnvelope);
        if (shipBattleEventRepository.findById(shipBattleInitiated.getShipBattleEventId()).isPresent()) {
            return;
        }
        shipBattleEventRepository.save(shipBattleInitiated);
    }

    @Transactional
    public void pullShipBattleMoveMadeEvents() {
        String resourceAccountAddress = getResourceAccountAddress();
        if (resourceAccountAddress == null) {
            return;
        }
        int limit = 1;
        BigInteger cursor = getShipBattleMoveMadeEventNextCursor();
        if (cursor == null) {
            cursor = BigInteger.ZERO;
        }
        while (true) {
            List<Event<ShipBattleMoveMade>> eventPage;
            try {
                eventPage = aptosNodeApiClient.getEventsByEventHandle(
                        resourceAccountAddress,
                        this.aptosContractAddress + "::" + ContractConstants.SHIP_BATTLE_MODULE_EVENTS,
                        ContractConstants.SHIP_BATTLE_MODULE_SHIP_BATTLE_MOVE_MADE_HANDLE_FIELD,
                        ShipBattleMoveMade.class,
                        cursor.longValue(),
                        limit
                );
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

            if (eventPage != null && eventPage.size() > 0) {
                cursor = cursor.add(BigInteger.ONE);
                for (Event<ShipBattleMoveMade> eventEnvelope : eventPage) {
                    saveShipBattleMoveMade(eventEnvelope);
                }
            } else {
                break;
            }
        }
    }

    private BigInteger getShipBattleMoveMadeEventNextCursor() {
        AbstractShipBattleEvent.ShipBattleMoveMade lastEvent = shipBattleEventRepository.findFirstShipBattleMoveMadeByOrderByAptosEventSequenceNumber();
        return lastEvent != null ? lastEvent.getAptosEventSequenceNumber() : null;
    }

    private void saveShipBattleMoveMade(Event<ShipBattleMoveMade> eventEnvelope) {
        AbstractShipBattleEvent.ShipBattleMoveMade shipBattleMoveMade = DomainBeanUtils.toShipBattleMoveMade(eventEnvelope);
        if (shipBattleEventRepository.findById(shipBattleMoveMade.getShipBattleEventId()).isPresent()) {
            return;
        }
        shipBattleEventRepository.save(shipBattleMoveMade);
    }

    @Transactional
    public void pullShipBattleLootTakenEvents() {
        String resourceAccountAddress = getResourceAccountAddress();
        if (resourceAccountAddress == null) {
            return;
        }
        int limit = 1;
        BigInteger cursor = getShipBattleLootTakenEventNextCursor();
        if (cursor == null) {
            cursor = BigInteger.ZERO;
        }
        while (true) {
            List<Event<ShipBattleLootTaken>> eventPage;
            try {
                eventPage = aptosNodeApiClient.getEventsByEventHandle(
                        resourceAccountAddress,
                        this.aptosContractAddress + "::" + ContractConstants.SHIP_BATTLE_MODULE_EVENTS,
                        ContractConstants.SHIP_BATTLE_MODULE_SHIP_BATTLE_LOOT_TAKEN_HANDLE_FIELD,
                        ShipBattleLootTaken.class,
                        cursor.longValue(),
                        limit
                );
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

            if (eventPage != null && eventPage.size() > 0) {
                cursor = cursor.add(BigInteger.ONE);
                for (Event<ShipBattleLootTaken> eventEnvelope : eventPage) {
                    saveShipBattleLootTaken(eventEnvelope);
                }
            } else {
                break;
            }
        }
    }

    private BigInteger getShipBattleLootTakenEventNextCursor() {
        AbstractShipBattleEvent.ShipBattleLootTaken lastEvent = shipBattleEventRepository.findFirstShipBattleLootTakenByOrderByAptosEventSequenceNumber();
        return lastEvent != null ? lastEvent.getAptosEventSequenceNumber() : null;
    }

    private void saveShipBattleLootTaken(Event<ShipBattleLootTaken> eventEnvelope) {
        AbstractShipBattleEvent.ShipBattleLootTaken shipBattleLootTaken = DomainBeanUtils.toShipBattleLootTaken(eventEnvelope);
        if (shipBattleEventRepository.findById(shipBattleLootTaken.getShipBattleEventId()).isPresent()) {
            return;
        }
        shipBattleEventRepository.save(shipBattleLootTaken);
    }

    private String getResourceAccountAddress() {
        return aptosAccountRepository.findById(ContractConstants.RESOURCE_ACCOUNT_ADDRESS)
                .map(AptosAccount::getAddress).orElse(null);
    }
}
