package org.cy.thorn.core.util.spring;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.util.Assert;

/**
 * <p>文件名称: SpringContextUtils.java</p>
 * <p>文件描述: 以静态变量保存Spring ApplicationContext, 可在任何代码任何地方任何时候中取出ApplicaitonContext</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: web工程中该类会在web容器加载时被初始化;java工程中可通过classpath去创建</p>
 * <p>完成日期: 2011-9-29</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public class SpringContextUtils implements ApplicationContextAware {
	
	static Log logger = LogFactory.getLog(SpringContextUtils.class);
	
	private static ApplicationContext applicationContext = null;
	
	
	public void setApplicationContext(ApplicationContext arg0)
			throws BeansException {
		logger.debug("注入ApplicationContext到SpringContextUtil:" + applicationContext);

		if (SpringContextUtils.applicationContext != null) {
			logger.warn("SpringContextUtil中的ApplicationContext被覆盖, 原有ApplicationContext为:"
					+ SpringContextUtils.applicationContext);
		}

		SpringContextUtils.applicationContext = arg0; //NOSONAR
	}

	/**
	 * 采用classpath创建context
	 */
	public void setApplicationContext(String... configLocations) {
		Assert.noNullElements(configLocations, "configLocations 不能为空.");
		
		logger.debug("注入ApplicationContext到SpringContextUtil:" + applicationContext);

		if (SpringContextUtils.applicationContext != null) {
			logger.warn("SpringContextUtil中的ApplicationContext被覆盖, 原有ApplicationContext为:"
					+ SpringContextUtils.applicationContext);
		}

		SpringContextUtils.applicationContext = new ClassPathXmlApplicationContext(configLocations);
	}

	/**
	 * 实现DisposableBean接口,在Context关闭时清理静态变量.
	 */
	public void destroy() throws Exception {
		SpringContextUtils.clear();
	}

	/**
	 * 取得存储在静态变量中的ApplicationContext.
	 */
	public static ApplicationContext getApplicationContext(){
		return applicationContext;
	}

	/**
	 * 从静态变量applicationContext中取得Bean, 自动转型为所赋值对象的类型.
	 */
	@SuppressWarnings("unchecked")
	public static <T> T getBean(String name) {
		assertContext();
		return (T) applicationContext.getBean(name);
	}

	/**
	 * 从静态变量applicationContext中取得Bean, 自动转型为所赋值对象的类型.
	 */
	public static <T> T getBean(Class<T> requiredType) {
		assertContext();
		return (T) applicationContext.getBean(null, requiredType);
	}

	/**
	 * 清除SpringContextUtil中的ApplicationContext为Null.
	 */
	public static void clear() {
		logger.debug("清除SpringContextUtil中的ApplicationContext:" + applicationContext);
		applicationContext = null;
	}

	/**
	 * 检查ApplicationContext不为空.
	 */
	private static void assertContext() {
		getApplicationContext();
		if (applicationContext == null) {
			throw new IllegalStateException("applicaitonContext为空.");
		}
	}
	
	
}

