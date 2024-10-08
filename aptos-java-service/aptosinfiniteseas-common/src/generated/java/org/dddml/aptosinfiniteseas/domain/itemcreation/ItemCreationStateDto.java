// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.itemcreation;

import java.util.*;
import java.math.*;
import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.specialization.*;


public class ItemCreationStateDto {

    private SkillTypeItemIdPair itemCreationId;

    public SkillTypeItemIdPair getItemCreationId()
    {
        return this.itemCreationId;
    }

    public void setItemCreationId(SkillTypeItemIdPair itemCreationId)
    {
        this.itemCreationId = itemCreationId;
    }

    private Long resourceCost;

    public Long getResourceCost()
    {
        return this.resourceCost;
    }

    public void setResourceCost(Long resourceCost)
    {
        this.resourceCost = resourceCost;
    }

    private Integer requirementsLevel;

    public Integer getRequirementsLevel()
    {
        return this.requirementsLevel;
    }

    public void setRequirementsLevel(Integer requirementsLevel)
    {
        this.requirementsLevel = requirementsLevel;
    }

    private Long baseQuantity;

    public Long getBaseQuantity()
    {
        return this.baseQuantity;
    }

    public void setBaseQuantity(Long baseQuantity)
    {
        this.baseQuantity = baseQuantity;
    }

    private Long baseExperience;

    public Long getBaseExperience()
    {
        return this.baseExperience;
    }

    public void setBaseExperience(Long baseExperience)
    {
        this.baseExperience = baseExperience;
    }

    private BigInteger baseCreationTime;

    public BigInteger getBaseCreationTime()
    {
        return this.baseCreationTime;
    }

    public void setBaseCreationTime(BigInteger baseCreationTime)
    {
        this.baseCreationTime = baseCreationTime;
    }

    private BigInteger energyCost;

    public BigInteger getEnergyCost()
    {
        return this.energyCost;
    }

    public void setEnergyCost(BigInteger energyCost)
    {
        this.energyCost = energyCost;
    }

    private Integer successRate;

    public Integer getSuccessRate()
    {
        return this.successRate;
    }

    public void setSuccessRate(Integer successRate)
    {
        this.successRate = successRate;
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

        public ItemCreationStateDto[] toItemCreationStateDtoArray(Iterable<ItemCreationState> states) {
            return toItemCreationStateDtoList(states).toArray(new ItemCreationStateDto[0]);
        }

        public List<ItemCreationStateDto> toItemCreationStateDtoList(Iterable<ItemCreationState> states) {
            ArrayList<ItemCreationStateDto> stateDtos = new ArrayList();
            for (ItemCreationState s : states) {
                ItemCreationStateDto dto = toItemCreationStateDto(s);
                stateDtos.add(dto);
            }
            return stateDtos;
        }

        public ItemCreationStateDto toItemCreationStateDto(ItemCreationState state)
        {
            if(state == null) {
                return null;
            }
            ItemCreationStateDto dto = new ItemCreationStateDto();
            if (returnedFieldsContains("ItemCreationId")) {
                dto.setItemCreationId(state.getItemCreationId());
            }
            if (returnedFieldsContains("ResourceCost")) {
                dto.setResourceCost(state.getResourceCost());
            }
            if (returnedFieldsContains("RequirementsLevel")) {
                dto.setRequirementsLevel(state.getRequirementsLevel());
            }
            if (returnedFieldsContains("BaseQuantity")) {
                dto.setBaseQuantity(state.getBaseQuantity());
            }
            if (returnedFieldsContains("BaseExperience")) {
                dto.setBaseExperience(state.getBaseExperience());
            }
            if (returnedFieldsContains("BaseCreationTime")) {
                dto.setBaseCreationTime(state.getBaseCreationTime());
            }
            if (returnedFieldsContains("EnergyCost")) {
                dto.setEnergyCost(state.getEnergyCost());
            }
            if (returnedFieldsContains("SuccessRate")) {
                dto.setSuccessRate(state.getSuccessRate());
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

