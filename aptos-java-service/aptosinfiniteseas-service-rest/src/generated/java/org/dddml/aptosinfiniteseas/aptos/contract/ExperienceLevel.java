// <autogenerated>
//   This file was generated by dddappp code generator.
//   Any changes made to this file manually will be lost next time the file is regenerated.
// </autogenerated>

package org.dddml.aptosinfiniteseas.aptos.contract;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.github.wubuku.aptos.bean.*;

@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class ExperienceLevel {

    private Integer level;

    private Long experience;

    private Long difference;


    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public Long getExperience() {
        return experience;
    }

    public void setExperience(Long experience) {
        this.experience = experience;
    }

    public Long getDifference() {
        return difference;
    }

    public void setDifference(Long difference) {
        this.difference = difference;
    }

    @Override
    public String toString() {
        return "ExperienceLevel{" +
                "level=" + level +
                ", experience=" + experience +
                ", difference=" + difference +
                '}';
    }
}

