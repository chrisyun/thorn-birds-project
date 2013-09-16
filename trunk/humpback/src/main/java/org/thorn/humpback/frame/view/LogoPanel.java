package org.thorn.humpback.frame.view;

import org.thorn.core.swing.ImageUtils;

import javax.swing.*;
import java.awt.*;

/**
 * @Author: yfchenyun
 * @Since: 13-9-16 下午5:41
 * @Version: 1.0
 */
public class LogoPanel extends JPanel {

    private Image image;

    public LogoPanel() {
        this.setOpaque(false);
        this.setPreferredSize(new Dimension(580, 480));
        image = ImageUtils.getIconFromCls("/icons/humpback2.png").getImage();
    }

    @Override
    public void paint(Graphics g) {
        g.drawImage(image, 10, 20, 550, 374, null);
        super.paint(g);
    }
}
