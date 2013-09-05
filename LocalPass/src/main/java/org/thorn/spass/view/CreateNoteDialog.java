package org.thorn.spass.view;

import org.apache.commons.lang.StringUtils;
import org.thorn.core.context.SpringContext;
import org.thorn.core.swing.PositionUtils;
import org.thorn.spass.listener.CreateNoteAction;
import org.thorn.spass.listener.LoadNoteAction;
import org.thorn.spass.service.LocationService;

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
        this.setBounds(PositionUtils.locationInCenter(MFrame.MAIN_FRAME.getBounds(), 270, 240));

        JPanel contentPanel = new JPanel();
        contentPanel.setBorder(BorderFactory.createEmptyBorder(5, 10, 5, 10));
        contentPanel.setLayout(new BoxLayout(contentPanel, BoxLayout.Y_AXIS));

        JPanel labelPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        JLabel label = new JLabel("目录：");
        labelPanel.add(label);
        contentPanel.add(labelPanel);

        folder = new JTextField();
        folder.setEditable(false);
        final JFileChooser fileChooser = new JFileChooser();
        final JDialog thisDialog = this;

        fileChooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);

        LocationService locationService = SpringContext.getBean(LocationService.class);
        String folderPath = locationService.getNotesSaveFolder();
        fileChooser.setCurrentDirectory(new File(folderPath));
        folder.setText(folderPath);

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

        Box columnBox = Box.createHorizontalBox();
        columnBox.add(folder);
        columnBox.add(Box.createHorizontalStrut(5));
        columnBox.add(fileBtn);
        contentPanel.add(columnBox);

        labelPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        label = new JLabel("密码本名称：");
        labelPanel.add(label);
        contentPanel.add(labelPanel);

        noteName = new JTextField();
        noteName.setPreferredSize(new Dimension(noteName.getWidth(), 27));
        contentPanel.add(noteName);

        labelPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        label = new JLabel("密码：");
        labelPanel.add(label);
        contentPanel.add(labelPanel);

        passwordField = new JPasswordField();
        passwordField.setPreferredSize(new Dimension(passwordField.getWidth(), 27));
        contentPanel.add(passwordField);
        contentPanel.add(Box.createVerticalStrut(5));

        JButton button = new JButton();
        this.setTitle("创建新密码本");
        button.setText("创建");
        button.addActionListener(new CreateNoteAction(this, folder, noteName, passwordField));
        contentPanel.add(button);

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
