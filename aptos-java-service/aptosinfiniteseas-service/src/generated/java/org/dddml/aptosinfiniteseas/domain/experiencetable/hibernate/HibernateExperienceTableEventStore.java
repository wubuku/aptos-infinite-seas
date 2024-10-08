// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.experiencetable.hibernate;

import java.io.Serializable;
import java.util.*;
import org.dddml.aptosinfiniteseas.domain.*;
import java.util.Date;
import java.math.BigInteger;
import org.dddml.aptosinfiniteseas.specialization.*;
import org.dddml.aptosinfiniteseas.specialization.hibernate.AbstractHibernateEventStore;
import org.hibernate.*;
import org.hibernate.criterion.*;
import org.springframework.transaction.annotation.Transactional;
import org.dddml.aptosinfiniteseas.domain.experiencetable.*;

public class HibernateExperienceTableEventStore extends AbstractHibernateEventStore {
    @Override
    protected Serializable getEventId(EventStoreAggregateId eventStoreAggregateId, long version)
    {
        return new ExperienceTableEventId((String) eventStoreAggregateId.getId(), BigInteger.valueOf(version));
    }

    @Override
    protected Class getSupportedEventType()
    {
        return AbstractExperienceTableEvent.class;
    }

    @Transactional(readOnly = true)
    @Override
    public EventStream loadEventStream(Class eventType, EventStoreAggregateId eventStoreAggregateId, long version) {
        Class supportedEventType = AbstractExperienceTableEvent.class;
        if (!eventType.isAssignableFrom(supportedEventType)) {
            throw new UnsupportedOperationException();
        }
        String idObj = (String) eventStoreAggregateId.getId();
        Criteria criteria = getCurrentSession().createCriteria(AbstractExperienceTableEvent.class);
        criteria.add(Restrictions.eq("experienceTableEventId.accountAddress", idObj));
        criteria.add(Restrictions.le("experienceTableEventId.offChainVersion", version));
        criteria.addOrder(Order.asc("experienceTableEventId.offChainVersion"));
        List es = criteria.list();
        for (Object e : es) {
            ((AbstractExperienceTableEvent) e).setEventReadOnly(true);
        }
        EventStream eventStream = new EventStream();
        if (es.size() > 0) {
            eventStream.setSteamVersion(((AbstractExperienceTableEvent) es.get(es.size() - 1)).getExperienceTableEventId().getVersion().longValue());
        } else {
            //todo?
        }
        eventStream.setEvents(es);
        return eventStream;
    }

}

