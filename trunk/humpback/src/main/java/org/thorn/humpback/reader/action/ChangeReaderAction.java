package org.thorn.humpback.reader.action;

import org.apache.commons.lang.StringUtils;
import org.thorn.core.context.SpringContext;
import org.thorn.humpback.frame.action.AbsAction;
import org.thorn.humpback.reader.entity.PdfConfiguration;
import org.thorn.humpback.reader.service.PdfReader;
import org.thorn.humpback.reader.view.ReaderPanel;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.io.File;

/**
 * @Author: yfchenyun
 * @Since: 13-9-12 下午2:57
 * @Version: 1.0
 */
public class ChangeReaderAction extends AbsAction {

    private ReaderPanel readerPanel;

    public ChangeReaderAction(ReaderPanel readerPanel) {
        super(readerPanel);
        this.readerPanel = readerPanel;
    }

    @Override
    public void action(ActionEvent e) throws Exception {

        PdfConfiguration configuration = readerPanel.getFormData();

        if (StringUtils.isEmpty(configuration.getFilePath())) {
            JOptionPane.showMessageDialog(readerPanel, "请选择要转换的文本文件", "错误", JOptionPane.WARNING_MESSAGE);
        } else if (configuration.getWidth() <= 1f) {
            JOptionPane.showMessageDialog(readerPanel, "请输入PDF文件的宽度", "错误", JOptionPane.WARNING_MESSAGE);
        } else if (configuration.getHeight() <= 1f) {
            JOptionPane.showMessageDialog(readerPanel, "请输入PDF文件的长度", "错误", JOptionPane.WARNING_MESSAGE);
        } else if (configuration.getFontSize() <= 0) {
            JOptionPane.showMessageDialog(readerPanel, "请输入字体大小", "错误", JOptionPane.WARNING_MESSAGE);
        } else if (configuration.getPdfMaxSize() <= 0) {
            JOptionPane.showMessageDialog(readerPanel, "请输入文件大小", "错误", JOptionPane.WARNING_MESSAGE);
        } else {
            PdfReader reader = SpringContext.getBean(PdfReader.class);

            File pdfFile = reader.createPdf(configuration);
            reader.splitPdf(configuration, pdfFile);

            JOptionPane.showMessageDialog(readerPanel, "电子书转换成功", "成功", JOptionPane.INFORMATION_MESSAGE);
        }
    }
}
