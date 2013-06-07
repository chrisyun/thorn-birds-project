/** 13-6-6 下午3:28 */
package org.thorn.qrcode;

import org.apache.commons.lang.StringUtils;
import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import org.thorn.core.swing.GlobalSettingUtils;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

/**
 * User: chenyun.chris@gmail.com
 * To change this template use File | Settings | File Templates.
 */
public class MainFrame extends JFrame {

    private static final String DEFAULT_IMAGE_PATH = "d:\\";

    private static final String DEFAULT_IMAGE_NAME = "qrcode.png";

    private static Logger log = LoggerFactory.getLogger(MainFrame.class);

    public MainFrame() {

        GlobalSettingUtils.initGlobalFontSetting(new Font("微软雅黑", Font.PLAIN, 12));

        this.setTitle("二维码生成器");
        final MainFrame frame = this;

        Dimension labDimension = new Dimension(70, 25);

        JLabel labelFile = new JLabel("图片目录：");
        labelFile.setPreferredSize(labDimension);
        labelFile.setHorizontalAlignment(JLabel.RIGHT);

        final JTextField file = new JTextField(DEFAULT_IMAGE_PATH);
        final JFileChooser fileChooser = new JFileChooser();
        fileChooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
        fileChooser.setApproveButtonText("选择文件夹");
        fileChooser.setDialogTitle("请选择二维码图片保存文件夹");

        JButton fileBtn = new JButton("选择");
        fileBtn.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                int result = fileChooser.showOpenDialog(frame);

                if(result == JFileChooser.APPROVE_OPTION) {
                    File folder = fileChooser.getCurrentDirectory();
                    file.setText(folder.getAbsolutePath());
                }

            }
        });

        JLabel label = new JLabel("内      容：");
        label.setPreferredSize(labDimension);
        label.setHorizontalAlignment(JLabel.RIGHT);

        final JTextField input = new JTextField();

        final ImagePanel outputPanel = new ImagePanel();
        outputPanel.setPreferredSize(new Dimension(275, 275));

        JButton btn = new JButton("生成二维码");
        btn.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                String code = input.getText();

                if (StringUtils.isNotBlank(code)) {

                    String filePath = file.getText();
                    if(StringUtils.isBlank(filePath)) {
                        filePath = DEFAULT_IMAGE_PATH;
                    } else if(!filePath.endsWith("\\")) {
                        filePath += "\\";
                    }

                    QRGenerator qrGenerator = new QRGenerator();
                    try {
                        BufferedImage bi = qrGenerator.generatQrcode(code, filePath + DEFAULT_IMAGE_NAME);
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

        Box vBox = Box.createVerticalBox();

        Box hBox = Box.createHorizontalBox();
        hBox.add(labelFile);
        hBox.add(file);
        hBox.add(fileBtn);
        vBox.add(hBox);
        vBox.add(Box.createVerticalStrut(3));

        hBox = Box.createHorizontalBox();
        hBox.add(label);
        hBox.add(input);
        vBox.add(hBox);
        vBox.add(Box.createVerticalStrut(5));

        hBox = Box.createHorizontalBox();
        hBox.add(Box.createHorizontalStrut(10));
        hBox.add(outputPanel);
        hBox.add(Box.createHorizontalStrut(10));
        hBox.setBorder(BorderFactory.createTitledBorder("二维码图像"));
        vBox.add(hBox);
        vBox.add(Box.createVerticalStrut(3));

        hBox = Box.createHorizontalBox();
        hBox.add(btn);
        vBox.add(hBox);

        this.setBounds(300, 100, 355, 450);
        JPanel contentPane = new JPanel();
        contentPane.setBorder(BorderFactory.createEmptyBorder(5,5,5,5));
        this.add(contentPane);
        contentPane.add(vBox);
    }


}
