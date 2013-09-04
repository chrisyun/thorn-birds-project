package org.thorn.spass.view;

import org.apache.commons.lang.StringUtils;
import org.thorn.core.swing.PositionUtils;
import org.thorn.spass.listener.LoadNoteAction;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;

/**
 * @Author: yfchenyun
 * @Since: 13-9-3 下午2:27
 * @Version: 1.0
 */
public class NoteDialog extends JDialog {

    private JTextField file;

    private JPasswordField passwordField;

    public NoteDialog(Frame owner, boolean isCreate, final String filePath) {
        super(owner, true);
        this.setBounds(PositionUtils.locationInCenter(MFrame.MAIN_FRAME.getBounds(), 280, 200));

        JPanel contentPanel = new JPanel();
        contentPanel.setBorder(BorderFactory.createEmptyBorder(5, 20, 5, 20));
        Box rowBox = Box.createVerticalBox();
        contentPanel.add(rowBox);

        Box columnBox = Box.createHorizontalBox();

        JLabel label = new JLabel("文件地址：");
        columnBox.add(label);
        columnBox.add(Box.createHorizontalStrut(200));
        rowBox.add(columnBox);
        rowBox.add(Box.createVerticalStrut(5));

        file = new JTextField();
        file.setEditable(false);
        final JFileChooser fileChooser = new JFileChooser();
        final JDialog thisDialog = this;
        if (!isCreate && StringUtils.isNotBlank(filePath)) {
            file.setText(filePath);
            fileChooser.setCurrentDirectory(new File(filePath).getParentFile());
        }
        fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
        fileChooser.setApproveButtonText("选择密码本");
        fileChooser.setDialogTitle("请选择密码本");

        JButton fileBtn = new JButton("选择");
        fileBtn.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                int result = fileChooser.showOpenDialog(thisDialog);

                if (result == JFileChooser.APPROVE_OPTION) {
                    File data = fileChooser.getSelectedFile();
                    file.setText(data.getAbsolutePath());
                }
            }
        });

        columnBox = Box.createHorizontalBox();
        columnBox.add(file);
        columnBox.add(Box.createHorizontalStrut(5));
        columnBox.add(fileBtn);
        rowBox.add(columnBox);
        rowBox.add(Box.createVerticalStrut(10));

        label = new JLabel("密码：");
        columnBox = Box.createHorizontalBox();
        columnBox.add(label);
        columnBox.add(Box.createHorizontalStrut(220));
        rowBox.add(columnBox);
        rowBox.add(Box.createVerticalStrut(5));

        passwordField = new JPasswordField();
        passwordField.setPreferredSize(new Dimension(205, 27));
        rowBox.add(passwordField);
        rowBox.add(Box.createVerticalStrut(10));

        JButton button = new JButton();

        if (isCreate) {
            this.setTitle("创建新密码本");
            button.setText("创建");
        } else {
            this.setTitle("打开密码本");
            button.setText("打开");
        }
        button.addActionListener(new LoadNoteAction(this, file, passwordField, isCreate));

        columnBox = Box.createHorizontalBox();
        columnBox.add(Box.createHorizontalStrut(100));
        columnBox.add(button);
        columnBox.add(Box.createHorizontalStrut(100));
        rowBox.add(columnBox);

        this.setContentPane(contentPanel);
        this.setResizable(false);
        this.setVisible(true);
    }

}
