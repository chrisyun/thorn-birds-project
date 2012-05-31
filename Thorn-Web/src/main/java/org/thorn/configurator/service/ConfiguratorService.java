package org.thorn.configurator.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Observable;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.Resource;
import org.thorn.core.context.ConfigurationContext;
import org.thorn.core.context.SpringContext;

/** 
 * @ClassName: ConfiguratorService 
 * @Description: 
 * @author chenyun
 * @date 2012-5-30 上午11:26:18 
 */
public class ConfiguratorService extends Observable {
	
	static Logger log = LoggerFactory.getLogger(ConfiguratorService.class);
	
	private Map<String, File> configs = new HashMap<String, File>();
	
	private synchronized void initConfigs() {
		if(configs == null) {
			ConfigurationContext configurer = SpringContext.getBean("propertyConfigurer");
			Resource[] resource = configurer.getResource();
			
			for(Resource res : resource) {
				try {
					configs.put(res.getFilename(), res.getFile());
				} catch (IOException e) {
					log.warn("get resource file error : {}",res.getFilename());
				}
			}
		}
	}
	
	public Set<String> getConfigName() {
		if(configs == null) {
			initConfigs();
		}
		
		Set<String> configNames = configs.keySet();
		return configNames;
	}
	
	
}

