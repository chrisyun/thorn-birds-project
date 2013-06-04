package org.thorn.mypass.view;

import java.awt.Event;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.util.HashSet;
import java.util.Set;

import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.KeyStroke;

import org.thorn.mypass.listener.MyPassMenuBarListener;

public class MyPassMenuBar extends JMenuBar {

    private Set<JMenuItem> noLoginItem = new HashSet<JMenuItem>();

    private Set<JMenuItem> loginItem = new HashSet<JMenuItem>();

    public static final String MENU_FILE = "文件(F)";

    public static final String MENU_FILE_LOGIN = "登录";

    public static final String MENU_FILE_REGISTER = "注册账号";

    public static final String MENU_FILE_LOGOUT = "注销";

    public static final String MENU_FILE_EXIT = "退出";

    public static final String MENU_TOOL = "数据(D)";

    public static final String MENU_TOOL_ACCOUNT = "网站账户";

    public static final String MENU_TOOL_DATA = "个人数据";

    public static final String MENU_SETTING = "设置(S)";

    public static final String MENU_SETTING_LOCATION = "数据备份";

    public static final String MENU_SETTING_PASSWORD = "密码修改";

    public static final String MENU_HELP = "帮助(H)";

    public static final String MENU_HELP_ABOUT = "关于 MyPass";

    private ActionListener listener;

    private JMenuItem getJMenuItem(String name, Boolean needLogin, KeyStroke key) {
        JMenuItem item = new JMenuItem(name);

        if (needLogin != null && needLogin) {
            loginItem.add(item);
        } else if (needLogin != null && !needLogin) {
            noLoginItem.add(item);
        }

        if (key != null) {
            item.setAccelerator(key);
        }

        item.addActionListener(listener);
        return item;
    }

    private JMenuItem getJMenuItem(String name, boolean needLogin) {
        return getJMenuItem(name, needLogin, null);
    }

    private JMenuItem getJMenuItem(String name, KeyStroke key) {
        return getJMenuItem(name, null, key);
    }

    private JMenuItem getJMenuItem(String name) {
        return getJMenuItem(name, null, null);
    }

    public MyPassMenuBar() {
        super();

        listener = new MyPassMenuBarListener();

        // file menu(login\register\switch\exit)
        JMenu sysMenu = new JMenu(MENU_FILE);

        sysMenu.add(getJMenuItem(MENU_FILE_LOGIN, false));
        sysMenu.add(getJMenuItem(MENU_FILE_REGISTER, false));
        sysMenu.add(getJMenuItem(MENU_FILE_LOGOUT, true));
        sysMenu.addSeparator();
        sysMenu.add(getJMenuItem(MENU_FILE_EXIT,
                KeyStroke.getKeyStroke(KeyEvent.VK_X, Event.CTRL_MASK)));
        sysMenu.setMnemonic(KeyEvent.VK_F);
        this.add(sysMenu);

        // tool menu(query(data\account))
        JMenu toolMenu = new JMenu(MENU_TOOL);
        toolMenu.add(getJMenuItem(MENU_TOOL_ACCOUNT, true, KeyStroke.getKeyStroke(KeyEvent.VK_W, Event.CTRL_MASK)));
        toolMenu.add(getJMenuItem(MENU_TOOL_DATA, true, KeyStroke.getKeyStroke(KeyEvent.VK_D, Event.CTRL_MASK)));

        toolMenu.setMnemonic(KeyEvent.VK_D);
        this.add(toolMenu);

        // setting menu(data\password)
        JMenu settingMenu = new JMenu(MENU_SETTING);
        settingMenu.add(getJMenuItem(MENU_SETTING_LOCATION, true));
        settingMenu.add(getJMenuItem(MENU_SETTING_PASSWORD, true));
        settingMenu.setMnemonic(KeyEvent.VK_S);
        this.add(settingMenu);

        JMenu helpMenu = new JMenu(MENU_HELP);
        helpMenu.add(getJMenuItem(MENU_HELP_ABOUT));
        helpMenu.setMnemonic(KeyEvent.VK_H);
        this.add(helpMenu);
    }

    public void loginAction(boolean isLogin) {

        for (JMenuItem item : noLoginItem) {
            item.setEnabled(!isLogin);
        }

        for (JMenuItem item : loginItem) {
            item.setEnabled(isLogin);
        }
    }

}
