// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.rosterlocation;

import java.util.*;
import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.domain.AbstractCommand;

public abstract class AbstractRosterLocationCommand extends AbstractCommand implements RosterLocationCommand {

    private String rosterObjectId;

    public String getRosterObjectId()
    {
        return this.rosterObjectId;
    }

    public void setRosterObjectId(String rosterObjectId)
    {
        this.rosterObjectId = rosterObjectId;
    }

    private Long offChainVersion;

    public Long getOffChainVersion()
    {
        return this.offChainVersion;
    }

    public void setOffChainVersion(Long offChainVersion)
    {
        this.offChainVersion = offChainVersion;
    }


}
