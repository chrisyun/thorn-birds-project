/*
 * @(#)AdminController  1.0 2014-02-08
 *
 * Copyright 2009 chinabank payment All Rights Reserved.
 * PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * Author Email: yfchenyun@jd.com
 */
package org.thorn.coral.console.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * TODO.
 *
 * @author yfchenyun@jd.com, 2014-02-08.
 * @version 1.0
 * @since 1.0
 */
@Controller
public class AdminController {

    @RequestMapping("/admin")
    public String admin() {
        return "index";
    }


}
