// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.skillprocess;

import java.util.*;
import org.dddml.support.criterion.Criterion;
import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;

public interface SkillProcessStateRepository {
    SkillProcessState get(String id, boolean nullAllowed);

    void save(SkillProcessState state);

    void merge(SkillProcessState detached);
}
