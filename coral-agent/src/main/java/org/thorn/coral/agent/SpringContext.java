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
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.util.Assert;

/**
 * TODO.
 *
 * @author yfchenyun@jd.com, 2014-01-26.
 * @version 1.0
 * @since 1.0
 */
public class SpringContext implements ApplicationContextAware {
	
	static Logger log = LoggerFactory.getLogger(SpringContext.class);
	
	private static ApplicationContext applicationContext = null;
	
	public synchronized void setApplicationContext(ApplicationContext applicationContext)
			throws BeansException {
		log.debug("注入ApplicationContext到SpringContext:" + applicationContext);
		
		if(this.applicationContext != null) {
			log.warn("SpringContext中的ApplicationContext被覆盖");
		}
		
		if(applicationContext == null) {
			log.warn("the args applicationContext is null");
		} else {
			this.applicationContext = applicationContext;
		}
	}
	
	public synchronized void setApplicationContext(String... configLocations) {
		
		log.debug("注入ApplicationContext到SpringContext:" + applicationContext);

		if (this.applicationContext != null) {
			log.warn("SpringContext中的ApplicationContext被覆盖");
		}

		this.applicationContext = new ClassPathXmlApplicationContext(configLocations);
	}
	
	public static ApplicationContext getApplicationContext() {
		
		return applicationContext;
	}

    public static <T> T getBean(Class<T> type) {
        Assert.notNull(applicationContext);
        return applicationContext.getBean(type);
    }

	public static <T> T getBean(String name) {
		Assert.notNull(applicationContext);
		return (T) applicationContext.getBean(name);
	}

}

