// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain;

import java.math.*;
import java.util.*;

public interface AptosEvent {

    BigInteger getAptosEventVersion();

    BigInteger getAptosEventSequenceNumber();

    String getAptosEventType();

    AptosEventGuid getAptosEventGuid();

    interface MutableAptosEvent {

        void setAptosEventVersion(BigInteger p);

        void setAptosEventSequenceNumber(BigInteger p);

        void setAptosEventType(String p);

        void setAptosEventGuid(AptosEventGuid p);

    }

}
