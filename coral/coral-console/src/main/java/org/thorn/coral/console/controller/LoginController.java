/*
 * @(#)LoginController  1.0 2014-02-08
 *
 * Copyright 2009 chinabank payment All Rights Reserved.
 * PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * Author Email: yfchenyun@jd.com
 */
package org.thorn.coral.console.controller;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.thorn.coral.console.web.Configuration;
import org.thorn.coral.console.web.SessionData;

import javax.servlet.http.HttpSession;

/**
 * TODO.
 *
 * @author yfchenyun@jd.com, 2014-02-08.
 * @version 1.0
 * @since 1.0
 */
@Controller
public class LoginController {

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        return "login";
    }

    @RequestMapping(value = "/index", method = RequestMethod.POST)
    public String login(String username, String password, HttpSession session, ModelMap modelMap) {

        if (StringUtils.equals(Configuration.ADMIN_USERNAME, username)
                && StringUtils.equals(Configuration.ADMIN_PASSWORD, password)) {
            SessionData sessionData = new SessionData();
            sessionData.setUserId("admin");
            sessionData.setUserName(username);
            session.setAttribute(Configuration.SESSION_USER, sessionData);

            return "redirect:/admin";
        } else {
            modelMap.put("error", "用户名或者密码错误");
            return "login";
        }
    }


}
