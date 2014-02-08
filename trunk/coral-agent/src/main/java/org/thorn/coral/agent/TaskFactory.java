/*
 * @(#)TaskFactory  1.0 2014-01-22
 *
 * Copyright 2009 chinabank payment All Rights Reserved.
 * PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * Author Email: yfchenyun@jd.com
 */
package org.thorn.coral.agent;

import org.apache.commons.lang.StringUtils;
import org.thorn.coral.task.api.Task;

import java.io.File;
import java.io.FileFilter;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashSet;
import java.util.Set;

/**
 * TODO.
 *
 * @author yfchenyun@jd.com, 2014-01-22.
 * @version 1.0
 * @since 1.0
 */
public class TaskFactory {

    private static DirClassLoader cl = new DirClassLoader( new URL[] {} );

    public final static synchronized void reLoad(String dir) {

        File jarFile = new File(dir);

        if(!jarFile.exists()) {
            jarFile.mkdirs();
        }

        Set<URL> jars = new HashSet<URL>();
        listJars(jarFile, jars);

        for(URL url : jars) {
            cl.addURL(url);
        }
    }

    public static Task getTask(String clsName) throws ClassNotFoundException,
            IllegalAccessException, InstantiationException {
        return (Task) cl.loadClass(clsName).newInstance();
    }

    private static void listJars(File dir, Set<URL> jars) {

        File[] files = dir.listFiles(new FileFilter() {

            @Override
            public boolean accept(File file) {

                String fileName = file.getName();
                if(!file.isDirectory() && StringUtils.endsWithIgnoreCase(fileName, ".jar")) {
                    return true;
                }

                return false;
            }
        });

        for(File file : files) {
            try {
                jars.add(file.toURI().toURL());
            } catch (MalformedURLException e) {
                e.printStackTrace();
            }
        }

        File[] dirs = dir.listFiles(new FileFilter() {
            @Override
            public boolean accept(File file) {

                if(file.isDirectory()) {
                    return true;
                }

                return false;
            }
        });

        for(File file : dirs) {
            listJars(file, jars);
        }
    }



}
