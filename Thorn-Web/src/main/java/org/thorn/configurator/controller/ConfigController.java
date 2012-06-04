package org.thorn.configurator.controller;

import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.configurator.service.ConfiguratorService;
import org.thorn.web.controller.BaseController;

/** 
 * @ClassName: ConfigController 
 * @Description: 
 * @author chenyun
 * @date 2012-6-4 下午09:11:49 
 */
@Controller
public class ConfigController extends BaseController {
	
	static Logger log = LoggerFactory.getLogger(ConfigController.class);
	
	@Autowired
	@Qualifier("configuratorService")
	private ConfiguratorService service;
	
	@RequestMapping("/cf/getConfigName")
	@ResponseBody
	public Set<String> getAvailableConfig() {
		return service.getConfigName();
	}

	
}

