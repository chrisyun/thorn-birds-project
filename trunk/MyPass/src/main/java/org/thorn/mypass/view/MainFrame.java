package org.thorn.mypass.view;

import java.awt.BorderLayout;
import java.awt.Font;
import java.util.Enumeration;

import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JSplitPane;
import javax.swing.UIManager;
import javax.swing.plaf.FontUIResource;

import org.thorn.core.swing.GlobalSettingUtils;
import org.thorn.mypass.listener.AccountTableListener;
import org.thorn.mypass.service.ServiceFactory;
import org.thorn.mypass.service.UserService;

public class MainFrame extends JFrame {

    private JPanel contentPane;

    private MyPassMenuBar menuBar;

    /**
     * Create the frame.
     */
    public MainFrame() {

        GlobalSettingUtils.initGlobalFontSetting(new Font("微软雅黑", Font.PLAIN, 12));

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

        UserService userService = ServiceFactory.getInstance().getUserService();
        String[] combo = userService.getUserCombo();

        if (combo == null || combo.length == 0) {
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

    public void queryAccount() throws Exception {
        GroupPanel group = new GroupPanel();
        JPanel groupPanel = group.getGroupPanel();

        AccountTable table = new AccountTable();
        JPanel tablePanel = table.getTablePanel();
        group.registerClickListener(new AccountTableListener(), table, AccountTable.TREE_QUERY);

        JSplitPane splitPane = new JSplitPane(
                JSplitPane.HORIZONTAL_SPLIT, true, groupPanel, tablePanel);
        splitPane.setDividerSize(1);
        contentPane.add(splitPane);
        contentPane.updateUI();
    }

    public void doLogout() throws Exception {
        int result = JOptionPane.showConfirmDialog(this, "是否确认注销账号？", "注销", JOptionPane.YES_NO_OPTION,
                JOptionPane.INFORMATION_MESSAGE);
        if (result == JOptionPane.YES_OPTION) {
            doLogin();
        }
    }

    public void loginSuccess() throws Exception {
        this.menuBar.loginAction(true);
        queryAccount();
    }

    public void exit() {
        int result = JOptionPane.showConfirmDialog(this, "是否确认退出？", "退出", JOptionPane.YES_NO_OPTION,
                JOptionPane.INFORMATION_MESSAGE);
        if (result == JOptionPane.YES_OPTION) {
            System.exit(0);
        }
    }
}
