/*
 * @(#)AgentFacadeImpl  1.0 2014-01-26
 *
 * Copyright 2009 chinabank payment All Rights Reserved.
 * PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * Author Email: yfchenyun@jd.com
 */
package org.thorn.coral.agent;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.thorn.coral.facade.agent.AgentFacade;
import org.thorn.coral.facade.agent.AgentResult;
import org.thorn.coral.facade.agent.TaskDetail;
import org.thorn.coral.task.api.Task;


/**
 * TODO.
 *
 * @author yfchenyun@jd.com, 2014-01-26.
 * @version 1.0
 * @since 1.0
 */
public class AgentFacadeImpl implements AgentFacade {

    static Logger logger = LoggerFactory.getLogger(AgentFacadeImpl.class);

    private String dir;

    public String getDir() {
        return dir;
    }

    public void setDir(String dir) {
        this.dir = dir;
    }

    @Override
    public AgentResult notifyLoadJars() {
        AgentResult result = new AgentResult();

        try {
            TaskFactory.reLoad(dir);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setError(e.getMessage());
            logger.error("DirClassLoader reload dir jars exception", e);
        }

        return result;
    }

    @Override
    public AgentResult executeTask(TaskDetail taskDetail) {
        AgentResult result = new AgentResult();

        try {
            Task task = TaskFactory.getTask(taskDetail.getTaskCls());

            TaskExecuter executer = new TaskExecuter(taskDetail.getParameters(), task,
                    taskDetail.getTaskId(), taskDetail.getTaskSerialNo());

            new Thread(executer).start();

            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setError(e.getMessage());
            logger.error("Load task class exception", e);
        }

        return result;
    }
}
