package org.dddml.aptosinfiniteseas.aptos.contract.repository;

import org.dddml.aptosinfiniteseas.aptos.contract.AptosAccount;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AptosAccountRepository extends JpaRepository<AptosAccount, String> {
    
}
