/*
 * @(#)TaskResult  1.0 2014-01-22
 *
 * Copyright 2009 chinabank payment All Rights Reserved.
 * PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * Author Email: yfchenyun@jd.com
 */
package org.thorn.coral.facade.console;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * TODO.
 *
 * @author yfchenyun@jd.com, 2014-01-22.
 * @version 1.0
 * @since 1.0
 */
public class TaskResult implements Serializable {

    private boolean success;

    private String desc;

    private String taskId;

    private String agentId;

    private String taskSerialNo;

    private Date startDate;

    private Date finishDate;

    private long consumingTime;

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    public String getAgentId() {
        return agentId;
    }

    public void setAgentId(String agentId) {
        this.agentId = agentId;
    }

    public String getTaskSerialNo() {
        return taskSerialNo;
    }

    public void setTaskSerialNo(String taskSerialNo) {
        this.taskSerialNo = taskSerialNo;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getFinishDate() {
        return finishDate;
    }

    public void setFinishDate(Date finishDate) {
        this.finishDate = finishDate;
    }

    public long getConsumingTime() {
        return consumingTime;
    }

    public void setConsumingTime(long consumingTime) {
        this.consumingTime = consumingTime;
    }

    @Override
    public String toString() {

        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        return "TaskResult{" +
                "success=" + success +
                ", desc='" + desc + '\'' +
                ", taskId='" + taskId + '\'' +
                ", agentId='" + agentId + '\'' +
                ", taskSerialNo='" + taskSerialNo + '\'' +
                ", startDate=" + df.format(startDate) +
                ", finishDate=" + df.format(finishDate) +
                ", consumingTime=" + consumingTime +
                '}';
    }
}
