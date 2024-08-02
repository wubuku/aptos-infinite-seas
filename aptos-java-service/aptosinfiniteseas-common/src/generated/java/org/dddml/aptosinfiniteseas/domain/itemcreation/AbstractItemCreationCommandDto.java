// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain.itemcreation;

import org.dddml.aptosinfiniteseas.domain.*;
import java.math.BigInteger;
import java.util.Date;
import org.dddml.aptosinfiniteseas.domain.AbstractCommand;

public abstract class AbstractItemCreationCommandDto extends AbstractCommand {

    /**
     * Item Creation Id
     */
    private SkillTypeItemIdPair itemCreationId;

    public SkillTypeItemIdPair getItemCreationId()
    {
        return this.itemCreationId;
    }

    public void setItemCreationId(SkillTypeItemIdPair itemCreationId)
    {
        this.itemCreationId = itemCreationId;
    }

    /**
     * Off Chain Version
     */
    private Long offChainVersion;

    public Long getOffChainVersion()
    {
        return this.offChainVersion;
    }

    public void setOffChainVersion(Long offChainVersion)
    {
        this.offChainVersion = offChainVersion;
    }


    public void copyTo(ItemCreationCommand command) {
        command.setItemCreationId(this.getItemCreationId());
        command.setOffChainVersion(this.getOffChainVersion());
        
        command.setRequesterId(this.getRequesterId());
        command.setCommandId(this.getCommandId());
    }

}