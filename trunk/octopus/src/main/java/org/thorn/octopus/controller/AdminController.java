package org.thorn.octopus.controller;

import org.apache.zookeeper.KeeperException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.octopus.core.Status;
import org.thorn.octopus.service.AdminService;

/**
 * @Author: yfchenyun
 * @Since: 13-11-18 下午4:42
 * @Version: 1.0
 */
@Controller
public class AdminController {

    static Logger logger = LoggerFactory.getLogger(AdminController.class);

    @Autowired
    private AdminService adminService;

    @RequestMapping("/login")
    public String login(ModelMap map) {

        try {
            if(adminService.hasInit()) {
                return "login";
            } else {
                return "init";
            }
        } catch (Exception e) {
            logger.error("LoginController login exception", e);
            map.put("error", e);
            return "exception";
        }
    }

    @RequestMapping("/init")
    @ResponseBody
    public Status initSystem(String userId, String password) {
        Status status = new Status();

        try {
            if(adminService.hasInit()) {
                status.setSuccess(false);
                status.setMessage("系统已经初始化完成。");
            } else {

            }
        } catch (Exception e) {
            logger.error("LoginController initSystem exception", e);
            status.setSuccess(false);
            status.setMessage("系统异常：" + e.getMessage());
        }

        return status;
    }

}
