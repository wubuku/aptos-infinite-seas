// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.shipbattle.hibernate;

import java.util.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.domain.*;
import org.hibernate.Session;
import org.hibernate.Criteria;
//import org.hibernate.criterion.Order;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Projections;
import org.hibernate.SessionFactory;
import org.dddml.aptosinfiniteseas.domain.shipbattle.*;
import org.dddml.aptosinfiniteseas.specialization.*;
import org.dddml.aptosinfiniteseas.specialization.hibernate.*;
import org.springframework.transaction.annotation.Transactional;

public class HibernateShipBattleStateRepository implements ShipBattleStateRepository {
    private SessionFactory sessionFactory;

    public SessionFactory getSessionFactory() { return this.sessionFactory; }

    public void setSessionFactory(SessionFactory sessionFactory) { this.sessionFactory = sessionFactory; }

    protected Session getCurrentSession() {
        return this.sessionFactory.getCurrentSession();
    }
    
    private static final Set<String> readOnlyPropertyPascalCaseNames = new HashSet<String>(Arrays.asList("Id", "Initiator", "Responder", "Status", "InitiatorExperiences", "ResponderExperiences", "EndedAt", "Winner", "RoundNumber", "RoundStartedAt", "RoundMover", "RoundAttackerShip", "RoundDefenderShip", "Version", "OffChainVersion", "CreatedBy", "CreatedAt", "UpdatedBy", "UpdatedAt", "Active", "Deleted"));
    
    private ReadOnlyProxyGenerator readOnlyProxyGenerator;
    
    public ReadOnlyProxyGenerator getReadOnlyProxyGenerator() {
        return readOnlyProxyGenerator;
    }

    public void setReadOnlyProxyGenerator(ReadOnlyProxyGenerator readOnlyProxyGenerator) {
        this.readOnlyProxyGenerator = readOnlyProxyGenerator;
    }

    @Transactional(readOnly = true)
    public ShipBattleState get(String id, boolean nullAllowed) {
        ShipBattleState.SqlShipBattleState state = (ShipBattleState.SqlShipBattleState)getCurrentSession().get(AbstractShipBattleState.SimpleShipBattleState.class, id);
        if (!nullAllowed && state == null) {
            state = new AbstractShipBattleState.SimpleShipBattleState();
            state.setId(id);
        }
        if (getReadOnlyProxyGenerator() != null && state != null) {
            return (ShipBattleState) getReadOnlyProxyGenerator().createProxy(state, new Class[]{ShipBattleState.SqlShipBattleState.class}, "getStateReadOnly", readOnlyPropertyPascalCaseNames);
        }
        return state;
    }

    public void save(ShipBattleState state) {
        ShipBattleState s = state;
        if (getReadOnlyProxyGenerator() != null) {
            s = (ShipBattleState) getReadOnlyProxyGenerator().getTarget(state);
        }
        if(s.getOffChainVersion() == null) {
            getCurrentSession().save(s);
        } else {
            getCurrentSession().update(s);
        }

        if (s instanceof Saveable)
        {
            Saveable saveable = (Saveable) s;
            saveable.save();
        }
        getCurrentSession().flush();
    }

    public void merge(ShipBattleState detached) {
        ShipBattleState persistent = getCurrentSession().get(AbstractShipBattleState.SimpleShipBattleState.class, detached.getId());
        if (persistent != null) {
            merge(persistent, detached);
            getCurrentSession().save(persistent);
        } else {
            getCurrentSession().save(detached);
        }
        getCurrentSession().flush();
    }

    private void merge(ShipBattleState persistent, ShipBattleState detached) {
        ((AbstractShipBattleState) persistent).merge(detached);
    }

}

