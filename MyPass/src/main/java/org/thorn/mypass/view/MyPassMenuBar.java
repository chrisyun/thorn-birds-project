package org.thorn.mypass.view;

import java.awt.Event;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.util.HashSet;
import java.util.Set;

import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.KeyStroke;

public class MyPassMenuBar extends JMenuBar {

    private Set<JMenuItem> noLoginItem = new HashSet<JMenuItem>();

    private Set<JMenuItem> loginItem = new HashSet<JMenuItem>();

    public static final String MENU_FILE = "File";

    public static final String MENU_FILE_LOGIN = "Sign in";

    public static final String MENU_FILE_REGISTER = "Register";

    public static final String MENU_FILE_LOGOUT = "Logout";

    public static final String MENU_FILE_EXIT = "Exit";

    public static final String MENU_TOOL = "Tool";

    public static final String MENU_TOOL_ACCOUNT = "Query Account";

    public static final String MENU_TOOL_DATA = "Query Data";

    public static final String MENU_SETTING = "Setting";

    public static final String MENU_SETTING_LOCATION = "Data Location";

    public static final String MENU_SETTING_PASSWORD = "Password";

    public static final String MENU_HELP = "Help";

    public static final String MENU_HELP_ABOUT = "About MyPass";

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
        toolMenu.add(getJMenuItem(MENU_TOOL_ACCOUNT, true));
        toolMenu.add(getJMenuItem(MENU_TOOL_DATA, true));
        
        toolMenu.setMnemonic(KeyEvent.VK_T);
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
