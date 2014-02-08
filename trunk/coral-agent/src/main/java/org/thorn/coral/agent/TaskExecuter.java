/*
 * @(#)TaskExecuter  1.0 2014-01-26
 *
 * Copyright 2009 chinabank payment All Rights Reserved.
 * PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * Author Email: yfchenyun@jd.com
 */
package org.thorn.coral.agent;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.remoting.rmi.RmiProxyFactoryBean;
import org.thorn.coral.facade.console.ConsoleFacade;
import org.thorn.coral.facade.console.TaskResult;
import org.thorn.coral.task.api.Task;
import org.thorn.coral.task.api.TaskException;

import java.util.Date;
import java.util.Map;

/**
 * TODO.
 *
 * @author yfchenyun@jd.com, 2014-01-26.
 * @version 1.0
 * @since 1.0
 */
public class TaskExecuter implements Runnable {

    static Logger logger = LoggerFactory.getLogger(TaskExecuter.class);

    private Map<String, String> parameters;

    private Task task;

    private TaskResult taskResult = new TaskResult();

    public TaskExecuter(Map<String, String> parameters, Task task, String taskId, String taskSerialNo) {
        this.parameters = parameters;
        this.task = task;
        this.taskResult.setStartDate(new Date());
        this.taskResult.setTaskId(taskId);
        this.taskResult.setTaskSerialNo(taskSerialNo);

        this.taskResult.setAgentId(AgentNodeInstance.getAgentId());
    }

    @Override
    public void run() {

        try {
            boolean success = task.execute(parameters);

            taskResult.setSuccess(success);
            taskResult.setDesc("Execute task finish.");
        } catch (TaskException e) {
            String error = "Execute task exception, Task[" +
                    task.getClass() + "], parameters[" + parameters.toString() + "]";
            logger.error(error, e);

            taskResult.setSuccess(false);
            taskResult.setDesc(error + " ############ " + e.getMessage());
        }

        taskResult.setFinishDate(new Date());
        taskResult.setConsumingTime(taskResult.getFinishDate().getTime()
                - taskResult.getStartDate().getTime());

        // notify result
        RmiProxyFactoryBean rmiProxyFactoryBean = new RmiProxyFactoryBean();

        try {
            AgentZKClient agentZKClient = SpringContext.getBean(AgentZKClient.class);
            rmiProxyFactoryBean.setServiceUrl(agentZKClient.getConsoleServicePath());
            rmiProxyFactoryBean.setServiceInterface(ConsoleFacade.class);

            ConsoleFacade consoleFacade = (ConsoleFacade) rmiProxyFactoryBean.getObject();
            boolean notifyResult = consoleFacade.notifyTaskResult(taskResult);

            if(!notifyResult) {
                logger.error("Notify console result failure. URL[" +
                        rmiProxyFactoryBean.getServiceUrl() + "], " + taskResult.toString());
            }
        } catch (Exception e) {
            logger.error("Notify console result exception. URL[" +
                    rmiProxyFactoryBean.getServiceUrl() + "], " + taskResult.toString());
        }
    }
}
