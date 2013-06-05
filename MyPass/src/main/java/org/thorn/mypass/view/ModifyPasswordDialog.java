package org.thorn.mypass.view;

import java.awt.Component;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;

import org.apache.commons.lang.StringUtils;

/**
 * @author chenyun
 * @ClassName: ModifyPasswordDialog
 * @Description:
 * @date 2013-5-14 下午10:16:23
 */
public class ModifyPasswordDialog extends CommonDialog {

    private JPasswordField oldPwdField;

    private JPasswordField pwdField;

    private JPasswordField pwdRpField;

    private Box getBox(Component lable, Component comp) {
        return super.getBox(lable, 120, comp, 160, 30);
    }

    public ModifyPasswordDialog() {
        super(320, 200);

        JPanel contentPanel = new JPanel();
        contentPanel.setBorder(BorderFactory.createEmptyBorder(5, 20, 5, 20));
        Box rowBox = Box.createVerticalBox();
        contentPanel.add(rowBox);

        JLabel label1 = new JLabel("当前密码：");
        oldPwdField = new JPasswordField();
        rowBox.add(getBox(label1, oldPwdField));
        rowBox.add(Box.createVerticalStrut(10));

        JLabel label2 = new JLabel("新密码：");
        pwdField = new JPasswordField();
        rowBox.add(getBox(label2, pwdField));
        rowBox.add(Box.createVerticalStrut(10));

        JLabel label3 = new JLabel("重复新密码：");
        pwdRpField = new JPasswordField();
        rowBox.add(getBox(label3, pwdRpField));
        rowBox.add(Box.createVerticalStrut(10));

        JButton butOk = new JButton("修改");
        butOk.addActionListener(new ActionListener() {

            public void actionPerformed(ActionEvent e) {
                String pwd = String.copyValueOf(pwdField.getPassword());
                String rpPwd = String.copyValueOf(pwdRpField.getPassword());
                String oldpwd = String.copyValueOf(oldPwdField.getPassword());

                if (StringUtils.isEmpty(oldpwd)) {
                    JOptionPane.showMessageDialog(dialog, "请输入当前密码！", "错误", JOptionPane.WARNING_MESSAGE);
                } else if (StringUtils.isEmpty(pwd)) {
                    JOptionPane.showMessageDialog(dialog, "请输入新密码！", "错误", JOptionPane.WARNING_MESSAGE);
                } else if (StringUtils.isEmpty(rpPwd)) {
                    JOptionPane.showMessageDialog(dialog, "请再次输入新密码！", "错误", JOptionPane.WARNING_MESSAGE);
                } else if (!StringUtils.equals(pwd, rpPwd)) {
                    JOptionPane.showMessageDialog(dialog, "输入的两次新密码必须相同！", "错误", JOptionPane.WARNING_MESSAGE);
                } else {
                    JOptionPane.showMessageDialog(dialog, "密码修改成功！", "成功", JOptionPane.INFORMATION_MESSAGE);

                    // TODO
                    dialog.setVisible(false);
                }
            }
        });

        JButton butCancel = new JButton("取消");
        butCancel.addActionListener(new ActionListener() {

            public void actionPerformed(ActionEvent e) {
                dialog.setVisible(false);
            }
        });

        butOk.setPreferredSize(new Dimension(130, 30));
        butCancel.setPreferredSize(new Dimension(130, 30));
        Box colbox = Box.createHorizontalBox();
        colbox.add(butOk);
        colbox.add(Box.createHorizontalStrut(20));
        colbox.add(butCancel);
        rowBox.add(colbox);
        rowBox.add(Box.createVerticalStrut(10));

        super.showDialog("密码修改", contentPanel);
    }

}
