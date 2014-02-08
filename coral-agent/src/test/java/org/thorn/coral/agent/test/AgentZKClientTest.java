/*
 * @(#)AgentZKClientTest  1.0 2014-02-07
 *
 * Copyright 2009 chinabank payment All Rights Reserved.
 * PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * Author Email: yfchenyun@jd.com
 */
package org.thorn.coral.agent.test;

import junit.framework.TestCase;
import org.thorn.coral.agent.AgentZKClient;

/**
 * TODO.
 *
 * @author yfchenyun@jd.com, 2014-02-07.
 * @version 1.0
 * @since 1.0
 */
public class AgentZKClientTest extends TestCase {

    private AgentZKClient agentZKClient;

    public void setUp() throws Exception {
        super.setUp();

        agentZKClient = new AgentZKClient("192.168.207.56:2181,192.168.207.57:2181,192.168.207.58:2181",
                "coral", 6000, 6000, "rmi://192.168.0.0:1200");

    }

    public void testRegisterAgent() throws Exception {

        agentZKClient.registerAgent();

        Thread.sleep(Integer.MAX_VALUE);
    }

    public void testGetConsoleServicePath() throws Exception {

    }
}
