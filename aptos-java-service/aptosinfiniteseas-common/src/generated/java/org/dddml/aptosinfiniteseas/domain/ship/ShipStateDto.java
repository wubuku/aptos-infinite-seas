// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.ship;

import java.util.*;
import java.math.*;
import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.specialization.*;


public class ShipStateDto {

    private String id;

    public String getId()
    {
        return this.id;
    }

    public void setId(String id)
    {
        this.id = id;
    }

    private String owner;

    public String getOwner()
    {
        return this.owner;
    }

    public void setOwner(String owner)
    {
        this.owner = owner;
    }

    private Long healthPoints;

    public Long getHealthPoints()
    {
        return this.healthPoints;
    }

    public void setHealthPoints(Long healthPoints)
    {
        this.healthPoints = healthPoints;
    }

    private Long attack;

    public Long getAttack()
    {
        return this.attack;
    }

    public void setAttack(Long attack)
    {
        this.attack = attack;
    }

    private Long protection;

    public Long getProtection()
    {
        return this.protection;
    }

    public void setProtection(Long protection)
    {
        this.protection = protection;
    }

    private Long speed;

    public Long getSpeed()
    {
        return this.speed;
    }

    public void setSpeed(Long speed)
    {
        this.speed = speed;
    }

    private ItemIdQuantityPairs buildingExpenses;

    public ItemIdQuantityPairs getBuildingExpenses()
    {
        return this.buildingExpenses;
    }

    public void setBuildingExpenses(ItemIdQuantityPairs buildingExpenses)
    {
        this.buildingExpenses = buildingExpenses;
    }

    private BigInteger version;

    public BigInteger getVersion()
    {
        return this.version;
    }

    public void setVersion(BigInteger version)
    {
        this.version = version;
    }

    private Boolean active;

    public Boolean getActive()
    {
        return this.active;
    }

    public void setActive(Boolean active)
    {
        this.active = active;
    }

    private Long offChainVersion;

    public Long getOffChainVersion()
    {
        return this.offChainVersion;
    }

    public void setOffChainVersion(Long offChainVersion)
    {
        this.offChainVersion = offChainVersion;
    }

    private String createdBy;

    public String getCreatedBy()
    {
        return this.createdBy;
    }

    public void setCreatedBy(String createdBy)
    {
        this.createdBy = createdBy;
    }

    private Date createdAt;

    public Date getCreatedAt()
    {
        return this.createdAt;
    }

    public void setCreatedAt(Date createdAt)
    {
        this.createdAt = createdAt;
    }

    private String updatedBy;

    public String getUpdatedBy()
    {
        return this.updatedBy;
    }

    public void setUpdatedBy(String updatedBy)
    {
        this.updatedBy = updatedBy;
    }

    private Date updatedAt;

    public Date getUpdatedAt()
    {
        return this.updatedAt;
    }

    public void setUpdatedAt(Date updatedAt)
    {
        this.updatedAt = updatedAt;
    }

    private ItemIdQuantityPair[] inventory;

    public ItemIdQuantityPair[] getInventory() {
        return this.inventory;
    }

    public void setInventory(ItemIdQuantityPair[] inventory) {
        this.inventory = inventory;
    }


    public static class DtoConverter extends AbstractStateDtoConverter
    {
        public static Collection<String> collectionFieldNames = Arrays.asList(new String[]{});

        @Override
        protected boolean isCollectionField(String fieldName) {
            return CollectionUtils.collectionContainsIgnoringCase(collectionFieldNames, fieldName);
        }

        public ShipStateDto[] toShipStateDtoArray(Iterable<ShipState> states) {
            return toShipStateDtoList(states).toArray(new ShipStateDto[0]);
        }

        public List<ShipStateDto> toShipStateDtoList(Iterable<ShipState> states) {
            ArrayList<ShipStateDto> stateDtos = new ArrayList();
            for (ShipState s : states) {
                ShipStateDto dto = toShipStateDto(s);
                stateDtos.add(dto);
            }
            return stateDtos;
        }

        public ShipStateDto toShipStateDto(ShipState state)
        {
            if(state == null) {
                return null;
            }
            ShipStateDto dto = new ShipStateDto();
            if (returnedFieldsContains("Id")) {
                dto.setId(state.getId());
            }
            if (returnedFieldsContains("Owner")) {
                dto.setOwner(state.getOwner());
            }
            if (returnedFieldsContains("HealthPoints")) {
                dto.setHealthPoints(state.getHealthPoints());
            }
            if (returnedFieldsContains("Attack")) {
                dto.setAttack(state.getAttack());
            }
            if (returnedFieldsContains("Protection")) {
                dto.setProtection(state.getProtection());
            }
            if (returnedFieldsContains("Speed")) {
                dto.setSpeed(state.getSpeed());
            }
            if (returnedFieldsContains("BuildingExpenses")) {
                dto.setBuildingExpenses(state.getBuildingExpenses());
            }
            if (returnedFieldsContains("Version")) {
                dto.setVersion(state.getVersion());
            }
            if (returnedFieldsContains("Active")) {
                dto.setActive(state.getActive());
            }
            if (returnedFieldsContains("OffChainVersion")) {
                dto.setOffChainVersion(state.getOffChainVersion());
            }
            if (returnedFieldsContains("CreatedBy")) {
                dto.setCreatedBy(state.getCreatedBy());
            }
            if (returnedFieldsContains("CreatedAt")) {
                dto.setCreatedAt(state.getCreatedAt());
            }
            if (returnedFieldsContains("UpdatedBy")) {
                dto.setUpdatedBy(state.getUpdatedBy());
            }
            if (returnedFieldsContains("UpdatedAt")) {
                dto.setUpdatedAt(state.getUpdatedAt());
            }
            if (returnedFieldsContains("Inventory")) {
                ArrayList<ItemIdQuantityPair> arrayList = new ArrayList();
                if (state.getInventory() != null) {
                    for (ItemIdQuantityPair s : state.getInventory()) {
                        arrayList.add(s);
                    }
                }
                dto.setInventory(arrayList.toArray(new ItemIdQuantityPair[0]));
            }
            return dto;
        }

    }
}

