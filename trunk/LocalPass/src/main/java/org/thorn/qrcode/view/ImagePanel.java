/** 13-6-6 下午3:30 */
package org.thorn.qrcode.view;

import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;

/**
 * User: chenyun.chris@gmail.com
 * To change this template use File | Settings | File Templates.
 */
public class ImagePanel extends JPanel {


    private static final long serialVersionUID = 1L;

    private BufferedImage bi;

    public void setBufferedImage(BufferedImage bi) {
        this.bi = bi;
    }

    @Override
    protected void paintComponent(Graphics g) {

        super.paintComponent(g);

        if (bi != null) {
            g.drawImage(bi, 0, 0, bi.getWidth(), bi.getHeight(), this);
        }
    }
}
