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
import javax.swing.JTextField;

import org.apache.commons.lang.StringUtils;
import org.thorn.core.context.SpringContext;
import org.thorn.mypass.entity.CommonResult;
import org.thorn.mypass.entity.User;
import org.thorn.mypass.service.UserService;

public class RegisterDialog extends CommonDialog {

    private JTextField userText;

    private JPasswordField pwdField;

    private JPasswordField pwdRpField;

    private Box getBox(Component lable, Component comp) {
        return super.getBox(lable, 70, comp, 190, 30);
    }

    public RegisterDialog() {
        super(300, 200);

        JPanel contentPanel = new JPanel();
        contentPanel.setBorder(BorderFactory.createEmptyBorder(5, 20, 5, 20));
        Box rowBox = Box.createVerticalBox();
        contentPanel.add(rowBox);

        JLabel nameLabel = new JLabel("账号：");
        userText = new JTextField();
        rowBox.add(getBox(nameLabel, userText));
        rowBox.add(Box.createVerticalStrut(10));

        JLabel pwdLabel = new JLabel("密码：");
        pwdField = new JPasswordField();
        rowBox.add(getBox(pwdLabel, pwdField));
        rowBox.add(Box.createVerticalStrut(10));

        JLabel pwdRpLabel = new JLabel("重复密码：");
        pwdRpField = new JPasswordField();
        rowBox.add(getBox(pwdRpLabel, pwdRpField));
        rowBox.add(Box.createVerticalStrut(10));

        JButton butOk = new JButton("注册");
        butOk.addActionListener(new AbstractListener() {

            protected Component comp = dialog;

            @Override
            public void action(ActionEvent e) throws Exception {
                String pwd = String.copyValueOf(pwdField.getPassword());
                String rpPwd = String.copyValueOf(pwdRpField.getPassword());
                String userName = userText.getText();

                if (StringUtils.isEmpty(userName)) {
                    JOptionPane.showMessageDialog(dialog, "请输入账号！", "错误",
                            JOptionPane.WARNING_MESSAGE);
                } else if (StringUtils.isEmpty(pwd)) {
                    JOptionPane.showMessageDialog(dialog, "请输入密码！", "错误",
                            JOptionPane.WARNING_MESSAGE);
                } else if (StringUtils.isEmpty(rpPwd)) {
                    JOptionPane.showMessageDialog(dialog, "请再次输入密码！", "错误",
                            JOptionPane.WARNING_MESSAGE);
                } else if (!StringUtils.equals(pwd, rpPwd)) {
                    JOptionPane.showMessageDialog(dialog, "输入的两次密码必须相同！", "错误",
                            JOptionPane.WARNING_MESSAGE);
                } else {

                    UserService userService = SpringContext.getBean("userService");
                    CommonResult<User> result = userService.register(userName, pwd);

                    if (result.isSuccess()) {
                        JOptionPane.showMessageDialog(dialog, "注册成功！", "成功",
                                JOptionPane.INFORMATION_MESSAGE);
                        dialog.setVisible(false);
                        ComponentReference.getMainFrame().doLogin();
                    } else {
                        JOptionPane.showMessageDialog(dialog, result.getMsg(), "失败",
                                JOptionPane.ERROR_MESSAGE);
                    }
                }
            }
        });

        JButton butCancel = new JButton("取消");
        butCancel.addActionListener(new ActionListener() {

            public void actionPerformed(ActionEvent e) {
                dialog.setVisible(false);
            }
        });

        butOk.setPreferredSize(new Dimension(120, 30));
        butCancel.setPreferredSize(new Dimension(120, 30));
        Box colbox = Box.createHorizontalBox();
        colbox.add(butOk);
        colbox.add(Box.createHorizontalStrut(20));
        colbox.add(butCancel);
        rowBox.add(colbox);
        rowBox.add(Box.createVerticalStrut(10));

        super.showDialog("注册账号", contentPanel);
    }

}
