// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.map;

import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;

public interface MapLocationEventDao {
    void save(MapLocationEvent e);

    Iterable<MapLocationEvent> findByMapEventId(MapEventId mapEventId);

}

