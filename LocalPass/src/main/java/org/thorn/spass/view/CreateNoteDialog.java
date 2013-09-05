package org.thorn.spass.view;

import org.apache.commons.lang.StringUtils;
import org.thorn.core.swing.PositionUtils;
import org.thorn.spass.listener.CreateNoteAction;
import org.thorn.spass.listener.LoadNoteAction;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.File;

/**
 * @Author: yfchenyun
 * @Since: 13-9-3 下午2:27
 * @Version: 1.0
 */
public class CreateNoteDialog extends JDialog {

    private JTextField folder;

    private JTextField noteName;

    private JPasswordField passwordField;

    public CreateNoteDialog() {
        super(MFrame.MAIN_FRAME, true);
        this.setBounds(PositionUtils.locationInCenter(MFrame.MAIN_FRAME.getBounds(), 280, 260));

        JPanel contentPanel = new JPanel();
        contentPanel.setBorder(BorderFactory.createEmptyBorder(5, 20, 5, 20));
        Box rowBox = Box.createVerticalBox();
        contentPanel.add(rowBox);

        Box columnBox = Box.createHorizontalBox();

        JLabel label = new JLabel("目录：");
        columnBox.add(label);
        columnBox.add(Box.createHorizontalStrut(220));
        rowBox.add(columnBox);
        rowBox.add(Box.createVerticalStrut(5));

        folder = new JTextField();
        folder.setEditable(false);
        final JFileChooser fileChooser = new JFileChooser();
        final JDialog thisDialog = this;

        fileChooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
        fileChooser.setApproveButtonText("选择密码本存放目录");
        fileChooser.setDialogTitle("请选择目录");

        JButton fileBtn = new JButton("选择");
        fileBtn.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                int result = fileChooser.showOpenDialog(thisDialog);

                if (result == JFileChooser.APPROVE_OPTION) {
                    File data = fileChooser.getSelectedFile();
                    folder.setText(data.getAbsolutePath());
                }
            }
        });

        columnBox = Box.createHorizontalBox();
        columnBox.add(folder);
        columnBox.add(Box.createHorizontalStrut(5));
        columnBox.add(fileBtn);
        rowBox.add(columnBox);
        rowBox.add(Box.createVerticalStrut(10));

        label = new JLabel("密码本名称：");
        columnBox = Box.createHorizontalBox();
        columnBox.add(label);
        columnBox.add(Box.createHorizontalStrut(180));
        rowBox.add(columnBox);
        rowBox.add(Box.createVerticalStrut(5));

        noteName = new JTextField();
        noteName.setPreferredSize(new Dimension(205, 27));
        rowBox.add(noteName);
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

        this.setTitle("创建新密码本");
        button.setText("创建");
        button.addActionListener(new CreateNoteAction(this, folder, noteName, passwordField));

        columnBox = Box.createHorizontalBox();
        columnBox.add(Box.createHorizontalStrut(100));
        columnBox.add(button);
        columnBox.add(Box.createHorizontalStrut(100));
        rowBox.add(columnBox);

        this.addWindowListener(new WindowAdapter() {
            @Override
            public void windowOpened(WindowEvent e) {
                noteName.requestFocus();
            }
        });

        this.setContentPane(contentPanel);
        this.setResizable(false);
        this.setVisible(true);
    }

}
