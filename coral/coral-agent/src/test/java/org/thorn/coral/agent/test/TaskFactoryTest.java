/*
 * @(#)TaskFactoryTest  1.0 2014-01-22
 *
 * Copyright 2009 chinabank payment All Rights Reserved.
 * PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * Author Email: yfchenyun@jd.com
 */
package org.thorn.coral.agent.test;

import junit.framework.TestCase;
import org.thorn.coral.agent.TaskFactory;
import org.thorn.coral.task.api.Task;

/**
 * TODO.
 *
 * @author yfchenyun@jd.com, 2014-01-22.
 * @version 1.0
 * @since 1.0
 */
public class TaskFactoryTest extends TestCase {

    public void setUp() throws Exception {
        super.setUp();

    }

    public void testGetTask() throws Exception {
        String dir = "D:\\CodeSapce\\JavaSpace\\GVN\\coral\\coral-facade-api\\target";
        String cls = "org.thorn.coral.facade.agent.SayTask";

        TaskFactory.reLoad(dir);

        Task task = TaskFactory.getTask(cls);
        task.execute(null);

        TaskFactory.reLoad(dir);
        task = TaskFactory.getTask(cls);
        task.execute(null);
    }
}
