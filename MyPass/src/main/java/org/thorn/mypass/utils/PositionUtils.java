package org.thorn.mypass.utils;

import java.awt.Rectangle;

public class PositionUtils {

    public static Rectangle locationInCenter(Rectangle parent, int width, int height) {
        double px = parent.getX();
        double py = parent.getY();
        double pWidth = parent.getWidth();
        double pHeight = parent.getHeight();

        Rectangle childRec = new Rectangle();

        int cx = (int) (px + (pWidth - width) / 2);
        int cy = (int) (py + (pHeight - height) / 2);

        childRec.setBounds(cx, cy, width, height);
        return childRec;
    }

}
