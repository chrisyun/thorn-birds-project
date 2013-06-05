package org.thorn.mypass.utils;

import java.awt.Image;

import javax.swing.ImageIcon;

/**
 * 图像的简单工具类
 * @author chenyun
 * @date 2013-5-10 下午04:19:12
 */
public class ImageUtils {

    public static ImageIcon getIconFromCls(String url) {
        return new ImageIcon(ImageUtils.class.getResource(url));
    }

}
