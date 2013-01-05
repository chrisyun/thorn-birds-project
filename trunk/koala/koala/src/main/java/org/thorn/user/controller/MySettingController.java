package org.thorn.user.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.thorn.web.controller.BaseController;

/** 
 * @ClassName: MySettingController 
 * @Description: 
 * @author chenyun
 * @date 2013-1-5 下午9:43:47 
 */
@Controller
@RequestMapping("/common/mySetting")
public class MySettingController extends BaseController {

	static Logger log = LoggerFactory.getLogger(UserController.class);
	
	@RequestMapping("/changeMyPassword.jhtml")
	public String changeMyPassword() {
		
		return "mySetting/changePassword";
	}
	
	
}

