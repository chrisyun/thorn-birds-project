/*
 * @(#)DirClassLoader  1.0 2014-01-22
 *
 * Copyright 2009 chinabank payment All Rights Reserved.
 * PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * Author Email: yfchenyun@jd.com
 */
package org.thorn.coral.agent;

import java.net.URL;
import java.net.URLClassLoader;
import java.net.URLStreamHandlerFactory;

/**
 * TODO.
 *
 * @author yfchenyun@jd.com, 2014-01-22.
 * @version 1.0
 * @since 1.0
 */
public class DirClassLoader extends URLClassLoader {

    public DirClassLoader(URL[] urls, ClassLoader parent) {
        super(urls, parent);
    }

    public DirClassLoader(URL[] urls) {
        super(urls);
    }

    public DirClassLoader(URL[] urls, ClassLoader parent, URLStreamHandlerFactory factory) {
        super(urls, parent, factory);
    }

    public void addURL(URL url) {
        super.addURL(url);
    }

}
