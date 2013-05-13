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
    private Set<JMenuItem> LoginItem = new HashSet<JMenuItem>();

    public MyPassMenuBar() {
	super();

	// file menu(login\register\switch\exit)
	JMenu sysMenu = new JMenu("File");

	JMenuItem loginItem = new JMenuItem("Login");
	loginItem.addActionListener(MyPassMenuBarListener.loginAction());
	noLoginItem.add(loginItem);
	sysMenu.add(loginItem);

	JMenuItem registerItem = new JMenuItem("Register");
	noLoginItem.add(registerItem);
	sysMenu.add(registerItem);

	JMenuItem switchItem = new JMenuItem("Switch User");
	LoginItem.add(switchItem);
	sysMenu.add(switchItem);

	sysMenu.addSeparator();
	JMenuItem exitItem = new JMenuItem("Exit");
	exitItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_X, Event.CTRL_MASK));
	// exit listener
	exitItem.addActionListener(MyPassMenuBarListener.logoutAction());
	sysMenu.add(exitItem);

	sysMenu.setMnemonic(KeyEvent.VK_F);
	this.add(sysMenu);

	// tool menu(query(data\account))
	JMenu toolMenu = new JMenu("Tool");
	toolMenu.setMnemonic(KeyEvent.VK_T);

	JMenu queryMenu = new JMenu("Query...");

	JMenuItem accountItem = new JMenuItem("Account");
	JMenuItem dataItem = new JMenuItem("Data");
	queryMenu.add(accountItem);
	queryMenu.add(dataItem);
	LoginItem.add(accountItem);
	LoginItem.add(dataItem);

	queryMenu.setMnemonic(KeyEvent.VK_Q);
	toolMenu.add(queryMenu);
	this.add(toolMenu);

	// setting menu(data\password)
	JMenu settingMenu = new JMenu("Setting");
	JMenuItem dlItem = new JMenuItem("Data Location");
	JMenuItem pwdItem = new JMenuItem("Password");
	settingMenu.add(dlItem);
	settingMenu.add(pwdItem);
	LoginItem.add(dlItem);
	LoginItem.add(pwdItem);
	settingMenu.setMnemonic(KeyEvent.VK_S);
	this.add(settingMenu);

	JMenu helpMenu = new JMenu("Help");
	helpMenu.add(new JMenuItem("About MyPass"));
	helpMenu.setMnemonic(KeyEvent.VK_H);
	this.add(helpMenu);
    }

    public void loginAction(boolean isLogin) {

	for (JMenuItem item : noLoginItem) {
	    item.setEnabled(!isLogin);
	}

	for (JMenuItem item : LoginItem) {
	    item.setEnabled(isLogin);
	}
    }

}
