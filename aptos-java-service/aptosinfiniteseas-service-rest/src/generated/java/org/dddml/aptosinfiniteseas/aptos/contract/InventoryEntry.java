// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.aptos.contract;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.github.wubuku.aptos.bean.*;

@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class InventoryEntry {

    private ItemIdQuantityPair itemIdAndQuantity;

    private Integer sign;


    public ItemIdQuantityPair getItemIdAndQuantity() {
        return itemIdAndQuantity;
    }

    public void setItemIdAndQuantity(ItemIdQuantityPair itemIdAndQuantity) {
        this.itemIdAndQuantity = itemIdAndQuantity;
    }

    public Integer getSign() {
        return sign;
    }

    public void setSign(Integer sign) {
        this.sign = sign;
    }

    @Override
    public String toString() {
        return "InventoryEntry{" +
                "itemIdAndQuantity=" + itemIdAndQuantity +
                ", sign=" + sign +
                '}';
    }
}
