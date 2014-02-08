/*
 * @(#)AgentNodeInstance  1.0 2014-02-07
 *
 * Copyright 2009 chinabank payment All Rights Reserved.
 * PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * Author Email: yfchenyun@jd.com
 */
package org.thorn.coral.agent;

/**
 * TODO.
 *
 * @author yfchenyun@jd.com, 2014-02-07.
 * @version 1.0
 * @since 1.0
 */
public class AgentNodeInstance {

    private static String zkNode;

    private static String processName;

    protected static void setNodePath(String nodeName) {
        AgentNodeInstance.zkNode = nodeName;
    }

    protected static void setProcessName(String processName) {
        AgentNodeInstance.processName = processName;
    }

    public static String getAgentId() {
        return AgentNodeInstance.processName + "#" + AgentNodeInstance.zkNode;
    }
}
