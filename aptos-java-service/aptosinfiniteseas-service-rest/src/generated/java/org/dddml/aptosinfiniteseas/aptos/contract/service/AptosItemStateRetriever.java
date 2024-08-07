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
import org.dddml.aptosinfiniteseas.domain.item.*;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.aptos.contract.Item;

import java.io.IOException;
import java.math.*;
import java.util.*;
import java.util.function.*;


public class AptosItemStateRetriever {

    private NodeApiClient aptosNodeApiClient;

    private String aptosContractAddress;

    private AptosAccountRepository aptosAccountRepository;

    private Function<Long, ItemState.MutableItemState> itemStateFactory;


    public AptosItemStateRetriever(NodeApiClient aptosNodeApiClient,
                                    String aptosContractAddress,
                                    AptosAccountRepository aptosAccountRepository,
                                    Function<Long, ItemState.MutableItemState> itemStateFactory
    ) {
        this.aptosNodeApiClient = aptosNodeApiClient;
        this.aptosContractAddress = aptosContractAddress;
        this.aptosAccountRepository = aptosAccountRepository;
        this.itemStateFactory = itemStateFactory;
    }

    public ItemState retrieveItemState(Long itemId) {
        String resourceAccountAddress = getResourceAccountAddress();
        AccountResource<Item.Tables> accountResource;
        try {
            accountResource = aptosNodeApiClient.getAccountResource(resourceAccountAddress,
                    this.aptosContractAddress + "::" + ContractConstants.ITEM_MODULE_TABLES,
                    Item.Tables.class,
                    null);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        String tableHandle = accountResource.getData().getItemTable().getHandle();
        Item item;
        try {
            item = aptosNodeApiClient.getTableItem(
                    tableHandle,
                    ContractConstants.toNumericalAddressType(ContractConstants.ITEM_ID_TYPE, this.aptosContractAddress),
                    this.aptosContractAddress + "::" + ContractConstants.ITEM_MODULE_ITEM,
                    itemId,
                    Item.class,
                    null
            );
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return toItemState(item);
    }

    private ItemState toItemState(Item item) {
        ItemState.MutableItemState itemState = itemStateFactory.apply(item.getItemId());
        itemState.setVersion(item.getVersion());
        itemState.setName(item.getName());
        itemState.setRequiredForCompletion(item.getRequiredForCompletion());
        itemState.setSellsFor(item.getSellsFor());
        return itemState;
    }

    private String getResourceAccountAddress() {
        return aptosAccountRepository.findById(ContractConstants.RESOURCE_ACCOUNT_ADDRESS)
                .map(AptosAccount::getAddress).orElse(null);
    }

}

