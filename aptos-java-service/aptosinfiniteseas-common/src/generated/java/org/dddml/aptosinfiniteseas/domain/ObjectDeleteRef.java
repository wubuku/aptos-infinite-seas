// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.domain;

import java.io.Serializable;
import org.dddml.aptosinfiniteseas.domain.*;

public class ObjectDeleteRef implements Serializable {
    private String self;

    public String getSelf()
    {
        return this.self;
    }

    public void setSelf(String self)
    {
        this.self = self;
    }

    public ObjectDeleteRef()
    {
    }

    public ObjectDeleteRef(String self)
    {
        this.self = self;
    }

    @Override
    public boolean equals(Object obj)
    {
        if (obj == this) {
            return true;
        }
        if (obj == null || obj.getClass() != this.getClass()) {
            return false;
        }

        ObjectDeleteRef other = (ObjectDeleteRef)obj;
        return true 
            && (self == other.self || (self != null && self.equals(other.self)))
            ;
    }

    @Override
    public int hashCode()
    {
        int hash = 0;
        if (this.self != null) {
            hash += 13 * this.self.hashCode();
        }
        return hash;
    }

    @Override
    public String toString() {
        return "ObjectDeleteRef{" +
                "self=" + '\'' + self + '\'' +
                '}';
    }


}

