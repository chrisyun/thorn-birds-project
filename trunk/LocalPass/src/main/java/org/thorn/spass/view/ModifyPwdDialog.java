package org.thorn.spass.view;

import org.thorn.core.swing.PositionUtils;
import org.thorn.spass.listener.ModifyPwdAction;

import javax.swing.*;
import java.awt.*;

/**
 * @Author: yfchenyun
 * @Since: 13-9-5 下午5:33
 * @Version: 1.0
 */
public class ModifyPwdDialog extends JDialog {

    private JPasswordField curPwdField;

    private JPasswordField newPwdField;

    private JPasswordField repeatPwdField;

    private static Dimension labelDimension = new Dimension(80, 27);

    private static Dimension textDimension = new Dimension(220, 27);

    public ModifyPwdDialog() {
        super(MFrame.MAIN_FRAME, true);

        this.setBounds(PositionUtils.locationInCenter(MFrame.MAIN_FRAME.getBounds(), 320, 200));
        this.setTitle("修改密码");

        JPanel contentPanel = new JPanel();

        Box formBox = Box.createVerticalBox();
        formBox.setBorder(BorderFactory.createEmptyBorder(5, 10, 5, 10));

        Box columnBox = Box.createHorizontalBox();
        JLabel label = new JLabel("当前密码：");
        label.setPreferredSize(labelDimension);
        columnBox.add(label);

        curPwdField = new JPasswordField();
        curPwdField.setPreferredSize(textDimension);
        columnBox.add(curPwdField);

        formBox.add(columnBox);
        formBox.add(Box.createVerticalStrut(10));

        columnBox = Box.createHorizontalBox();
        label = new JLabel("新密码：");
        label.setPreferredSize(labelDimension);
        columnBox.add(label);

        newPwdField = new JPasswordField();
        newPwdField.setPreferredSize(textDimension);
        columnBox.add(newPwdField);

        formBox.add(columnBox);
        formBox.add(Box.createVerticalStrut(10));

        columnBox = Box.createHorizontalBox();
        label = new JLabel("重复新密码：");
        label.setPreferredSize(labelDimension);
        columnBox.add(label);

        repeatPwdField = new JPasswordField();
        repeatPwdField.setPreferredSize(textDimension);
        columnBox.add(repeatPwdField);

        formBox.add(columnBox);
        formBox.add(Box.createVerticalStrut(10));

        JButton button = new JButton("修改");
        button.addActionListener(new ModifyPwdAction(this, curPwdField, newPwdField, repeatPwdField));
        formBox.add(button);

        contentPanel.add(formBox);
        this.setContentPane(contentPanel);
        this.setResizable(false);
        this.setVisible(true);
    }
}
