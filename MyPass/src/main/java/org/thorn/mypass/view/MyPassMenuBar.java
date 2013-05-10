package org.thorn.mypass.view;

import java.awt.Event;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;

import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.KeyStroke;

public class MyPassMenuBar extends JMenuBar {
    
    public MyPassMenuBar() {
	super();
	
	JMenu sysMenu = new JMenu("File");
	sysMenu.add(new JMenuItem("Login"));
	sysMenu.add(new JMenuItem("Register"));
	sysMenu.add(new JMenuItem("Switch User"));
	sysMenu.addSeparator();
	
	JMenuItem exitItem = new JMenuItem("Exit");
	exitItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_X, Event.CTRL_MASK));
	// exit listener
	exitItem.addActionListener(new ActionListener() {
	    
	    public void actionPerformed(ActionEvent e) {
		System.exit(0);
	    }
	});
	
	sysMenu.add(exitItem);
	
	sysMenu.setMnemonic(KeyEvent.VK_F);
	this.add(sysMenu);
	
	JMenu toolMenu = new JMenu("Tool");
	toolMenu.setMnemonic(KeyEvent.VK_T);
	
	JMenu queryMenu = new JMenu("Query...");
	queryMenu.add(new JMenuItem("Account"));
	queryMenu.add(new JMenuItem("Data"));
	queryMenu.setMnemonic(KeyEvent.VK_Q);
	
	toolMenu.add(queryMenu);
	this.add(toolMenu);
	
	JMenu settingMenu = new JMenu("Setting");
	settingMenu.add(new JMenuItem("Data Location"));
	settingMenu.add(new JMenuItem("Password"));
	settingMenu.setMnemonic(KeyEvent.VK_S);
	this.add(settingMenu);
	
	JMenu helpMenu = new JMenu("Help");
	helpMenu.add(new JMenuItem("About MyPass"));
	helpMenu.setMnemonic(KeyEvent.VK_H);
	this.add(helpMenu);
    }
    
    public void disableMenu(boolean isDisable) {
	
	if(isDisable) {
	    
	}
	
	
    }
    
    
}
