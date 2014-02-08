/*
 * @(#)AgentZKClient  1.0 2014-02-07
 *
 * Copyright 2009 chinabank payment All Rights Reserved.
 * PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * Author Email: yfchenyun@jd.com
 */
package org.thorn.coral.agent;

import com.netflix.curator.framework.CuratorFramework;
import com.netflix.curator.framework.CuratorFrameworkFactory;
import com.netflix.curator.retry.RetryNTimes;
import org.apache.commons.lang.StringUtils;
import org.apache.zookeeper.CreateMode;
import org.apache.zookeeper.data.Stat;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * TODO.
 *
 * @author yfchenyun@jd.com, 2014-02-07.
 * @version 1.0
 * @since 1.0
 */
public class AgentZKClient {

    static Logger logger = LoggerFactory.getLogger(AgentZKClient.class);

    private CuratorFramework zkClient;

    private String agentService;

    public AgentZKClient(String zkServers, String namespace,
                         int sessionTimeout, int connectionTimeout, String agentService) {

        zkClient = CuratorFrameworkFactory.builder().connectString(zkServers).namespace(namespace).
                retryPolicy(new RetryNTimes(Integer.MAX_VALUE, 2000)).
                sessionTimeoutMs(sessionTimeout).connectionTimeoutMs(connectionTimeout).build();
        zkClient.start();
        this.agentService = agentService;
    }

    public String registerAgent() throws Exception {

        Stat stat = zkClient.checkExists().forPath("/agent");

        if(stat == null) {
            zkClient.create().withMode(CreateMode.PERSISTENT).forPath("/agent");
        }


        String agentPath = zkClient.create().withMode(CreateMode.EPHEMERAL_SEQUENTIAL).
                forPath("/agent/node-", agentService.getBytes("UTF-8"));

        String nodePath = StringUtils.remove(agentPath, "/agent/");

        logger.info("Agent node register success, nodePath: [" + agentPath + "]");

        return nodePath;
    }


    public String getConsoleServicePath() throws Exception {

        byte[] data = zkClient.getData().forPath("/console/notify");

        return new String(data, "UTF-8");
    }

}
