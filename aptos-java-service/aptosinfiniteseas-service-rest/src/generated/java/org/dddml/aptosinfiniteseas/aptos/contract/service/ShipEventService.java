// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.aptos.contract.service;

import com.github.wubuku.aptos.bean.Event;
import com.github.wubuku.aptos.utils.NodeApiClient;

import org.dddml.aptosinfiniteseas.domain.ship.AbstractShipEvent;
import org.dddml.aptosinfiniteseas.aptos.contract.ContractConstants;
import org.dddml.aptosinfiniteseas.aptos.contract.DomainBeanUtils;
import org.dddml.aptosinfiniteseas.aptos.contract.AptosAccount;

import org.dddml.aptosinfiniteseas.aptos.contract.ship.ShipCreated;
import org.dddml.aptosinfiniteseas.aptos.contract.repository.ShipEventRepository;
import org.dddml.aptosinfiniteseas.aptos.contract.repository.AptosAccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.math.*;
import java.util.*;


@Service
public class ShipEventService {

    @Value("${aptos.contract.address}")
    private String aptosContractAddress;

    @Autowired
    private AptosAccountRepository aptosAccountRepository;

    @Autowired
    private NodeApiClient aptosNodeApiClient;

    @Autowired
    private ShipEventRepository shipEventRepository;

    @Transactional
    public void updateStatusToProcessed(AbstractShipEvent event) {
        event.setEventStatus("D");
        shipEventRepository.save(event);
    }

    @Transactional
    public void pullShipCreatedEvents() {
        String resourceAccountAddress = getResourceAccountAddress();
        if (resourceAccountAddress == null) {
            return;
        }
        int limit = 1;
        BigInteger cursor = getShipCreatedEventNextCursor();
        if (cursor == null) {
            cursor = BigInteger.ZERO;
        }
        while (true) {
            List<Event<ShipCreated>> eventPage;
            try {
                eventPage = aptosNodeApiClient.getEventsByEventHandle(
                        resourceAccountAddress,
                        this.aptosContractAddress + "::" + ContractConstants.SHIP_MODULE_EVENTS,
                        ContractConstants.SHIP_MODULE_SHIP_CREATED_HANDLE_FIELD,
                        ShipCreated.class,
                        cursor.longValue(),
                        limit
                );
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

            if (eventPage != null && eventPage.size() > 0) {
                cursor = cursor.add(BigInteger.ONE);
                for (Event<ShipCreated> eventEnvelope : eventPage) {
                    saveShipCreated(eventEnvelope);
                }
            } else {
                break;
            }
        }
    }

    private BigInteger getShipCreatedEventNextCursor() {
        AbstractShipEvent.ShipCreated lastEvent = shipEventRepository.findFirstShipCreatedByOrderByAptosEventSequenceNumber();
        return lastEvent != null ? lastEvent.getAptosEventSequenceNumber() : null;
    }

    private void saveShipCreated(Event<ShipCreated> eventEnvelope) {
        AbstractShipEvent.ShipCreated shipCreated = DomainBeanUtils.toShipCreated(eventEnvelope);
        if (shipEventRepository.findById(shipCreated.getShipEventId()).isPresent()) {
            return;
        }
        shipEventRepository.save(shipCreated);
    }

    private String getResourceAccountAddress() {
        return aptosAccountRepository.findById(ContractConstants.RESOURCE_ACCOUNT_ADDRESS)
                .map(AptosAccount::getAddress).orElse(null);
    }
}
