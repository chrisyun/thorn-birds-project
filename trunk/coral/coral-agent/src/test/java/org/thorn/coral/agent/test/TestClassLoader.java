/*
 * @(#)TestClassLoader  1.0 2014-01-21
 *
 * Copyright 2009 chinabank payment All Rights Reserved.
 * PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * Author Email: yfchenyun@jd.com
 */
package org.thorn.coral.agent.test;

import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLClassLoader;

/**
 * TODO.
 *
 * @author yfchenyun@jd.com, 2014-01-21.
 * @version 1.0
 * @since 1.0
 */
public class TestClassLoader {

    public static void main(String[] args) {

        String jarFile = "D:\\CodeSapce\\NPP-IDEA\\common\\target\\common-test-1.0-SNAPSHOT.jar";
        String cls = "org.thorn.coral.agent.test.Dog";


        File file = new File(jarFile);

        try {

            URLClassLoader cl = new URLClassLoader(new URL[]{ file.toURI().toURL() }, TestClassLoader.class.getClassLoader());

            Animal animal = (Animal) cl.loadClass(cls).newInstance();

            System.out.println(animal.say("load success"));

        } catch (MalformedURLException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        } catch (ClassNotFoundException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        } catch (InstantiationException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        } catch (IllegalAccessException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
    }

}
