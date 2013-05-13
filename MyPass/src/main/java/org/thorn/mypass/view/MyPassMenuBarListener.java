package org.thorn.mypass.view;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class MyPassMenuBarListener {
    
    public static ActionListener logoutAction() {
	return new ActionListener() {

	    public void actionPerformed(ActionEvent e) {
		System.exit(0);
	    }
	};
    }
    
    public static ActionListener loginAction() {
	return new ActionListener() {
	    
	    public void actionPerformed(ActionEvent e) {
		LoginDialog dialog = new LoginDialog();
		dialog.login();
	    }
	};
    }
}
