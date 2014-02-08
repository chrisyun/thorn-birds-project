/*
 * @(#)AgentFacade  1.0 2014-01-26
 *
 * Copyright 2009 chinabank payment All Rights Reserved.
 * PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * Author Email: yfchenyun@jd.com
 */
package org.thorn.coral.facade.agent;

import java.util.Map;

/**
 * TODO.
 *
 * @author yfchenyun@jd.com, 2014-01-26.
 * @version 1.0
 * @since 1.0
 */
public interface AgentFacade {

    public AgentResult notifyLoadJars();

    public AgentResult executeTask(TaskDetail taskDetail);

}
