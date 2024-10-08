// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.itemcreation.hibernate;

import java.util.*;
import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;
import org.hibernate.Session;
import org.hibernate.Criteria;
//import org.hibernate.criterion.Order;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Projections;
import org.hibernate.SessionFactory;
import org.dddml.aptosinfiniteseas.domain.itemcreation.*;
import org.dddml.aptosinfiniteseas.specialization.*;
import org.dddml.aptosinfiniteseas.specialization.hibernate.*;
import org.springframework.transaction.annotation.Transactional;

public class HibernateItemCreationStateRepository implements ItemCreationStateRepository {
    private SessionFactory sessionFactory;

    public SessionFactory getSessionFactory() { return this.sessionFactory; }

    public void setSessionFactory(SessionFactory sessionFactory) { this.sessionFactory = sessionFactory; }

    protected Session getCurrentSession() {
        return this.sessionFactory.getCurrentSession();
    }
    
    private static final Set<String> readOnlyPropertyPascalCaseNames = new HashSet<String>(Arrays.asList("ItemCreationId", "ResourceCost", "RequirementsLevel", "BaseQuantity", "BaseExperience", "BaseCreationTime", "EnergyCost", "SuccessRate", "Version", "OffChainVersion", "CreatedBy", "CreatedAt", "UpdatedBy", "UpdatedAt", "Active", "Deleted"));
    
    private ReadOnlyProxyGenerator readOnlyProxyGenerator;
    
    public ReadOnlyProxyGenerator getReadOnlyProxyGenerator() {
        return readOnlyProxyGenerator;
    }

    public void setReadOnlyProxyGenerator(ReadOnlyProxyGenerator readOnlyProxyGenerator) {
        this.readOnlyProxyGenerator = readOnlyProxyGenerator;
    }

    @Transactional(readOnly = true)
    public ItemCreationState get(SkillTypeItemIdPair id, boolean nullAllowed) {
        ItemCreationState.SqlItemCreationState state = (ItemCreationState.SqlItemCreationState)getCurrentSession().get(AbstractItemCreationState.SimpleItemCreationState.class, id);
        if (!nullAllowed && state == null) {
            state = new AbstractItemCreationState.SimpleItemCreationState();
            state.setItemCreationId(id);
        }
        if (getReadOnlyProxyGenerator() != null && state != null) {
            return (ItemCreationState) getReadOnlyProxyGenerator().createProxy(state, new Class[]{ItemCreationState.SqlItemCreationState.class}, "getStateReadOnly", readOnlyPropertyPascalCaseNames);
        }
        return state;
    }

    public void save(ItemCreationState state) {
        ItemCreationState s = state;
        if (getReadOnlyProxyGenerator() != null) {
            s = (ItemCreationState) getReadOnlyProxyGenerator().getTarget(state);
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

    public void merge(ItemCreationState detached) {
        ItemCreationState persistent = getCurrentSession().get(AbstractItemCreationState.SimpleItemCreationState.class, detached.getItemCreationId());
        if (persistent != null) {
            merge(persistent, detached);
            getCurrentSession().save(persistent);
        } else {
            getCurrentSession().save(detached);
        }
        getCurrentSession().flush();
    }

    private void merge(ItemCreationState persistent, ItemCreationState detached) {
        ((AbstractItemCreationState) persistent).merge(detached);
    }

}

