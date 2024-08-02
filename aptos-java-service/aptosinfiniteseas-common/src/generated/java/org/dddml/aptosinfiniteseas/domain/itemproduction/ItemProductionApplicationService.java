// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.itemproduction;

import java.util.Map;
import java.util.List;
import org.dddml.support.criterion.Criterion;
import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.specialization.Event;
import org.dddml.aptosinfiniteseas.domain.Command;

public interface ItemProductionApplicationService {
    void when(ItemProductionCommands.Create c);

    void when(ItemProductionCommands.Update c);

    ItemProductionState get(SkillTypeItemIdPair id);

    Iterable<ItemProductionState> getAll(Integer firstResult, Integer maxResults);

    Iterable<ItemProductionState> get(Iterable<Map.Entry<String, Object>> filter, List<String> orders, Integer firstResult, Integer maxResults);

    Iterable<ItemProductionState> get(Criterion filter, List<String> orders, Integer firstResult, Integer maxResults);

    Iterable<ItemProductionState> getByProperty(String propertyName, Object propertyValue, List<String> orders, Integer firstResult, Integer maxResults);

    long getCount(Iterable<Map.Entry<String, Object>> filter);

    long getCount(Criterion filter);

    ItemProductionEvent getEvent(SkillTypeItemIdPair itemProductionId, long version);

    ItemProductionState getHistoryState(SkillTypeItemIdPair itemProductionId, long version);

}
