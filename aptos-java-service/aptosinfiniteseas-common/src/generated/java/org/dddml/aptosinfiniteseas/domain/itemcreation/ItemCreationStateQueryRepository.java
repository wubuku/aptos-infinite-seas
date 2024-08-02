// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.itemcreation;

import java.util.Map;
import java.util.List;
import org.dddml.support.criterion.Criterion;
import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;

public interface ItemCreationStateQueryRepository {
    ItemCreationState get(SkillTypeItemIdPair id);

    Iterable<ItemCreationState> getAll(Integer firstResult, Integer maxResults);
    
    Iterable<ItemCreationState> get(Iterable<Map.Entry<String, Object>> filter, List<String> orders, Integer firstResult, Integer maxResults);

    Iterable<ItemCreationState> get(Criterion filter, List<String> orders, Integer firstResult, Integer maxResults);

    ItemCreationState getFirst(Iterable<Map.Entry<String, Object>> filter, List<String> orders);

    ItemCreationState getFirst(Map.Entry<String, Object> keyValue, List<String> orders);

    Iterable<ItemCreationState> getByProperty(String propertyName, Object propertyValue, List<String> orders, Integer firstResult, Integer maxResults);

    long getCount(Iterable<Map.Entry<String, Object>> filter);

    long getCount(Criterion filter);

}

