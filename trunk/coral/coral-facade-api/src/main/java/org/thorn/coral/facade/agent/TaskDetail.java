/*
 * @(#)TaskDetail  1.0 2014-01-26
 *
 * Copyright 2009 chinabank payment All Rights Reserved.
 * PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * Author Email: yfchenyun@jd.com
 */
package org.thorn.coral.facade.agent;

import java.io.Serializable;
import java.util.Map;

/**
 * TODO.
 *
 * @author yfchenyun@jd.com, 2014-01-26.
 * @version 1.0
 * @since 1.0
 */
public class TaskDetail implements Serializable {

    private static final long serialVersionUID = 8407942533112821622L;

    private String taskCls;

    private Map<String, String> parameters;

    private String taskId;

    private String taskSerialNo;

    public String getTaskCls() {
        return taskCls;
    }

    public void setTaskCls(String taskCls) {
        this.taskCls = taskCls;
    }

    public Map<String, String> getParameters() {
        return parameters;
    }

    public void setParameters(Map<String, String> parameters) {
        this.parameters = parameters;
    }

    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    public String getTaskSerialNo() {
        return taskSerialNo;
    }

    public void setTaskSerialNo(String taskSerialNo) {
        this.taskSerialNo = taskSerialNo;
    }

    @Override
    public String toString() {
        return "TaskDetail{" +
                "taskCls='" + taskCls + '\'' +
                ", parameters=" + parameters +
                ", taskId='" + taskId + '\'' +
                ", taskSerialNo='" + taskSerialNo + '\'' +
                '}';
    }
}
