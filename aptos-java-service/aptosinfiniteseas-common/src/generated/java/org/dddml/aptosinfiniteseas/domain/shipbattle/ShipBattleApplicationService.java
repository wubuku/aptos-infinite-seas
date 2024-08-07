// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.shipbattle;

import java.util.Map;
import java.util.List;
import org.dddml.support.criterion.Criterion;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.specialization.Event;
import org.dddml.aptosinfiniteseas.domain.Command;

public interface ShipBattleApplicationService {
    void when(ShipBattleCommands.InitiateBattle c);

    void when(ShipBattleCommands.MakeMove c);

    void when(ShipBattleCommands.TakeLoot c);

    ShipBattleState get(String id);

    Iterable<ShipBattleState> getAll(Integer firstResult, Integer maxResults);

    Iterable<ShipBattleState> get(Iterable<Map.Entry<String, Object>> filter, List<String> orders, Integer firstResult, Integer maxResults);

    Iterable<ShipBattleState> get(Criterion filter, List<String> orders, Integer firstResult, Integer maxResults);

    Iterable<ShipBattleState> getByProperty(String propertyName, Object propertyValue, List<String> orders, Integer firstResult, Integer maxResults);

    long getCount(Iterable<Map.Entry<String, Object>> filter);

    long getCount(Criterion filter);

    ShipBattleEvent getEvent(String id, long version);

    ShipBattleState getHistoryState(String id, long version);

}

