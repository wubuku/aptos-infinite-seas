// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.shipbattle;

import java.util.*;
import java.math.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.specialization.*;


public class ShipBattleStateDto {

    private String id;

    public String getId()
    {
        return this.id;
    }

    public void setId(String id)
    {
        this.id = id;
    }

    private String initiator;

    public String getInitiator()
    {
        return this.initiator;
    }

    public void setInitiator(String initiator)
    {
        this.initiator = initiator;
    }

    private String responder;

    public String getResponder()
    {
        return this.responder;
    }

    public void setResponder(String responder)
    {
        this.responder = responder;
    }

    private Integer status;

    public Integer getStatus()
    {
        return this.status;
    }

    public void setStatus(Integer status)
    {
        this.status = status;
    }

    private BigInteger endedAt;

    public BigInteger getEndedAt()
    {
        return this.endedAt;
    }

    public void setEndedAt(BigInteger endedAt)
    {
        this.endedAt = endedAt;
    }

    private Integer winner;

    public Integer getWinner()
    {
        return this.winner;
    }

    public void setWinner(Integer winner)
    {
        this.winner = winner;
    }

    private Long roundNumber;

    public Long getRoundNumber()
    {
        return this.roundNumber;
    }

    public void setRoundNumber(Long roundNumber)
    {
        this.roundNumber = roundNumber;
    }

    private BigInteger roundStartedAt;

    public BigInteger getRoundStartedAt()
    {
        return this.roundStartedAt;
    }

    public void setRoundStartedAt(BigInteger roundStartedAt)
    {
        this.roundStartedAt = roundStartedAt;
    }

    private Integer roundMover;

    public Integer getRoundMover()
    {
        return this.roundMover;
    }

    public void setRoundMover(Integer roundMover)
    {
        this.roundMover = roundMover;
    }

    private String roundAttackerShip;

    public String getRoundAttackerShip()
    {
        return this.roundAttackerShip;
    }

    public void setRoundAttackerShip(String roundAttackerShip)
    {
        this.roundAttackerShip = roundAttackerShip;
    }

    private String roundDefenderShip;

    public String getRoundDefenderShip()
    {
        return this.roundDefenderShip;
    }

    public void setRoundDefenderShip(String roundDefenderShip)
    {
        this.roundDefenderShip = roundDefenderShip;
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

    private Long[] initiatorExperiences;

    public Long[] getInitiatorExperiences() {
        return this.initiatorExperiences;
    }

    public void setInitiatorExperiences(Long[] initiatorExperiences) {
        this.initiatorExperiences = initiatorExperiences;
    }

    private Long[] responderExperiences;

    public Long[] getResponderExperiences() {
        return this.responderExperiences;
    }

    public void setResponderExperiences(Long[] responderExperiences) {
        this.responderExperiences = responderExperiences;
    }


    public static class DtoConverter extends AbstractStateDtoConverter
    {
        public static Collection<String> collectionFieldNames = Arrays.asList(new String[]{});

        @Override
        protected boolean isCollectionField(String fieldName) {
            return CollectionUtils.collectionContainsIgnoringCase(collectionFieldNames, fieldName);
        }

        public ShipBattleStateDto[] toShipBattleStateDtoArray(Iterable<ShipBattleState> states) {
            return toShipBattleStateDtoList(states).toArray(new ShipBattleStateDto[0]);
        }

        public List<ShipBattleStateDto> toShipBattleStateDtoList(Iterable<ShipBattleState> states) {
            ArrayList<ShipBattleStateDto> stateDtos = new ArrayList();
            for (ShipBattleState s : states) {
                ShipBattleStateDto dto = toShipBattleStateDto(s);
                stateDtos.add(dto);
            }
            return stateDtos;
        }

        public ShipBattleStateDto toShipBattleStateDto(ShipBattleState state)
        {
            if(state == null) {
                return null;
            }
            ShipBattleStateDto dto = new ShipBattleStateDto();
            if (returnedFieldsContains("Id")) {
                dto.setId(state.getId());
            }
            if (returnedFieldsContains("Initiator")) {
                dto.setInitiator(state.getInitiator());
            }
            if (returnedFieldsContains("Responder")) {
                dto.setResponder(state.getResponder());
            }
            if (returnedFieldsContains("Status")) {
                dto.setStatus(state.getStatus());
            }
            if (returnedFieldsContains("EndedAt")) {
                dto.setEndedAt(state.getEndedAt());
            }
            if (returnedFieldsContains("Winner")) {
                dto.setWinner(state.getWinner());
            }
            if (returnedFieldsContains("RoundNumber")) {
                dto.setRoundNumber(state.getRoundNumber());
            }
            if (returnedFieldsContains("RoundStartedAt")) {
                dto.setRoundStartedAt(state.getRoundStartedAt());
            }
            if (returnedFieldsContains("RoundMover")) {
                dto.setRoundMover(state.getRoundMover());
            }
            if (returnedFieldsContains("RoundAttackerShip")) {
                dto.setRoundAttackerShip(state.getRoundAttackerShip());
            }
            if (returnedFieldsContains("RoundDefenderShip")) {
                dto.setRoundDefenderShip(state.getRoundDefenderShip());
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
            if (returnedFieldsContains("InitiatorExperiences")) {
                ArrayList<Long> arrayList = new ArrayList();
                if (state.getInitiatorExperiences() != null) {
                    for (Long s : state.getInitiatorExperiences()) {
                        arrayList.add(s);
                    }
                }
                dto.setInitiatorExperiences(arrayList.toArray(new Long[0]));
            }
            if (returnedFieldsContains("ResponderExperiences")) {
                ArrayList<Long> arrayList = new ArrayList();
                if (state.getResponderExperiences() != null) {
                    for (Long s : state.getResponderExperiences()) {
                        arrayList.add(s);
                    }
                }
                dto.setResponderExperiences(arrayList.toArray(new Long[0]));
            }
            return dto;
        }

    }
}

