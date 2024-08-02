// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.aptos.contract.repository;

import org.dddml.aptosinfiniteseas.domain.map.MapLocationId;
import org.dddml.aptosinfiniteseas.aptos.contract.persistence.MapLocationTableItemAdded;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.math.*;
import java.util.List;

public interface MapLocationTableItemAddedRepository extends JpaRepository<MapLocationTableItemAdded, MapLocationId> {

    @Transactional(readOnly = true)
    List<MapLocationTableItemAdded> findByOrderByAptosEventSequenceNumber(Pageable pageable);

    @Transactional(readOnly = true)
    MapLocationTableItemAdded findFirstByOrderByAptosEventSequenceNumber();

    @Transactional(readOnly = true)
    List<MapLocationTableItemAdded> findByMapLocationId_MapAccountAddress(String mapAccountAddress);

}