package org.thorn.mypass.view;

import java.awt.Component;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;

import org.apache.commons.lang.StringUtils;
import org.thorn.core.context.SpringContext;
import org.thorn.mypass.entity.CommonResult;
import org.thorn.mypass.entity.User;
import org.thorn.mypass.service.UserService;

public class LoginDialog extends CommonDialog {

    private JComboBox userCombo;

    private JPasswordField pwdField;

    private Box getBox(Component lable, Component comp) {
        return super.getBox(lable, 80, comp, 160, 30);
    }

    public LoginDialog(String[] users) {
        super(280, 160);

        JPanel contentPanel = new JPanel();
        contentPanel.setBorder(BorderFactory.createEmptyBorder(5, 20, 5, 20));
        Box rowBox = Box.createVerticalBox();
        contentPanel.add(rowBox);

        JLabel nameLabel = new JLabel("Username:");
        userCombo = new JComboBox(users);
        rowBox.add(getBox(nameLabel, userCombo));
        rowBox.add(Box.createVerticalStrut(10));

        JLabel pwdLabel = new JLabel("Password:");
        pwdField = new JPasswordField();
        rowBox.add(getBox(pwdLabel, pwdField));
        rowBox.add(Box.createVerticalStrut(10));

        JButton butOk = new JButton("Sign in");
        butOk.addActionListener(new AbstractListener() {

            protected Component comp = dialog;

            @Override
            public void action(ActionEvent e) throws Exception {
                String pwd = String.copyValueOf(pwdField.getPassword());
                String userName = userCombo.getSelectedItem().toString();

                if (StringUtils.isEmpty(userName)) {
                    JOptionPane.showMessageDialog(dialog, "You need choosing username!", "Checking",
                            JOptionPane.WARNING_MESSAGE);
                } else if (StringUtils.isEmpty(pwd)) {
                    JOptionPane.showMessageDialog(dialog, "You need inputting password!", "Checking",
                            JOptionPane.WARNING_MESSAGE);
                } else {

                    UserService userService = SpringContext.getBean("userService");
                    CommonResult<User> result = userService.login(userName, pwd);

                    if (result.isSuccess()) {
                        dialog.setVisible(false);
                        ComponentReference.getMainFrame().loginSuccess();
                    } else {
                        JOptionPane.showMessageDialog(dialog, result.getMsg(), "Error", JOptionPane.ERROR_MESSAGE);
                    }
                }
            }
        });

        JButton butCancel = new JButton("Cancel");
        butCancel.addActionListener(new ActionListener() {

            public void actionPerformed(ActionEvent e) {
                dialog.setVisible(false);
            }
        });

        butOk.setPreferredSize(new Dimension(110, 30));
        butCancel.setPreferredSize(new Dimension(110, 30));
        Box colbox = Box.createHorizontalBox();
        colbox.add(butOk);
        colbox.add(Box.createHorizontalStrut(20));
        colbox.add(butCancel);
        rowBox.add(colbox);
        rowBox.add(Box.createVerticalStrut(10));

        super.showDialog("Sign in", contentPanel);
    }

}
