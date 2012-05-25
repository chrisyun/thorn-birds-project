package org.cy.thorn.core.config;

import java.io.IOException;
import java.util.Properties;

import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;

/**
 * <p>文件名称: MyPropertyPlaceholderConfigurer.java</p>
 * <p>文件描述: 读取配置文件的类，spring容器加载时会用此类初始化所有的配置文件</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-9-28</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public class MyPropertyPlaceholderConfigurer extends PropertyPlaceholderConfigurer {
	
	/**
	 * 
	 */
	public MyPropertyPlaceholderConfigurer() {
		super();
	}
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-9-28
	 * @Description：
	 * @return 配置文件的properties对象
	 * @throws IOException
	 */
	public Properties getProperties() throws IOException {
		return this.mergeProperties();
	}
	
}

