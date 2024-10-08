// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.item;

import java.util.*;
import java.math.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.specialization.*;


public class ItemStateDto {

    private Long itemId;

    public Long getItemId()
    {
        return this.itemId;
    }

    public void setItemId(Long itemId)
    {
        this.itemId = itemId;
    }

    private String name;

    public String getName()
    {
        return this.name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    private Boolean requiredForCompletion;

    public Boolean getRequiredForCompletion()
    {
        return this.requiredForCompletion;
    }

    public void setRequiredForCompletion(Boolean requiredForCompletion)
    {
        this.requiredForCompletion = requiredForCompletion;
    }

    private Long sellsFor;

    public Long getSellsFor()
    {
        return this.sellsFor;
    }

    public void setSellsFor(Long sellsFor)
    {
        this.sellsFor = sellsFor;
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


    public static class DtoConverter extends AbstractStateDtoConverter
    {
        public static Collection<String> collectionFieldNames = Arrays.asList(new String[]{});

        @Override
        protected boolean isCollectionField(String fieldName) {
            return CollectionUtils.collectionContainsIgnoringCase(collectionFieldNames, fieldName);
        }

        public ItemStateDto[] toItemStateDtoArray(Iterable<ItemState> states) {
            return toItemStateDtoList(states).toArray(new ItemStateDto[0]);
        }

        public List<ItemStateDto> toItemStateDtoList(Iterable<ItemState> states) {
            ArrayList<ItemStateDto> stateDtos = new ArrayList();
            for (ItemState s : states) {
                ItemStateDto dto = toItemStateDto(s);
                stateDtos.add(dto);
            }
            return stateDtos;
        }

        public ItemStateDto toItemStateDto(ItemState state)
        {
            if(state == null) {
                return null;
            }
            ItemStateDto dto = new ItemStateDto();
            if (returnedFieldsContains("ItemId")) {
                dto.setItemId(state.getItemId());
            }
            if (returnedFieldsContains("Name")) {
                dto.setName(state.getName());
            }
            if (returnedFieldsContains("RequiredForCompletion")) {
                dto.setRequiredForCompletion(state.getRequiredForCompletion());
            }
            if (returnedFieldsContains("SellsFor")) {
                dto.setSellsFor(state.getSellsFor());
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
            return dto;
        }

    }
}

