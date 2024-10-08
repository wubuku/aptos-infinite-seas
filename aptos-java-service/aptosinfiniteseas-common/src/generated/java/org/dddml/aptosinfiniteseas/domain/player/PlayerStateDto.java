// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.player;

import java.util.*;
import java.math.*;
import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.specialization.*;


public class PlayerStateDto {

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

    private Integer level;

    public Integer getLevel()
    {
        return this.level;
    }

    public void setLevel(Integer level)
    {
        this.level = level;
    }

    private Long experience;

    public Long getExperience()
    {
        return this.experience;
    }

    public void setExperience(Long experience)
    {
        this.experience = experience;
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

    private Coordinates claimedIsland;

    public Coordinates getClaimedIsland()
    {
        return this.claimedIsland;
    }

    public void setClaimedIsland(Coordinates claimedIsland)
    {
        this.claimedIsland = claimedIsland;
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

        public PlayerStateDto[] toPlayerStateDtoArray(Iterable<PlayerState> states) {
            return toPlayerStateDtoList(states).toArray(new PlayerStateDto[0]);
        }

        public List<PlayerStateDto> toPlayerStateDtoList(Iterable<PlayerState> states) {
            ArrayList<PlayerStateDto> stateDtos = new ArrayList();
            for (PlayerState s : states) {
                PlayerStateDto dto = toPlayerStateDto(s);
                stateDtos.add(dto);
            }
            return stateDtos;
        }

        public PlayerStateDto toPlayerStateDto(PlayerState state)
        {
            if(state == null) {
                return null;
            }
            PlayerStateDto dto = new PlayerStateDto();
            if (returnedFieldsContains("Id")) {
                dto.setId(state.getId());
            }
            if (returnedFieldsContains("Owner")) {
                dto.setOwner(state.getOwner());
            }
            if (returnedFieldsContains("Level")) {
                dto.setLevel(state.getLevel());
            }
            if (returnedFieldsContains("Experience")) {
                dto.setExperience(state.getExperience());
            }
            if (returnedFieldsContains("Name")) {
                dto.setName(state.getName());
            }
            if (returnedFieldsContains("ClaimedIsland")) {
                dto.setClaimedIsland(state.getClaimedIsland());
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

