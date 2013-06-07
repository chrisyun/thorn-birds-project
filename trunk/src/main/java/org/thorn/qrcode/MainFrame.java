/** 13-6-6 下午3:28 */
package org.thorn.qrcode;

import org.apache.commons.lang.StringUtils;
import org.slf4j.LoggerFactory;
import org.slf4j.Logger;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.BufferedImage;
import java.io.IOException;

/**
 * User: chenyun.chris@gmail.com
 * To change this template use File | Settings | File Templates.
 */
public class MainFrame extends JFrame {

    private static Logger log = LoggerFactory.getLogger(MainFrame.class);

    public MainFrame() {

        this.setTitle("二维码生成器");

        JButton btn = new JButton("生成");
        JLabel label = new JLabel("内容：");
        final JTextField input = new JTextField();

        final ImagePanel outputPanel = new ImagePanel();
        outputPanel.setPreferredSize(new Dimension(275, 275));
        outputPanel.setBackground(Color.blue);
        outputPanel.setToolTipText("二维码生成区域");

        final MainFrame frame = this;
        btn.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                String code = input.getText();

                if (StringUtils.isNotBlank(code)) {
                    QRGenerator qrGenerator = new QRGenerator();
                    try {
                        BufferedImage bi = qrGenerator.generatQrcode(code, "d:\\qrcode.png");
                        outputPanel.setBufferedImage(bi);
                        outputPanel.repaint();
                    } catch (IOException ex) {
                        log.error("create qrcode failure", ex);
                        JOptionPane.showMessageDialog(frame, "生成二维码失败：" + ex.getMessage(),
                                "结果提示", JOptionPane.ERROR_MESSAGE);
                    }
                }
            }
        });

        Box hBox = Box.createHorizontalBox();
        hBox.add(label);
        hBox.add(input);
        hBox.add(Box.createHorizontalStrut(3));
        hBox.add(btn);

        Box vBox = Box.createVerticalBox();
        vBox.add(hBox);
        vBox.add(Box.createVerticalStrut(8));
        vBox.add(outputPanel);

        this.setBounds(300, 100, 300, 380);
        JPanel contentPane = new JPanel();
        this.add(contentPane);
        contentPane.setBorder(BorderFactory.createEmptyBorder(2, 2, 2, 2));
        contentPane.add(vBox);
    }


}
