package org.thorn.sailfish.entity;

import org.apache.commons.lang.StringUtils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @Author: yfchenyun
 * @Since: 13-10-16 上午10:11
 * @Version: 1.0
 */
public class Resource {

    private String name;

    private boolean isFormWork;

    private String lastModifyTime;

    private long size;

    public String getName() {
        StringUtils.split(name, ',');

        List<String> list = Arrays.asList(StringUtils.split(name, ','));

        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isFormWork() {
        return isFormWork;
    }

    public void setFormWork(boolean formWork) {
        isFormWork = formWork;
    }

    public String getLastModifyTime() {
        return lastModifyTime;
    }

    public void setLastModifyTime(String lastModifyTime) {
        this.lastModifyTime = lastModifyTime;
    }

    public long getSize() {
        return size;
    }

    public void setSize(long size) {
        this.size = size;
    }
}
