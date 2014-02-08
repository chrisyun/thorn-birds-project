/*
 * @(#)Launcher  1.0 2014-01-26
 *
 * Copyright 2009 chinabank payment All Rights Reserved.
 * PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * Author Email: yfchenyun@jd.com
 */
package org.thorn.coral.agent;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.lang.management.ManagementFactory;
import java.lang.management.RuntimeMXBean;

/**
 * TODO.
 *
 * @author yfchenyun@jd.com, 2014-01-26.
 * @version 1.0
 * @since 1.0
 */
public class Launcher {

    static Logger logger = LoggerFactory.getLogger(Launcher.class);

    public static void main(String[] args) throws Exception {

        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(
                new String[] { "spring-agent.xml" });
        context.start();

        AgentZKClient agentZKClient = context.getBean(AgentZKClient.class);
        String nodePath = agentZKClient.registerAgent();

        AgentNodeInstance.setNodePath(nodePath);

        RuntimeMXBean runtime = ManagementFactory.getRuntimeMXBean();
        String processName = runtime.getName();

        AgentNodeInstance.setProcessName(processName);

        logger.info("agent node:[" + AgentNodeInstance.getAgentId() +"] startup......");
    }
}
