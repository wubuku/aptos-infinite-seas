// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.restful.resource;

import java.util.*;
import java.util.stream.*;
import javax.servlet.http.*;
import javax.validation.constraints.*;
import org.springframework.http.MediaType;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;
import org.dddml.support.criterion.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.domain.*;
import org.dddml.aptosinfiniteseas.specialization.*;
import org.dddml.aptosinfiniteseas.domain.shipbattle.*;
import static org.dddml.aptosinfiniteseas.domain.meta.M.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.dddml.support.criterion.TypeConverter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RequestMapping(path = "ShipBattles", produces = MediaType.APPLICATION_JSON_VALUE)
@RestController
public class ShipBattleResource {
    private Logger logger = LoggerFactory.getLogger(this.getClass());


    @Autowired
    private ShipBattleApplicationService shipBattleApplicationService;


    /**
     * Retrieve.
     * Retrieve ShipBattles
     */
    @GetMapping
    @Transactional(readOnly = true)
    public ShipBattleStateDto[] getAll( HttpServletRequest request,
                    @RequestParam(value = "sort", required = false) String sort,
                    @RequestParam(value = "fields", required = false) String fields,
                    @RequestParam(value = "firstResult", defaultValue = "0") Integer firstResult,
                    @RequestParam(value = "maxResults", defaultValue = "2147483647") Integer maxResults,
                    @RequestParam(value = "filter", required = false) String filter) {
        try {
        if (firstResult < 0) { firstResult = 0; }
        if (maxResults == null || maxResults < 1) { maxResults = Integer.MAX_VALUE; }

            Iterable<ShipBattleState> states = null; 
            CriterionDto criterion = null;
            if (!StringHelper.isNullOrEmpty(filter)) {
                criterion = new ObjectMapper().readValue(filter, CriterionDto.class);
            } else {
                criterion = QueryParamUtils.getQueryCriterionDto(request.getParameterMap().entrySet().stream()
                    .filter(kv -> ShipBattleResourceUtils.getFilterPropertyName(kv.getKey()) != null)
                    .collect(Collectors.toMap(kv -> kv.getKey(), kv -> kv.getValue())));
            }
            Criterion c = CriterionDto.toSubclass(criterion, getCriterionTypeConverter(), getPropertyTypeResolver(), 
                n -> (ShipBattleMetadata.aliasMap.containsKey(n) ? ShipBattleMetadata.aliasMap.get(n) : n));
            states = shipBattleApplicationService.get(
                c,
                ShipBattleResourceUtils.getQuerySorts(request.getParameterMap()),
                firstResult, maxResults);

            ShipBattleStateDto.DtoConverter dtoConverter = new ShipBattleStateDto.DtoConverter();
            if (StringHelper.isNullOrEmpty(fields)) {
                dtoConverter.setAllFieldsReturned(true);
            } else {
                dtoConverter.setReturnedFieldsString(fields);
            }
            return dtoConverter.toShipBattleStateDtoArray(states);

        } catch (Exception ex) { logger.info(ex.getMessage(), ex); throw DomainErrorUtils.convertException(ex); }
    }

    /**
     * Retrieve in pages.
     * Retrieve ShipBattles in pages.
     */
    @GetMapping("_page")
    @Transactional(readOnly = true)
    public Page<ShipBattleStateDto> getPage( HttpServletRequest request,
                    @RequestParam(value = "fields", required = false) String fields,
                    @RequestParam(value = "page", defaultValue = "0") Integer page,
                    @RequestParam(value = "size", defaultValue = "20") Integer size,
                    @RequestParam(value = "filter", required = false) String filter) {
        try {
            Integer firstResult = (page == null ? 0 : page) * (size == null ? 20 : size);
            Integer maxResults = (size == null ? 20 : size);
            Iterable<ShipBattleState> states = null; 
            CriterionDto criterion = null;
            if (!StringHelper.isNullOrEmpty(filter)) {
                criterion = new ObjectMapper().readValue(filter, CriterionDto.class);
            } else {
                criterion = QueryParamUtils.getQueryCriterionDto(request.getParameterMap().entrySet().stream()
                    .filter(kv -> ShipBattleResourceUtils.getFilterPropertyName(kv.getKey()) != null)
                    .collect(Collectors.toMap(kv -> kv.getKey(), kv -> kv.getValue())));
            }
            Criterion c = CriterionDto.toSubclass(criterion, getCriterionTypeConverter(), getPropertyTypeResolver(), 
                n -> (ShipBattleMetadata.aliasMap.containsKey(n) ? ShipBattleMetadata.aliasMap.get(n) : n));
            states = shipBattleApplicationService.get(
                c,
                ShipBattleResourceUtils.getQuerySorts(request.getParameterMap()),
                firstResult, maxResults);
            long count = shipBattleApplicationService.getCount(c);

            ShipBattleStateDto.DtoConverter dtoConverter = new ShipBattleStateDto.DtoConverter();
            if (StringHelper.isNullOrEmpty(fields)) {
                dtoConverter.setAllFieldsReturned(true);
            } else {
                dtoConverter.setReturnedFieldsString(fields);
            }
            Page.PageImpl<ShipBattleStateDto> statePage =  new Page.PageImpl<>(dtoConverter.toShipBattleStateDtoList(states), count);
            statePage.setSize(size);
            statePage.setNumber(page);
            return statePage;

        } catch (Exception ex) { logger.info(ex.getMessage(), ex); throw DomainErrorUtils.convertException(ex); }
    }

    /**
     * Retrieve.
     * Retrieves ShipBattle with the specified ID.
     */
    @GetMapping("{id}")
    @Transactional(readOnly = true)
    public ShipBattleStateDto get(@PathVariable("id") String id, @RequestParam(value = "fields", required = false) String fields) {
        try {
            String idObj = id;
            ShipBattleState state = shipBattleApplicationService.get(idObj);
            if (state == null) { return null; }

            ShipBattleStateDto.DtoConverter dtoConverter = new ShipBattleStateDto.DtoConverter();
            if (StringHelper.isNullOrEmpty(fields)) {
                dtoConverter.setAllFieldsReturned(true);
            } else {
                dtoConverter.setReturnedFieldsString(fields);
            }
            return dtoConverter.toShipBattleStateDto(state);

        } catch (Exception ex) { logger.info(ex.getMessage(), ex); throw DomainErrorUtils.convertException(ex); }
    }

    @GetMapping("_count")
    @Transactional(readOnly = true)
    public long getCount( HttpServletRequest request,
                         @RequestParam(value = "filter", required = false) String filter) {
        try {
            long count = 0;
            CriterionDto criterion = null;
            if (!StringHelper.isNullOrEmpty(filter)) {
                criterion = new ObjectMapper().readValue(filter, CriterionDto.class);
            } else {
                criterion = QueryParamUtils.getQueryCriterionDto(request.getParameterMap());
            }
            Criterion c = CriterionDto.toSubclass(criterion,
                getCriterionTypeConverter(), 
                getPropertyTypeResolver(), 
                n -> (ShipBattleMetadata.aliasMap.containsKey(n) ? ShipBattleMetadata.aliasMap.get(n) : n));
            count = shipBattleApplicationService.getCount(c);
            return count;

        } catch (Exception ex) { logger.info(ex.getMessage(), ex); throw DomainErrorUtils.convertException(ex); }
    }


    @PutMapping("{id}/_commands/InitiateBattle")
    public void initiateBattle(@PathVariable("id") String id, @RequestBody ShipBattleCommands.InitiateBattle content) {
        try {

            ShipBattleCommands.InitiateBattle cmd = content;//.toInitiateBattle();
            String idObj = id;
            if (cmd.getId() == null) {
                cmd.setId(idObj);
            } else if (!cmd.getId().equals(idObj)) {
                throw DomainError.named("inconsistentId", "Argument Id %1$s NOT equals body Id %2$s", id, cmd.getId());
            }
            cmd.setRequesterId(SecurityContextUtil.getRequesterId());
            shipBattleApplicationService.when(cmd);

        } catch (Exception ex) { logger.info(ex.getMessage(), ex); throw DomainErrorUtils.convertException(ex); }
    }


    @PutMapping("{id}/_commands/MakeMove")
    public void makeMove(@PathVariable("id") String id, @RequestBody ShipBattleCommands.MakeMove content) {
        try {

            ShipBattleCommands.MakeMove cmd = content;//.toMakeMove();
            String idObj = id;
            if (cmd.getId() == null) {
                cmd.setId(idObj);
            } else if (!cmd.getId().equals(idObj)) {
                throw DomainError.named("inconsistentId", "Argument Id %1$s NOT equals body Id %2$s", id, cmd.getId());
            }
            cmd.setRequesterId(SecurityContextUtil.getRequesterId());
            shipBattleApplicationService.when(cmd);

        } catch (Exception ex) { logger.info(ex.getMessage(), ex); throw DomainErrorUtils.convertException(ex); }
    }


    @PutMapping("{id}/_commands/TakeLoot")
    public void takeLoot(@PathVariable("id") String id, @RequestBody ShipBattleCommands.TakeLoot content) {
        try {

            ShipBattleCommands.TakeLoot cmd = content;//.toTakeLoot();
            String idObj = id;
            if (cmd.getId() == null) {
                cmd.setId(idObj);
            } else if (!cmd.getId().equals(idObj)) {
                throw DomainError.named("inconsistentId", "Argument Id %1$s NOT equals body Id %2$s", id, cmd.getId());
            }
            cmd.setRequesterId(SecurityContextUtil.getRequesterId());
            shipBattleApplicationService.when(cmd);

        } catch (Exception ex) { logger.info(ex.getMessage(), ex); throw DomainErrorUtils.convertException(ex); }
    }

    @GetMapping("_metadata/filteringFields")
    public List<PropertyMetadataDto> getMetadataFilteringFields() {
        try {

            List<PropertyMetadataDto> filtering = new ArrayList<>();
            ShipBattleMetadata.propertyTypeMap.forEach((key, value) -> {
                filtering.add(new PropertyMetadataDto(key, value, true));
            });
            return filtering;

        } catch (Exception ex) { logger.info(ex.getMessage(), ex); throw DomainErrorUtils.convertException(ex); }
    }

    @GetMapping("{id}/_events/{version}")
    @Transactional(readOnly = true)
    public ShipBattleEvent getEvent(@PathVariable("id") String id, @PathVariable("version") long version) {
        try {

            String idObj = id;
            //ShipBattleStateEventDtoConverter dtoConverter = getShipBattleStateEventDtoConverter();
            return shipBattleApplicationService.getEvent(idObj, version);

        } catch (Exception ex) { logger.info(ex.getMessage(), ex); throw DomainErrorUtils.convertException(ex); }
    }

    @GetMapping("{id}/_historyStates/{version}")
    @Transactional(readOnly = true)
    public ShipBattleStateDto getHistoryState(@PathVariable("id") String id, @PathVariable("version") long version, @RequestParam(value = "fields", required = false) String fields) {
        try {

            String idObj = id;
            ShipBattleStateDto.DtoConverter dtoConverter = new ShipBattleStateDto.DtoConverter();
            if (StringHelper.isNullOrEmpty(fields)) {
                dtoConverter.setAllFieldsReturned(true);
            } else {
                dtoConverter.setReturnedFieldsString(fields);
            }
            return dtoConverter.toShipBattleStateDto(shipBattleApplicationService.getHistoryState(idObj, version));

        } catch (Exception ex) { logger.info(ex.getMessage(), ex); throw DomainErrorUtils.convertException(ex); }
    }



    //protected  ShipBattleStateEventDtoConverter getShipBattleStateEventDtoConverter() {
    //    return new ShipBattleStateEventDtoConverter();
    //}

    protected TypeConverter getCriterionTypeConverter() {
        return new DefaultTypeConverter();
    }

    protected PropertyTypeResolver getPropertyTypeResolver() {
        return new PropertyTypeResolver() {
            @Override
            public Class resolveTypeByPropertyName(String propertyName) {
                return ShipBattleResourceUtils.getFilterPropertyType(propertyName);
            }
        };
    }

    // ////////////////////////////////
 
    public static class ShipBattleResourceUtils {

        public static void setNullIdOrThrowOnInconsistentIds(String id, org.dddml.aptosinfiniteseas.domain.shipbattle.ShipBattleCommand value) {
            String idObj = id;
            if (value.getId() == null) {
                value.setId(idObj);
            } else if (!value.getId().equals(idObj)) {
                throw DomainError.named("inconsistentId", "Argument Id %1$s NOT equals body Id %2$s", id, value.getId());
            }
        }
    
        public static List<String> getQueryOrders(String str, String separator) {
            return QueryParamUtils.getQueryOrders(str, separator, ShipBattleMetadata.aliasMap);
        }

        public static List<String> getQuerySorts(Map<String, String[]> queryNameValuePairs) {
            String[] values = queryNameValuePairs.get("sort");
            return QueryParamUtils.getQuerySorts(values, ShipBattleMetadata.aliasMap);
        }

        public static String getFilterPropertyName(String fieldName) {
            if ("sort".equalsIgnoreCase(fieldName)
                    || "firstResult".equalsIgnoreCase(fieldName)
                    || "maxResults".equalsIgnoreCase(fieldName)
                    || "fields".equalsIgnoreCase(fieldName)) {
                return null;
            }
            if (ShipBattleMetadata.aliasMap.containsKey(fieldName)) {
                return ShipBattleMetadata.aliasMap.get(fieldName);
            }
            return null;
        }

        public static Class getFilterPropertyType(String propertyName) {
            if (ShipBattleMetadata.propertyTypeMap.containsKey(propertyName)) {
                String propertyType = ShipBattleMetadata.propertyTypeMap.get(propertyName);
                if (!StringHelper.isNullOrEmpty(propertyType)) {
                    if (BoundedContextMetadata.CLASS_MAP.containsKey(propertyType)) {
                        return BoundedContextMetadata.CLASS_MAP.get(propertyType);
                    }
                }
            }
            return String.class;
        }

        public static Iterable<Map.Entry<String, Object>> getQueryFilterMap(Map<String, String[]> queryNameValuePairs) {
            Map<String, Object> filter = new HashMap<>();
            queryNameValuePairs.forEach((key, values) -> {
                if (values.length > 0) {
                    String pName = getFilterPropertyName(key);
                    if (!StringHelper.isNullOrEmpty(pName)) {
                        Class pClass = getFilterPropertyType(pName);
                        filter.put(pName, ApplicationContext.current.getTypeConverter().convertFromString(pClass, values[0]));
                    }
                }
            });
            return filter.entrySet();
        }

        public static ShipBattleStateDto[] toShipBattleStateDtoArray(Iterable<String> ids) {
            List<ShipBattleStateDto> states = new ArrayList<>();
            ids.forEach(i -> {
                ShipBattleStateDto dto = new ShipBattleStateDto();
                dto.setId(i);
                states.add(dto);
            });
            return states.toArray(new ShipBattleStateDto[0]);
        }

    }

}

