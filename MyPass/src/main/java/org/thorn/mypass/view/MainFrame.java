package org.thorn.mypass.view;

import java.awt.BorderLayout;

import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JSplitPane;

import org.thorn.core.context.SpringContext;
import org.thorn.mypass.service.UserService;

public class MainFrame extends JFrame {

    private JPanel contentPane;

    private MyPassMenuBar menuBar;

    /**
     * Create the frame.
     */
    public MainFrame() {
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setBounds(300, 100, 780, 500);
        contentPane = new JPanel();
        contentPane.setLayout(new BorderLayout(0, 0));
        setContentPane(contentPane);

        menuBar = new MyPassMenuBar();
        setJMenuBar(menuBar);
    }

    public void doLogin() throws Exception {
        this.menuBar.loginAction(false);

        UserService userService = SpringContext.getBean("userService");
        String[] combo = userService.getUserCombo();
        
        if(combo == null || combo.length == 0) {
            doRegister();
        } else {
            new LoginDialog(combo);
        }
    }

    public void doRegister() {
        new RegisterDialog();
    }

    public void doModifyPassword() {
        new ModifyPasswordDialog();
    }

    public void queryAccount() {
        AccountTable table = new AccountTable();
        JPanel tablePanel = table.getTablePanel();

        GroupPanel group = new GroupPanel();
        JPanel groupPanel = group.getGroupPanel();

        JSplitPane splitPane = new JSplitPane(
                JSplitPane.HORIZONTAL_SPLIT, true, groupPanel, tablePanel);
        splitPane.setDividerSize(1);
        contentPane.add(splitPane);
        contentPane.updateUI();
    }

    public void doLogout() throws Exception {
        int result = JOptionPane.showConfirmDialog(this, "Do you confirm logout?", "logout", JOptionPane.YES_NO_OPTION,
                JOptionPane.INFORMATION_MESSAGE);
        if (result == JOptionPane.YES_OPTION) {
            doLogin();
        }
    }

    public void loginSuccess() {
        this.menuBar.loginAction(true);
    }

    public void exit() {
        int result = JOptionPane.showConfirmDialog(this, "Do you confirm exit?", "Exit", JOptionPane.YES_NO_OPTION,
                JOptionPane.INFORMATION_MESSAGE);
        if (result == JOptionPane.YES_OPTION) {
            System.exit(0);
        }
    }

}
