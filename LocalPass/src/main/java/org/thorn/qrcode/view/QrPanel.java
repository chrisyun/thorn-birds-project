package org.thorn.qrcode.view;

import org.thorn.core.context.SpringContext;
import org.thorn.qrcode.listener.QrGenerateAction;
import org.thorn.spass.service.LocationService;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;

/**
 * @Author: yfchenyun
 * @Since: 13-9-12 下午4:12
 * @Version: 1.0
 */
public class QrPanel extends JPanel {

    private JTextField strField;

    private JTextField imageFolder;

    private final static Dimension LabelDimension = new Dimension(85, 25);

    private final static Dimension fieldDimension = new Dimension(250, 27);

    public QrPanel() {
        this.setBorder(BorderFactory.createEmptyBorder(10, 230, 2, 230));

        LocationService locationService = SpringContext.getBean(LocationService.class);
        String dir = locationService.getNotesSaveFolder();

        JPanel formPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        JLabel label = new JLabel("图片目录：");
        label.setPreferredSize(LabelDimension);
        formPanel.add(label);

        imageFolder = new JTextField(dir);
        imageFolder.setPreferredSize(fieldDimension);
        imageFolder.setEditable(false);

        final JFileChooser folderChooser = new JFileChooser();
        folderChooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
        folderChooser.setApproveButtonText("选择目录");
        folderChooser.setDialogTitle("请选择二维图片生成目录");

        final JPanel thisPanel = this;
        JButton fileBtn = new JButton("选择");
        fileBtn.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                int result = folderChooser.showOpenDialog(thisPanel);

                if (result == JFileChooser.APPROVE_OPTION) {
                    File data = folderChooser.getSelectedFile();
                    imageFolder.setText(data.getAbsolutePath());
                }
            }
        });

        formPanel.add(imageFolder);
        formPanel.add(fileBtn);

        this.add(formPanel);
        formPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));

        label = new JLabel("二维码内容：");
        label.setPreferredSize(LabelDimension);
        formPanel.add(label);

        strField = new JTextField();
        strField.setPreferredSize(fieldDimension);

        formPanel.add(label);
        formPanel.add(strField);
        formPanel.add(Box.createHorizontalStrut(60));

        this.add(formPanel);
        this.add(Box.createVerticalStrut(40));
        Box rowBox = Box.createHorizontalBox();

        JButton button = new JButton("生成二维码");
        rowBox.add(Box.createHorizontalStrut(100));
        rowBox.add(button);
        rowBox.add(Box.createHorizontalStrut(100));

        this.add(rowBox);
        this.add(Box.createVerticalStrut(40));

        ImagePanel imagePanel = new ImagePanel();
        imagePanel.setPreferredSize(new Dimension(275,275));

        button.addActionListener(new QrGenerateAction(imagePanel, strField, imageFolder));
        this.add(imagePanel);
    }
}
