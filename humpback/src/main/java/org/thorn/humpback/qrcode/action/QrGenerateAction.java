package org.thorn.humpback.qrcode.action;

import org.apache.commons.lang.StringUtils;
import org.thorn.core.context.SpringContext;
import org.thorn.humpback.frame.action.AbsAction;
import org.thorn.humpback.frame.service.Context;
import org.thorn.humpback.qrcode.service.QrGenerator;
import org.thorn.humpback.qrcode.view.ImagePanel;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.image.BufferedImage;

/**
 * @Author: yfchenyun
 * @Since: 13-9-12 下午5:30
 * @Version: 1.0
 */
public class QrGenerateAction extends AbsAction {

    private static final String DEFAULT_IMAGE_NAME = "qrcode.png";

    private ImagePanel imagePanel;

    private JTextField contextField;

    private JTextField folderField;

    public QrGenerateAction(ImagePanel imagePanel, JTextField contextField, JTextField folderField) {
        super(Context.MAIN_FRAME);
        this.imagePanel = imagePanel;
        this.contextField = contextField;
        this.folderField = folderField;
    }

    @Override
    public void action(ActionEvent e) throws Exception {

        String content = contextField.getText();
        String folder = folderField.getText();

        if (StringUtils.isEmpty(folder)) {
            JOptionPane.showMessageDialog(Context.MAIN_FRAME, "请选择要存放图片的目录", "错误", JOptionPane.WARNING_MESSAGE);
        } else if (StringUtils.isEmpty(content)) {
            JOptionPane.showMessageDialog(Context.MAIN_FRAME, "请输入二维码内容", "错误", JOptionPane.WARNING_MESSAGE);
        } else {
            if (!folder.endsWith("\\")) {
                folder += "\\";
            }

            QrGenerator generator = SpringContext.getBean(QrGenerator.class);
            BufferedImage bi = generator.generate(content, folder + DEFAULT_IMAGE_NAME);
            imagePanel.setBufferedImage(bi);
            imagePanel.repaint();
        }

    }
}
