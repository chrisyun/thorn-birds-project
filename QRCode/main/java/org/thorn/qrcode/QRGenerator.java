/** 13-6-6 下午3:26 */
package org.thorn.qrcode;

import com.swetake.util.Qrcode;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

/**
 * User: chenyun.chris@gmail.com
 * To change this template use File | Settings | File Templates.
 */
public class QRGenerator {


    public BufferedImage generatQrcode(String text, String imagePath) throws IOException {
        BufferedImage bi = new BufferedImage(275, 275, BufferedImage.TYPE_INT_RGB);
        for (int i = 0; i < 275; i++) {
            for (int j = 0; j < 275; j++) {
                bi.setRGB(j, i, Color.WHITE.getRGB());
            }
        }

        Graphics2D gs = bi.createGraphics();

        gs.setColor(Color.BLACK);

        Qrcode qrcode = new Qrcode();
        qrcode.setQrcodeEncodeMode('B');//N A ...
        qrcode.setQrcodeErrorCorrect('M');//L M Q H
        qrcode.setQrcodeVersion(7);

        boolean[][] rest = qrcode.calQrcode(text.trim().getBytes());

        for (int i = 0; i < rest.length; i++) {
            for (int j = 0; j < rest.length; j++) {
                if (rest[j][i]) {
                    gs.fillRect(j * 6, i * 6, 6, 6);
                }
            }
        }


        File qrImage = new File(imagePath);
        if (!qrImage.getParentFile().exists()) {
            qrImage.getParentFile().mkdirs();
        }

        ImageIO.write(bi, "png", qrImage);

        return bi;
    }
}
