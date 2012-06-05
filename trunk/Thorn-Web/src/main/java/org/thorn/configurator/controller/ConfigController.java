package org.thorn.configurator.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.dom4j.DocumentException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.configurator.service.ConfiguratorService;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.JsonResponse;
import org.thorn.web.entity.Status;

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
	public Map<String,String> getAvailableConfig() {
		Set<String> names = service.getConfigName();
		
		Map<String,String> map = new HashMap<String, String>();
		for(String key : names) {
			map.put(key, key);
		}
		
		return map;
	}

	@RequestMapping("/cf/getConfig")
	@ResponseBody
	public JsonResponse<Map<String,String>> getConfig(String name) {
		JsonResponse<Map<String,String>> json = new JsonResponse<Map<String,String>>();
		
		if(LocalStringUtils.isEmpty(name)) {
			json.setMessage("配置文件名称为空！");
			json.setSuccess(false);
		} else {
			try {
				Map<String, String> cf = service.getConfigProperty(name);
				json.setObj(cf);
			} catch (DocumentException e) {
				json.setMessage("获取配置文件内容发生错误："+ e.getMessage());
				json.setSuccess(false);
				log.error("getConfig[Map] - " + e.getMessage(), e);
			}
		}
		
		return json;
	}
	
	@RequestMapping("/cf/modifyConfig")
	@ResponseBody
	public Status modifyConfig(String name, Map<String, String> map) {
		
		Status status = new Status();
		
		try {
			service.modifyConfig(name, map);
		} catch (Exception e) {
			status.setMessage("更新配置文件内容发生错误："+ e.getMessage());
			status.setSuccess(false);
			log.error("modifyConfig[Map] - " + e.getMessage(), e);
		}
		
		return status;
	}
	
	
}

