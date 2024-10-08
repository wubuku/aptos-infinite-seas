// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.aptos.contract.service;

import com.github.wubuku.aptos.bean.Event;
import com.github.wubuku.aptos.utils.NodeApiClient;

import org.dddml.aptosinfiniteseas.domain.itemcreation.AbstractItemCreationEvent;
import org.dddml.aptosinfiniteseas.aptos.contract.ContractConstants;
import org.dddml.aptosinfiniteseas.aptos.contract.DomainBeanUtils;
import org.dddml.aptosinfiniteseas.aptos.contract.AptosAccount;

import org.dddml.aptosinfiniteseas.aptos.contract.itemcreation.ItemCreationCreated;
import org.dddml.aptosinfiniteseas.aptos.contract.itemcreation.ItemCreationUpdated;
import org.dddml.aptosinfiniteseas.aptos.contract.repository.ItemCreationEventRepository;
import org.dddml.aptosinfiniteseas.aptos.contract.repository.AptosAccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.math.*;
import java.util.*;


@Service
public class ItemCreationEventService {

    @Value("${aptos.contract.address}")
    private String aptosContractAddress;

    @Autowired
    private AptosAccountRepository aptosAccountRepository;

    @Autowired
    private NodeApiClient aptosNodeApiClient;

    @Autowired
    private ItemCreationEventRepository itemCreationEventRepository;

    @Transactional
    public void updateStatusToProcessed(AbstractItemCreationEvent event) {
        event.setEventStatus("D");
        itemCreationEventRepository.save(event);
    }

    @Transactional
    public void pullItemCreationCreatedEvents() {
        String resourceAccountAddress = getResourceAccountAddress();
        if (resourceAccountAddress == null) {
            return;
        }
        int limit = 1;
        BigInteger cursor = getItemCreationCreatedEventNextCursor();
        if (cursor == null) {
            cursor = BigInteger.ZERO;
        }
        while (true) {
            List<Event<ItemCreationCreated>> eventPage;
            try {
                eventPage = aptosNodeApiClient.getEventsByEventHandle(
                        resourceAccountAddress,
                        this.aptosContractAddress + "::" + ContractConstants.ITEM_CREATION_MODULE_EVENTS,
                        ContractConstants.ITEM_CREATION_MODULE_ITEM_CREATION_CREATED_HANDLE_FIELD,
                        ItemCreationCreated.class,
                        cursor.longValue(),
                        limit
                );
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

            if (eventPage != null && eventPage.size() > 0) {
                cursor = cursor.add(BigInteger.ONE);
                for (Event<ItemCreationCreated> eventEnvelope : eventPage) {
                    saveItemCreationCreated(eventEnvelope);
                }
            } else {
                break;
            }
        }
    }

    private BigInteger getItemCreationCreatedEventNextCursor() {
        AbstractItemCreationEvent.ItemCreationCreated lastEvent = itemCreationEventRepository.findFirstItemCreationCreatedByOrderByAptosEventSequenceNumber();
        return lastEvent != null ? lastEvent.getAptosEventSequenceNumber() : null;
    }

    private void saveItemCreationCreated(Event<ItemCreationCreated> eventEnvelope) {
        AbstractItemCreationEvent.ItemCreationCreated itemCreationCreated = DomainBeanUtils.toItemCreationCreated(eventEnvelope);
        if (itemCreationEventRepository.findById(itemCreationCreated.getItemCreationEventId()).isPresent()) {
            return;
        }
        itemCreationEventRepository.save(itemCreationCreated);
    }

    @Transactional
    public void pullItemCreationUpdatedEvents() {
        String resourceAccountAddress = getResourceAccountAddress();
        if (resourceAccountAddress == null) {
            return;
        }
        int limit = 1;
        BigInteger cursor = getItemCreationUpdatedEventNextCursor();
        if (cursor == null) {
            cursor = BigInteger.ZERO;
        }
        while (true) {
            List<Event<ItemCreationUpdated>> eventPage;
            try {
                eventPage = aptosNodeApiClient.getEventsByEventHandle(
                        resourceAccountAddress,
                        this.aptosContractAddress + "::" + ContractConstants.ITEM_CREATION_MODULE_EVENTS,
                        ContractConstants.ITEM_CREATION_MODULE_ITEM_CREATION_UPDATED_HANDLE_FIELD,
                        ItemCreationUpdated.class,
                        cursor.longValue(),
                        limit
                );
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

            if (eventPage != null && eventPage.size() > 0) {
                cursor = cursor.add(BigInteger.ONE);
                for (Event<ItemCreationUpdated> eventEnvelope : eventPage) {
                    saveItemCreationUpdated(eventEnvelope);
                }
            } else {
                break;
            }
        }
    }

    private BigInteger getItemCreationUpdatedEventNextCursor() {
        AbstractItemCreationEvent.ItemCreationUpdated lastEvent = itemCreationEventRepository.findFirstItemCreationUpdatedByOrderByAptosEventSequenceNumber();
        return lastEvent != null ? lastEvent.getAptosEventSequenceNumber() : null;
    }

    private void saveItemCreationUpdated(Event<ItemCreationUpdated> eventEnvelope) {
        AbstractItemCreationEvent.ItemCreationUpdated itemCreationUpdated = DomainBeanUtils.toItemCreationUpdated(eventEnvelope);
        if (itemCreationEventRepository.findById(itemCreationUpdated.getItemCreationEventId()).isPresent()) {
            return;
        }
        itemCreationEventRepository.save(itemCreationUpdated);
    }

    private String getResourceAccountAddress() {
        return aptosAccountRepository.findById(ContractConstants.RESOURCE_ACCOUNT_ADDRESS)
                .map(AptosAccount::getAddress).orElse(null);
    }
}
