// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.skillprocess;

import java.util.Map;
import java.util.List;
import org.dddml.support.criterion.Criterion;
import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.specialization.Event;
import org.dddml.aptosinfiniteseas.domain.Command;

public interface SkillProcessApplicationService {
    SkillProcessState get(String id);

    Iterable<SkillProcessState> getAll(Integer firstResult, Integer maxResults);

    Iterable<SkillProcessState> get(Iterable<Map.Entry<String, Object>> filter, List<String> orders, Integer firstResult, Integer maxResults);

    Iterable<SkillProcessState> get(Criterion filter, List<String> orders, Integer firstResult, Integer maxResults);

    Iterable<SkillProcessState> getByProperty(String propertyName, Object propertyValue, List<String> orders, Integer firstResult, Integer maxResults);

    long getCount(Iterable<Map.Entry<String, Object>> filter);

    long getCount(Criterion filter);

    SkillProcessEvent getEvent(String id, long version);

    SkillProcessState getHistoryState(String id, long version);

}

