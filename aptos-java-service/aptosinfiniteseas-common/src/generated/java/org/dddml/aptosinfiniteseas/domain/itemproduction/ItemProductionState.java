// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.itemproduction;

import java.util.*;
import java.math.*;
import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.specialization.Event;

public interface ItemProductionState extends ItemCreationOrProduction, VersionedAptosMoveObject
{
    Long VERSION_ZERO = 0L;

    Long VERSION_NULL = VERSION_ZERO - 1;

    SkillTypeItemIdPair getItemProductionId();

    ItemIdQuantityPairs getProductionMaterials();

    Long getOffChainVersion();

    String getCreatedBy();

    Date getCreatedAt();

    String getUpdatedBy();

    Date getUpdatedAt();

    Boolean getActive();

    Boolean getDeleted();

    interface MutableItemProductionState extends ItemProductionState, ItemCreationOrProduction.MutableItemCreationOrProduction, VersionedAptosMoveObject.MutableVersionedAptosMoveObject {
        void setItemProductionId(SkillTypeItemIdPair itemProductionId);

        void setProductionMaterials(ItemIdQuantityPairs productionMaterials);

        void setOffChainVersion(Long offChainVersion);

        void setCreatedBy(String createdBy);

        void setCreatedAt(Date createdAt);

        void setUpdatedBy(String updatedBy);

        void setUpdatedAt(Date updatedAt);

        void setActive(Boolean active);

        void setDeleted(Boolean deleted);


        void mutate(Event e);

        //void when(ItemProductionEvent.ItemProductionStateCreated e);

        //void when(ItemProductionEvent.ItemProductionStateMergePatched e);

        //void when(ItemProductionEvent.ItemProductionStateDeleted e);
    }

    interface SqlItemProductionState extends MutableItemProductionState {

        boolean isStateUnsaved();

        boolean getForReapplying();
    }
}
