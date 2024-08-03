// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain;

import java.io.Serializable;
import org.dddml.aptosinfiniteseas.domain.*;

public class InventoryEntry implements Serializable {
    private ItemIdQuantityPair itemIdAndQuantity = new ItemIdQuantityPair();

    public ItemIdQuantityPair getItemIdAndQuantity()
    {
        return this.itemIdAndQuantity;
    }

    public void setItemIdAndQuantity(ItemIdQuantityPair itemIdAndQuantity)
    {
        this.itemIdAndQuantity = itemIdAndQuantity;
    }

    private Integer sign;

    public Integer getSign()
    {
        return this.sign;
    }

    public void setSign(Integer sign)
    {
        this.sign = sign;
    }

    protected Long getItemIdAndQuantityItemId()
    {
        return getItemIdAndQuantity().getItemId();
    }

    protected void setItemIdAndQuantityItemId(Long itemIdAndQuantityItemId)
    {
        getItemIdAndQuantity().setItemId(itemIdAndQuantityItemId);
    }

    protected Long getItemIdAndQuantityQuantity()
    {
        return getItemIdAndQuantity().getQuantity();
    }

    protected void setItemIdAndQuantityQuantity(Long itemIdAndQuantityQuantity)
    {
        getItemIdAndQuantity().setQuantity(itemIdAndQuantityQuantity);
    }

    public InventoryEntry()
    {
    }

    public InventoryEntry(ItemIdQuantityPair itemIdAndQuantity, Integer sign)
    {
        this.itemIdAndQuantity = itemIdAndQuantity;
        this.sign = sign;
    }

    @Override
    public boolean equals(Object obj)
    {
        if (obj == this) {
            return true;
        }
        if (obj == null || obj.getClass() != this.getClass()) {
            return false;
        }

        InventoryEntry other = (InventoryEntry)obj;
        return true 
            && (itemIdAndQuantity == other.itemIdAndQuantity || (itemIdAndQuantity != null && itemIdAndQuantity.equals(other.itemIdAndQuantity)))
            && (sign == other.sign || (sign != null && sign.equals(other.sign)))
            ;
    }

    @Override
    public int hashCode()
    {
        int hash = 0;
        if (this.itemIdAndQuantity != null) {
            hash += 13 * this.itemIdAndQuantity.hashCode();
        }
        if (this.sign != null) {
            hash += 13 * this.sign.hashCode();
        }
        return hash;
    }

    @Override
    public String toString() {
        return "InventoryEntry{" +
                "itemIdAndQuantity=" + itemIdAndQuantity +
                ", sign=" + sign +
                '}';
    }


}
