package org.thorn.sailfish.controller;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.thorn.sailfish.core.Configuration;
import org.thorn.sailfish.core.SessionData;

import javax.servlet.http.HttpSession;

/**
 * @Author: yfchenyun
 * @Since: 13-10-15 上午10:12
 * @Version: 1.0
 */
@Controller
@RequestMapping("/am")
public class LoginController {

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(String username, String password, HttpSession session, ModelMap modelMap) {

        if (StringUtils.equals(Configuration.ADMIN_USERNAME, username)
                && StringUtils.equals(Configuration.ADMIN_PASSWORD, password)) {
            SessionData sessionData = new SessionData();
            sessionData.setUserId("admin");
            sessionData.setUserName(username);
            session.setAttribute(Configuration.SESSION_USER, sessionData);

            return "redirect:/am/index";
        } else {
            modelMap.put("error", "用户名或者密码错误");
            return "login";
        }
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String toLogin() {
        return "login";
    }


}
