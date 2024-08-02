// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.config;

import org.dddml.aptosinfiniteseas.domain.ship.*;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.domain.ship.hibernate.*;
import org.dddml.aptosinfiniteseas.domain.roster.*;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.domain.roster.hibernate.*;
import org.dddml.aptosinfiniteseas.domain.shipbattle.*;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.domain.shipbattle.hibernate.*;
import org.dddml.aptosinfiniteseas.domain.rosterlocation.*;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.domain.rosterlocation.hibernate.*;
import org.dddml.aptosinfiniteseas.domain.skillprocess.*;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.domain.skillprocess.hibernate.*;
import org.dddml.aptosinfiniteseas.domain.item.*;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.domain.item.hibernate.*;
import org.dddml.aptosinfiniteseas.domain.itemcreation.*;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.domain.itemcreation.hibernate.*;
import org.dddml.aptosinfiniteseas.domain.itemproduction.*;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.domain.itemproduction.hibernate.*;
import org.dddml.aptosinfiniteseas.domain.player.*;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.domain.player.hibernate.*;
import org.dddml.aptosinfiniteseas.domain.map.*;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.domain.map.hibernate.*;
import org.dddml.aptosinfiniteseas.domain.experiencetable.*;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.domain.experiencetable.hibernate.*;
import org.dddml.aptosinfiniteseas.specialization.AggregateEventListener;
import org.dddml.aptosinfiniteseas.specialization.EventStore;
import org.dddml.aptosinfiniteseas.specialization.IdGenerator;
import org.dddml.aptosinfiniteseas.specialization.ReadOnlyProxyGenerator;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AggregatesHibernateConfig {


    @Bean
    public ShipStateRepository shipStateRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernateShipStateRepository repository = new HibernateShipStateRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public ShipStateQueryRepository shipStateQueryRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernateShipStateQueryRepository repository = new HibernateShipStateQueryRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public HibernateShipEventStore shipEventStore(SessionFactory hibernateSessionFactory) {
        HibernateShipEventStore eventStore = new HibernateShipEventStore();
        eventStore.setSessionFactory(hibernateSessionFactory);
        return eventStore;
    }

    @Bean
    public AbstractShipApplicationService.SimpleShipApplicationService shipApplicationService(
            @Qualifier("shipEventStore") EventStore shipEventStore,
            ShipStateRepository shipStateRepository,
            ShipStateQueryRepository shipStateQueryRepository
    ) {
        AbstractShipApplicationService.SimpleShipApplicationService applicationService = new AbstractShipApplicationService.SimpleShipApplicationService(
                shipEventStore,
                shipStateRepository,
                shipStateQueryRepository
        );
        return applicationService;
    }



    @Bean
    public RosterStateRepository rosterStateRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernateRosterStateRepository repository = new HibernateRosterStateRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public RosterStateQueryRepository rosterStateQueryRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernateRosterStateQueryRepository repository = new HibernateRosterStateQueryRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public HibernateRosterEventStore rosterEventStore(SessionFactory hibernateSessionFactory) {
        HibernateRosterEventStore eventStore = new HibernateRosterEventStore();
        eventStore.setSessionFactory(hibernateSessionFactory);
        return eventStore;
    }

    @Bean
    public AbstractRosterApplicationService.SimpleRosterApplicationService rosterApplicationService(
            @Qualifier("rosterEventStore") EventStore rosterEventStore,
            RosterStateRepository rosterStateRepository,
            RosterStateQueryRepository rosterStateQueryRepository
    ) {
        AbstractRosterApplicationService.SimpleRosterApplicationService applicationService = new AbstractRosterApplicationService.SimpleRosterApplicationService(
                rosterEventStore,
                rosterStateRepository,
                rosterStateQueryRepository
        );
        return applicationService;
    }



    @Bean
    public ShipBattleStateRepository shipBattleStateRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernateShipBattleStateRepository repository = new HibernateShipBattleStateRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public ShipBattleStateQueryRepository shipBattleStateQueryRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernateShipBattleStateQueryRepository repository = new HibernateShipBattleStateQueryRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public HibernateShipBattleEventStore shipBattleEventStore(SessionFactory hibernateSessionFactory) {
        HibernateShipBattleEventStore eventStore = new HibernateShipBattleEventStore();
        eventStore.setSessionFactory(hibernateSessionFactory);
        return eventStore;
    }

    @Bean
    public AbstractShipBattleApplicationService.SimpleShipBattleApplicationService shipBattleApplicationService(
            @Qualifier("shipBattleEventStore") EventStore shipBattleEventStore,
            ShipBattleStateRepository shipBattleStateRepository,
            ShipBattleStateQueryRepository shipBattleStateQueryRepository
    ) {
        AbstractShipBattleApplicationService.SimpleShipBattleApplicationService applicationService = new AbstractShipBattleApplicationService.SimpleShipBattleApplicationService(
                shipBattleEventStore,
                shipBattleStateRepository,
                shipBattleStateQueryRepository
        );
        return applicationService;
    }



    @Bean
    public RosterLocationStateRepository rosterLocationStateRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernateRosterLocationStateRepository repository = new HibernateRosterLocationStateRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public RosterLocationStateQueryRepository rosterLocationStateQueryRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernateRosterLocationStateQueryRepository repository = new HibernateRosterLocationStateQueryRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public HibernateRosterLocationEventStore rosterLocationEventStore(SessionFactory hibernateSessionFactory) {
        HibernateRosterLocationEventStore eventStore = new HibernateRosterLocationEventStore();
        eventStore.setSessionFactory(hibernateSessionFactory);
        return eventStore;
    }

    @Bean
    public AbstractRosterLocationApplicationService.SimpleRosterLocationApplicationService rosterLocationApplicationService(
            @Qualifier("rosterLocationEventStore") EventStore rosterLocationEventStore,
            RosterLocationStateRepository rosterLocationStateRepository,
            RosterLocationStateQueryRepository rosterLocationStateQueryRepository
    ) {
        AbstractRosterLocationApplicationService.SimpleRosterLocationApplicationService applicationService = new AbstractRosterLocationApplicationService.SimpleRosterLocationApplicationService(
                rosterLocationEventStore,
                rosterLocationStateRepository,
                rosterLocationStateQueryRepository
        );
        return applicationService;
    }



    @Bean
    public SkillProcessStateRepository skillProcessStateRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernateSkillProcessStateRepository repository = new HibernateSkillProcessStateRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public SkillProcessStateQueryRepository skillProcessStateQueryRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernateSkillProcessStateQueryRepository repository = new HibernateSkillProcessStateQueryRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public HibernateSkillProcessEventStore skillProcessEventStore(SessionFactory hibernateSessionFactory) {
        HibernateSkillProcessEventStore eventStore = new HibernateSkillProcessEventStore();
        eventStore.setSessionFactory(hibernateSessionFactory);
        return eventStore;
    }

    @Bean
    public AbstractSkillProcessApplicationService.SimpleSkillProcessApplicationService skillProcessApplicationService(
            @Qualifier("skillProcessEventStore") EventStore skillProcessEventStore,
            SkillProcessStateRepository skillProcessStateRepository,
            SkillProcessStateQueryRepository skillProcessStateQueryRepository
    ) {
        AbstractSkillProcessApplicationService.SimpleSkillProcessApplicationService applicationService = new AbstractSkillProcessApplicationService.SimpleSkillProcessApplicationService(
                skillProcessEventStore,
                skillProcessStateRepository,
                skillProcessStateQueryRepository
        );
        return applicationService;
    }



    @Bean
    public ItemStateRepository itemStateRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernateItemStateRepository repository = new HibernateItemStateRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public ItemStateQueryRepository itemStateQueryRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernateItemStateQueryRepository repository = new HibernateItemStateQueryRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public HibernateItemEventStore itemEventStore(SessionFactory hibernateSessionFactory) {
        HibernateItemEventStore eventStore = new HibernateItemEventStore();
        eventStore.setSessionFactory(hibernateSessionFactory);
        return eventStore;
    }

    @Bean
    public AbstractItemApplicationService.SimpleItemApplicationService itemApplicationService(
            @Qualifier("itemEventStore") EventStore itemEventStore,
            ItemStateRepository itemStateRepository,
            ItemStateQueryRepository itemStateQueryRepository
    ) {
        AbstractItemApplicationService.SimpleItemApplicationService applicationService = new AbstractItemApplicationService.SimpleItemApplicationService(
                itemEventStore,
                itemStateRepository,
                itemStateQueryRepository
        );
        return applicationService;
    }



    @Bean
    public ItemCreationStateRepository itemCreationStateRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernateItemCreationStateRepository repository = new HibernateItemCreationStateRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public ItemCreationStateQueryRepository itemCreationStateQueryRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernateItemCreationStateQueryRepository repository = new HibernateItemCreationStateQueryRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public HibernateItemCreationEventStore itemCreationEventStore(SessionFactory hibernateSessionFactory) {
        HibernateItemCreationEventStore eventStore = new HibernateItemCreationEventStore();
        eventStore.setSessionFactory(hibernateSessionFactory);
        return eventStore;
    }

    @Bean
    public AbstractItemCreationApplicationService.SimpleItemCreationApplicationService itemCreationApplicationService(
            @Qualifier("itemCreationEventStore") EventStore itemCreationEventStore,
            ItemCreationStateRepository itemCreationStateRepository,
            ItemCreationStateQueryRepository itemCreationStateQueryRepository
    ) {
        AbstractItemCreationApplicationService.SimpleItemCreationApplicationService applicationService = new AbstractItemCreationApplicationService.SimpleItemCreationApplicationService(
                itemCreationEventStore,
                itemCreationStateRepository,
                itemCreationStateQueryRepository
        );
        return applicationService;
    }



    @Bean
    public ItemProductionStateRepository itemProductionStateRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernateItemProductionStateRepository repository = new HibernateItemProductionStateRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public ItemProductionStateQueryRepository itemProductionStateQueryRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernateItemProductionStateQueryRepository repository = new HibernateItemProductionStateQueryRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public HibernateItemProductionEventStore itemProductionEventStore(SessionFactory hibernateSessionFactory) {
        HibernateItemProductionEventStore eventStore = new HibernateItemProductionEventStore();
        eventStore.setSessionFactory(hibernateSessionFactory);
        return eventStore;
    }

    @Bean
    public AbstractItemProductionApplicationService.SimpleItemProductionApplicationService itemProductionApplicationService(
            @Qualifier("itemProductionEventStore") EventStore itemProductionEventStore,
            ItemProductionStateRepository itemProductionStateRepository,
            ItemProductionStateQueryRepository itemProductionStateQueryRepository
    ) {
        AbstractItemProductionApplicationService.SimpleItemProductionApplicationService applicationService = new AbstractItemProductionApplicationService.SimpleItemProductionApplicationService(
                itemProductionEventStore,
                itemProductionStateRepository,
                itemProductionStateQueryRepository
        );
        return applicationService;
    }



    @Bean
    public PlayerStateRepository playerStateRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernatePlayerStateRepository repository = new HibernatePlayerStateRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public PlayerStateQueryRepository playerStateQueryRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernatePlayerStateQueryRepository repository = new HibernatePlayerStateQueryRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public HibernatePlayerEventStore playerEventStore(SessionFactory hibernateSessionFactory) {
        HibernatePlayerEventStore eventStore = new HibernatePlayerEventStore();
        eventStore.setSessionFactory(hibernateSessionFactory);
        return eventStore;
    }

    @Bean
    public AbstractPlayerApplicationService.SimplePlayerApplicationService playerApplicationService(
            @Qualifier("playerEventStore") EventStore playerEventStore,
            PlayerStateRepository playerStateRepository,
            PlayerStateQueryRepository playerStateQueryRepository
    ) {
        AbstractPlayerApplicationService.SimplePlayerApplicationService applicationService = new AbstractPlayerApplicationService.SimplePlayerApplicationService(
                playerEventStore,
                playerStateRepository,
                playerStateQueryRepository
        );
        return applicationService;
    }



    @Bean
    public MapLocationEventDao mapLocationEventDao(SessionFactory hibernateSessionFactory) {
        HibernateMapLocationEventDao dao = new HibernateMapLocationEventDao();
        dao.setSessionFactory(hibernateSessionFactory);
        return dao;
    }

    @Bean
    public MapStateRepository mapStateRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernateMapStateRepository repository = new HibernateMapStateRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public MapStateQueryRepository mapStateQueryRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernateMapStateQueryRepository repository = new HibernateMapStateQueryRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public HibernateMapEventStore mapEventStore(SessionFactory hibernateSessionFactory) {
        HibernateMapEventStore eventStore = new HibernateMapEventStore();
        eventStore.setSessionFactory(hibernateSessionFactory);
        return eventStore;
    }

    @Bean
    public AbstractMapApplicationService.SimpleMapApplicationService mapApplicationService(
            @Qualifier("mapEventStore") EventStore mapEventStore,
            MapStateRepository mapStateRepository,
            MapStateQueryRepository mapStateQueryRepository
    ) {
        AbstractMapApplicationService.SimpleMapApplicationService applicationService = new AbstractMapApplicationService.SimpleMapApplicationService(
                mapEventStore,
                mapStateRepository,
                mapStateQueryRepository
        );
        return applicationService;
    }



    @Bean
    public ExperienceTableStateRepository experienceTableStateRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernateExperienceTableStateRepository repository = new HibernateExperienceTableStateRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public ExperienceTableStateQueryRepository experienceTableStateQueryRepository(
            SessionFactory hibernateSessionFactory,
            ReadOnlyProxyGenerator stateReadOnlyProxyGenerator
    ) {
        HibernateExperienceTableStateQueryRepository repository = new HibernateExperienceTableStateQueryRepository();
        repository.setSessionFactory(hibernateSessionFactory);
        repository.setReadOnlyProxyGenerator(stateReadOnlyProxyGenerator);
        return repository;
    }

    @Bean
    public HibernateExperienceTableEventStore experienceTableEventStore(SessionFactory hibernateSessionFactory) {
        HibernateExperienceTableEventStore eventStore = new HibernateExperienceTableEventStore();
        eventStore.setSessionFactory(hibernateSessionFactory);
        return eventStore;
    }

    @Bean
    public AbstractExperienceTableApplicationService.SimpleExperienceTableApplicationService experienceTableApplicationService(
            @Qualifier("experienceTableEventStore") EventStore experienceTableEventStore,
            ExperienceTableStateRepository experienceTableStateRepository,
            ExperienceTableStateQueryRepository experienceTableStateQueryRepository
    ) {
        AbstractExperienceTableApplicationService.SimpleExperienceTableApplicationService applicationService = new AbstractExperienceTableApplicationService.SimpleExperienceTableApplicationService(
                experienceTableEventStore,
                experienceTableStateRepository,
                experienceTableStateQueryRepository
        );
        return applicationService;
    }


}